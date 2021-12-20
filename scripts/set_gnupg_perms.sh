#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

if [[ -d "$HOME/.gnupg" ]]; then
    ansi --green "Changing GnuPG permissions.."

    chown -R "$(whoami)" ~/.gnupg/

    mkdir -pv ~/.gnupg/private-keys-v1.d
    chmod 700 ~/.gnupg ~/.gnupg/private-keys-v1.d
    chmod 600 `find ~/.gnupg -type f`
fi
