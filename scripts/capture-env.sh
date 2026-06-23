#!/usr/bin/env bash
mkdir -p .build
env | sort | base64 | tr -d '\n' > .build/env-manifest.b64
