#!/usr/bin/env zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
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

#zinit snippet OMZ::plugins/asdf
zinit snippet OMZ::plugins/colored-man-pages
zinit snippet OMZ::plugins/colorize
zinit snippet OMZ::plugins/command-not-found
zinit snippet OMZ::plugins/copydir
zinit snippet OMZ::plugins/copyfile
zinit snippet OMZ::plugins/cp
zinit snippet OMZ::plugins/debian
zinit snippet OMZ::plugins/dircycle
zinit snippet OMZ::plugins/extract
zinit snippet OMZ::plugins/jump
zinit snippet OMZ::plugins/mercurial
zinit snippet OMZ::plugins/rsync
zinit snippet OMZ::plugins/safe-paste
zinit ice svn pick"tmux.plugin.zsh"
zinit snippet OMZ::plugins/tmux
zinit snippet OMZ::plugins/zoxide
zinit snippet OMZ::plugins/zsh_reload
zinit snippet OMZ::plugins/common-aliases

# Bundles from external repos
zinit load Tarrasch/zsh-bd
zinit load davidde/git
zinit load djui/alias-tips
zinit load hlissner/zsh-autopair
zinit load mdumitru/fancy-ctrl-z
zinit load rutchkiwi/copyzshell
zinit load wfxr/forgit
zinit load jeffreytse/zsh-vi-mode
# zinit load kutsan/zsh-system-clipboard
zinit load zsh-users/zsh-completions


# # Order important
zinit load Aloxaf/fzf-tab
zinit snippet OMZ::plugins/fzf # after fzf-tab
zinit load zsh-users/zsh-syntax-highlighting # last

zicompinit; zicdreplay

# # Theme
zinit ice depth="1"
zinit load romkatv/powerlevel10k
