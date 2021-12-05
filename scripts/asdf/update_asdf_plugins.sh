#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/../base.sh"
. "$DIR/../ansi"

ASDF_DIR=${ASDF_DIR:="$HOME/.local/asdf"}
. "$ASDF_DIR/asdf.sh"

PKG_DIR="$CHEZMOI_DIR/package-lists/"
PACKAGES="$PKG_DIR/asdf.packages"

installed_plugins_list=$(asdf plugin list)
function asdf_install_or_update_plugin() {
    plugin=$1
    if [[ $installed_plugins_list == *"$plugin"* ]]; then
        asdf plugin update $1
    else
        asdf plugin add $1
    fi
}

function asdf_get_latest_package_version_available() {
    package=$1
    all_versions=$(asdf list all $package)
    latest_version=$(echo $all_versions | awk '{print $NF}')
    echo $latest_version
}

function asdf_install_package_version_if_needed() {
    package=$1
    version=$2
    if [[ $version == "latest" ]]; then
        version=$(asdf_get_latest_package_version_available $package)
    fi
    installed_versions=$(asdf list $package)
    if [[ ! $installed_versions == *"$version"* ]]; then
        echo "$(ansi --yellow Installing $package $version)"
        asdf install $package $version
    else
        echo "$(ansi --green $package $version is already installed)"
    fi
}

fzf_installed_version="unknown"

while read -r line; do
    package=$(echo "$line" | awk '{print $1}')
    version=$(echo "$line" | awk '{print $2}')
    repo_url=$(echo "$line" | awk '{print $3}')
    asdf_install_or_update_plugin $package
    asdf_install_package_version_if_needed $package $version
    asdf global $package $version
    if [[ $package == "fzf" ]]; then
        fzf_installed_version=$version
    fi
done < "$PACKAGES"

# Regenerate asdf-direnv cached environment
touch "$HOME/.envrc"

echo "$(ansi --green Launching fzf install script)"
FZF_INSTALL_DIR="$HOME/.local/asdf/installs/fzf/$fzf_installed_version"
"$FZF_INSTALL_DIR/install" --completion --key-bindings --no-update-rc
FZF_LINK="$HOME/.local/fzf"
if [ -f "$FZF_LINK" ]; then
    rm -rf "$FZF_LINK"
fi
ln -s "$FZF_INSTALL_DIR" "$HOME/.local/fzf"
