#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install() {
    echo -e "\e[90minstalling $1"
    ln -sf "$DIR/$1" "$HOME/$1"
}

skip() {
    echo -e "\e[33mskipping $1"
}

install_existing() {
    if [[ -f "$HOME/$1" ]]; then
        install "$1"
    else
        skip "$1"
    fi
}

install_dir() {
    if [[ -d "$HOME/$1" ]]; then
        rm -rf "$HOME/$1"
        install "$1"
    else
        skip "$1"
    fi
}

install_in_dir() {
    if [[ -d "$HOME/$1" ]]; then
        dir="$1"
        shift
        for file in "$@"; do
            install "$dir/$file"
        done
    else
        skip "$1"
    fi
}

install ".vimrc"
install ".zshrc"
install ".Xmodmap"
install ".tmux.conf"
install ".gitconfig"
install_existing ".gnome2/accels/nemo"

install_dir ".config/termite"
install_dir ".config/kitty"
install_dir ".config/trizen"
install_dir ".config/yay"
install_dir ".config/nvim"
install_dir ".config/dunst"
install_dir ".config/sway"

install_in_dir ".config/oni" "config.js" "config.tsx"
install_in_dir ".oh-my-zsh/custom" "alias.zsh" "startx.zsh" "kitty.zsh"

echo -e "\e[32mdone"
