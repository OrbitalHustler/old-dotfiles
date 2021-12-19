#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

ansi --yellow "Updating ~/.env-secrets.gpg"

NL=$'\n'

file=""

bw_token=""
# Login and set the token if successful
function bw_login() {
    bw login --check > /dev/null 2>&1
    local logged_in=$?
    if [ $logged_in = 1 ]; then
        echo "Logging into Bitwarden"
        bw_token=$(bw login --raw $CHEZMOI_EMAIL)
    else
        bw unlock --check > /dev/null 2>&1
        local unlocked=$?
        if [ $unlocked = 1 ]; then
            echo "Unlocking Bitwarden vault"
            bw_token=$(bw unlock --raw)
        else
            echo "Bitwarden vault unlocked"
            bw_token=$BW_SESSION
        fi
    fi
    echo
}

if [[ -v CHEZMOI_SECRETS ]]; then
    ansi --yellow "CHEZMOI_SECRETS is set, setting BW_SESSION"
    if ! command -v bw > /dev/null; then
        ansi --red "Bitwarden executable bw not available"
    else
        bw_login
        if [ -z "$bw_token" ]; then
            ansi --red "Bitwarden login failed. Please run the script again."
        else
            file="$file${NL}export BW_SESSION=$bw_token"
        fi
    fi
fi

echo "$file" | gpg --encrypt -a -r $CHEZMOI_EMAIL > "$HOME/.env-secrets.gpg"
