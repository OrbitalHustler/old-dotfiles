#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"

podman run --name deb11 -e "TERM=screen-256color" -ti deb11  zsh
# podman run --name deb11 -ti deb11 bash
