#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install() {
    if [[ -e "$DIR/$1" ]]; then
        echo -e "\e[90minstalling $1"
        ln -sf "$DIR/$1" "$HOME/$1"
    else
        echo -e "\e[91mcould not install $1"
    fi
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
install_dir ".config/mako"
install_dir ".config/sway"
install_dir ".config/swaylock"
install_dir ".config/zathura"

install_in_dir ".config/oni" "config.js" "config.tsx"
install_in_dir ".oh-my-zsh/custom" "alias.zsh" "startx.zsh" "start-wayland.zsh" "kitty.zsh" "themes/succcubbus.zsh-theme"

echo -e "\e[32mdone"
