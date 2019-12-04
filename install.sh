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

exists() {
    if command -V "$1" > /dev/null 2>&1; then
        return 0
    else
        skip "$1"
        return 1
    fi
}

install_file() {
    if exists "$1"; then
        shift
        for file in "$@"; do
            install "$file"
        done
    fi
}

install_dir() {
    if exists "$1"; then
        rm -rf "$HOME/$2"
        install "$2"
    fi
}

install_in_dir() {
    if exists "$1"; then
        dir="$2"
        shift
        shift
        for file in "$@"; do
            install "$dir/$file"
        done
    fi
}

install_file "zsh" ".zshenv"
install_in_dir "zsh" ".config/zsh" ".zshenv" ".zshrc"
install_in_dir "zsh" ".config/oh-my-zsh/custom" "alias.zsh" "startx.zsh" "start-wayland.zsh" "kitty.zsh"
install_in_dir "zsh" ".config/oh-my-zsh/custom/themes" "succcubbus.zsh-theme"

install_file "Xorg" ".Xmodmap"  ".xinitrc" ".fehbg"
install_file "tmux" ".tmux.conf"
install_file "git" ".gitconfig"
install_file "nemo" ".gnome2/accels/nemo"

install_dir "termite" ".config/termite"
install_dir "kitty" ".config/kitty"
install_dir "trizen" ".config/trizen"
install_dir "yay" ".config/yay"
install_dir "nvim" ".config/nvim"
install_dir "dunst" ".config/dunst"
install_dir "mako" ".config/mako"
install_dir "sway" ".config/sway"
install_dir "swaylock" ".config/swaylock"
install_dir "zathura" ".config/zathura"
install_dir "i3" ".config/i3"
install_dir "i3status" ".config/i3status"
install_dir "alacritty" ".config/alacritty"

install_in_dir "oni" ".config/oni" "config.js" "config.tsx"

echo -e "\e[32mdone"
