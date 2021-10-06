#!/usr/bin/env zsh

if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

source "$ZINIT_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages
zinit ice wait lucid
zinit snippet OMZ::plugins/colorize
zinit ice wait lucid
zinit snippet OMZ::plugins/command-not-found
zinit ice wait lucid
zinit snippet OMZ::plugins/copydir
zinit ice wait lucid
zinit snippet OMZ::plugins/copyfile
zinit ice wait lucid
zinit snippet OMZ::plugins/cp
zinit ice wait lucid
zinit snippet OMZ::plugins/debian
zinit ice wait lucid
zinit snippet OMZ::plugins/dircycle
zinit ice wait lucid
zinit snippet OMZ::plugins/extract
zinit ice wait lucid
zinit snippet OMZ::plugins/jump
zinit ice wait lucid
zinit snippet OMZ::plugins/mercurial
zinit ice wait lucid
zinit snippet OMZ::plugins/rsync
zinit ice wait lucid
zinit snippet OMZ::plugins/safe-paste
zinit ice svn pick"tmux.plugin.zsh" wait lucid
zinit snippet OMZ::plugins/tmux
zinit ice wait lucid
zinit snippet OMZ::plugins/zoxide
zinit ice wait lucid
zinit snippet OMZ::plugins/common-aliases

# # Bundles from external repos
zinit ice wait lucid
zinit load Tarrasch/zsh-bd
zinit ice wait lucid
zinit load davidde/git
zinit ice wait lucid
zinit load djui/alias-tips
zinit ice wait lucid
zinit load hlissner/zsh-autopair
zinit ice wait lucid
zinit load mdumitru/fancy-ctrl-z
zinit ice wait lucid
zinit load rutchkiwi/copyzshell
zinit ice wait lucid
zinit load wfxr/forgit
zinit ice wait lucid
zinit load jeffreytse/zsh-vi-mode
zinit ice wait lucid
zinit load redxtech/zsh-show-path
# zinit load kutsan/zsh-system-clipboard
zinit ice wait lucid
zinit load zsh-users/zsh-completions

# Direnv hook into zsh
# https://zdharma.github.io/zinit/wiki/Direnv-explanation/
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh" for \
        direnv/direnv

# LS_COLORS managed by zinit
# https://zdharma.github.io/zinit/wiki/LS_COLORS-explanation/
#
zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

# # # Order important
zinit ice wait lucid
zinit load Aloxaf/fzf-tab
zinit ice wait lucid
zinit snippet OMZ::plugins/fzf # after fzf-tab
zinit ice wait lucid
zinit load zsh-users/zsh-syntax-highlighting # last

zicompinit; zicdreplay

# # # Theme
zinit ice depth="1"
zinit load romkatv/powerlevel10k
