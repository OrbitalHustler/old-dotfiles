#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
cd $DIR

VIM_PLUG_PATH="$HOME/.vim/autoload"
if [ ! -d "$VIM_PLUG_PATH" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

VIM_SENSIBLE_DIR="$HOME/.vim/pack/tpope/start/sensible"
if [ ! -d "$VIM_SENSIBLE_DIR" ]; then
    mkdir -p ~/.vim/pack/tpope/start
    ( cd ~/.vim/pack/tpope/start && git clone https://tpope.io/vim/sensible.git )
fi

# TODO: what is this for?
BASE16_PATH="$HOME/.config/base16-shell"
if [ ! -d "$BASE16_PATH" ]; then
    mkdir -p "$BASE16_PATH"
    git clone https://github.com/chriskempson/base16-shell "$BASE16_PATH"
fi

EMACS_PATH="$HOME/.emacs.d"
if [ ! -f "$EMACS_PATH/bin/doom" ]; then
    mkdir -p "$EMACS_PATH"
    git clone --depth 1 https://github.com/hlissner/doom-emacs "$EMACS_PATH"
    # "$EMACS_PATH/bin/doom" -y install
# else
# "$EMACS_PATH/bin/doom" -y sync -e
fi


# NOTES_PATH="$HOME/.local/bin/notes"
# if [ ! -f "$NOTES_PATH" ]; then
#     curl -L https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | PREFIX=$HOME/.local bash
# fi

