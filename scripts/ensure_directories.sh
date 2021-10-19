#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

ansi --yellow "Ensuring required directories exist.."
mkdir -pv $HOME/workspace/opt

mkdir -pv $HOME/org/roam

mkdir -pv $HOME/.local/share/applications
mkdir -pv $HOME/.local/tmux/plugins
mkdir -pv $HOME/.vim/autoload
