#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"


TMUX_TPM_PATH="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_PATH" ]; then
    mkdir -p "$TMUX_TPM_PATH"
    git clone https://github.com/tmux-plugin/tpm "$TMUX_TPM_PATH"
fi

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
else
    # "$EMACS_PATH/bin/doom" -y sync -e
fi

ASDF_DIR="$HOME/.local/asdf"
if [ ! -d "$ASDF_DIR" ]; then
    git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.8.1
    # TODO I have it in my path currently (the old directory) but I don't know from where!! source $ASDF_DIR/asdf.sh
    asdf plugin-add direnv
    asdf install direnv latest
    asdf global direnv latest
fi

NOTES_PATH="$HOME/.local/bin/notes"
if [ ! -f "$NOTES_PATH" ]; then
    curl -L https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | PREFIX=$HOME/.local bash
fi

FZF_DIR="$HOME/.local/fzf"
FZF_PATH="$FZF_DIR/bin/fzf"
if [ ! -f "$FZF_PATH" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR"
    "$FZF_DIR/install" --all
fi

ZOXIDE_PATH="$HOME/.local/bin/zoxide"
if [ ! -f "$ZOXIDE_PATH" ]; then
    curl -sS https://webinstall.dev/zoxide | bash
fi

LS_COLORS_PATH="$HOME/.local/share/lscolors.sh"
if [ ! -f "$LS_COLORS_PATH" ]; then
    rm -rf /tmp/LS_COLORS && mkdir /tmp/LS_COLORS && curl -L https://api.github.com/repos/trapd00r/LS_COLORS/tarball/master\
        | tar xzf - --directory=/tmp/LS_COLORS --strip=1
( cd /tmp/LS_COLORS && sh install.sh )
fi
