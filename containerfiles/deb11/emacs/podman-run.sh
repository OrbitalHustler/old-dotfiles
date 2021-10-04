#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"

mkdir -p output

podman run --name emacs-comp --privileged=true -ti -v ./output/:/root/workspace emacs-comp bash
