#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/../base.sh"

PKG_DIR="$CHEZMOI_DIR/package-lists/"
PACKAGES="$PKG_DIR/asdf.packages"

while read line; do
    package=$(echo $line | awk '{print $1}')
    version=$(echo $line | awk '{print $2}')
    asdf plugin-add $package
    asdf install $package $version
    asdf global $package $version
done < $PACKAGES

FZF="$HOME/.local/fzf"
if [ -L "$FZF" ]; then
    rm "$FZF"
fi

if [ ! -f "$FZF" ]; then
    ln -s $(dirname $(dirname $(asdf which fzf))) "$FZF"	
fi
