#!/usr/bin/env bash

# path has unique values
typeset -U PATH
path+=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
path=("$HOME/.local/bin:$HOME/.bin:$HOME/.mybin" $path)
# setup custom completion path
typeset -U FPATH
fpath=("$HOME/.config/zsh/completions" $fpath)

# Zinit
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.local/zinit"

export PROJECT_HOME="$HOME/workspace"
export WORKSPACE="$PROJECT_HOME"
export EDITOR="emacsclient --tty -s tty -a="
#export VISUAL="$HOME/.bin/editor"
export VISUAL="$EDITOR"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"


export ASDF_DIR="$HOME/.local/asdf"
export ASDF_DATA_DIR="$ASDF_DIR"

export FZF_BASE="$HOME/.local/fzf"
#export FZF_DEFAULT_OPTS='--height 30% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border=top --info=inline --preview-window=border-left,wrap --bind=backward-eof:abort,alt-up:preview-page-up,alt-down:preview-page-down,shift-up:preview-half-page-up,shift-down:preview-half-page-down'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
path=("$HOME/.local/cargo/bin" $path)

# less
## nicer highlighting
export PAGER="less -FR"
export BAT_PAGER="less -FR"
export LESS="-FR"

if [ -f "/usr/share/source-highlight/src-hilite-lesspipe.sh" ]; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [ -f "/usr/bin/src-hilite-lesspipe.sh" ]; then
    export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi
if [[ ${PAGER} == 'less' ]]; then
    (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
    (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
    (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
    (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\E[0m'      # Ends standout-mode.
    (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
    (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
    (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
fi

# if (( ${+commands[bat]} )); then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# fi

export ZSH_TMUX_AUTOSTART=true
export ZSH_HIGHLIGHT_MAXLENGTH=512
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"


if [ -f "$HOME/.env-secrets" ]; then
    source "$HOME/.env-secrets"
fi
