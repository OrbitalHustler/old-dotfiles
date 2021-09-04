#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/scripts/base.sh"
. "$DIR/scripts/ansi"

if [[ "$DISTRIB_ID" == "Debian" ]]; then
    if [[ "$DISTRIB_RELEASE" ==  "11" ]]; then
        APT_BUNDLE_FILE="$DIR/package-lists/deb11.packages"
        ansi --green "Using $APT_BUNDLE_FILE bundle file"
        sudo -v
        sudo apt-get update &&\
            sudo apt-get -y full-upgrade &&\
            sudo xargs apt-get -y install <"$APT_BUNDLE_FILE"
    fi
fi
