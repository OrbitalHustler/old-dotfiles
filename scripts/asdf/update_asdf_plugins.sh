#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/../base.sh"

PKG_DIR="$CHEZMOI_DIR/package-lists/"
PACKAGES="$PKG_DIR/asdf.packages"

while read -r line; do
    package=$(echo "$line" | awk '{print $1}')
    version=$(echo "$line" | awk '{print $2}')
    repo_url=$(echo "$line" | awk '{print $3}')
    asdf plugin-add "$package" "$repo_url"
    asdf install "$package" "$version"
    asdf global "$package" "$version"
done < "$PACKAGES"

# Regenerate asdf-direnv cached environment
touch "$HOME/.envrc"

FZF="$HOME/.local/fzf"
if [ -L "$FZF" ]; then
    rm "$FZF"
fi

if [ ! -f "$FZF" ]; then
    ln -s "$(dirname "$(dirname "$(asdf which fzf)")")" "$FZF"
    "$FZF/install" --completion --key-bindings --no-update-rc
fi
