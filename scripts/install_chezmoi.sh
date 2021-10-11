#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/ansi"
. "$DIR/base.sh"

if ! [ -x "$(command -v chezmoi)" ]; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        BINDIR="$MY_BINDIR" sh -c "$(curl -fsLS git.io/chezmoi)" || sh -c "$(wget -qO- git.io/chezmoi)"
        isavailable chezmoi || sudo -v || sudo pacman -S chezmoi --noconfirm
    fi
else
    ansi --yellow "Chezmoi exists, skipping."
fi
