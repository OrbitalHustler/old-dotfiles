#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/../base.sh"

ASDF_DIR=${ASDF_DIR:="$HOME/.local/asdf"}

if [ ! -f "$ASDF_DIR/asdf.sh" ]; then
    git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.8.1
    . "$ASDF_DIR/asdf.sh"
	asdf update
    # . "$DIR/update_asdf_plugins.sh"
fi
