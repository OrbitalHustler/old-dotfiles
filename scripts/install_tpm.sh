#!/usr/bin/env bash

set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
cd $DIR

TMUX_TPM_PATH="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_PATH" ]; then
    mkdir -p "$TMUX_TPM_PATH"
    git clone https://github.com/tmux-plugin/tpm "$TMUX_TPM_PATH"
    ~/.tmux/plugins/tpm/bin/install_plugins
fi
