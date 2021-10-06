#!/usr/bin/env zsh

. $ASDF_DIR/asdf.sh

## Shortcut for asdf managed direnv
direnv() { asdf exec direnv "$@"; }

# hook direnv into shells
# https://zdharma.github.io/zinit/wiki/Direnv-explanation/
# eval "$(direnv hook zsh)"
# see zinit.zsh for the hook

# Silence direnv loading
_direnv_hook() {
	eval "$(direnv export zsh &> >(egrep -v -e '(^direnv: (loading|export|using))'))"
};

fpath=("$ASDF_DIR/completions" $fpath)
