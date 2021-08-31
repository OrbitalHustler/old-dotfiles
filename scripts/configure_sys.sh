#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"

if [[ "$DISTRIB_ID" == "Debian" ]]; then
    if [[ "$DISTRIB_RELEASE" == "11" ]]; then
        source "$DIR/set_debian11_defaults.sh"
    else
        echo "Unsupported Debian version $DISTRIB_RELEASE"
    fi
else
    echo "Unknown distribution $DISTRIB_ID"
fi
