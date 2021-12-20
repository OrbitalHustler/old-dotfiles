#!/usr/bin/env bash
set -euo pipefail


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
#. "$DIR/buildcheck.sh"
. "$DIR/base.sh"
. "$DIR/ansi"

if [[ -d ~/.ssh ]]; then
    ansi --green "SSH files chmod..."

    mkdir -pv ~/.ssh/config.d
    chmod 700 ~/.ssh ~/.ssh/config.d
    chmod 600 `find ~/.ssh -type f`
fi
