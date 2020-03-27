#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    if [[ -e "$DIR/$1" ]]; then
        echo -e "\e[90mlinking $1"
        ln -sf "$DIR/$1" "$HOME/$1"
    else
        echo -e "\e[91mcould not link $1"
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

link_file() {
    if exists "$1"; then
        shift
        for file in "$@"; do
            link "$file"
        done
    fi
}

link_dir() {
    if exists "$1"; then
        rm -rf "$HOME/$2"
        link "$2"
    fi
}

link_in_dir() {
    if exists "$1"; then
        dir="$2"
        shift
        shift
        for file in "$@"; do
            link "$dir/$file"
        done
    fi
}

link_file "zsh" ".zshenv"
link_in_dir "zsh" ".config/zsh" ".zshenv" ".zshrc"
link_in_dir "zsh" ".config/oh-my-zsh/custom" "alias.zsh" "kitty.zsh"
link_in_dir "zsh" ".config/oh-my-zsh/custom/themes" "iyzana.zsh-theme"

link_file "Xorg" ".Xmodmap"  ".xinitrc" ".fehbg"
link_file "tmux" ".tmux.conf"
link_file "git" ".gitconfig"
link_file "nemo" ".gnome2/accels/nemo"

link_dir "termite" ".config/termite"
link_dir "kitty" ".config/kitty"
link_dir "trizen" ".config/trizen"
link_dir "yay" ".config/yay"
link_dir "nvim" ".config/nvim"
link_dir "dunst" ".config/dunst"
link_dir "mako" ".config/mako"
link_dir "sway" ".config/sway"
link_dir "swaylock" ".config/swaylock"
link_dir "waybar" ".config/waybar"
link_dir "zathura" ".config/zathura"
link_dir "i3" ".config/i3"
link_dir "i3status" ".config/i3status"
link_dir "alacritty" ".config/alacritty"

link_in_dir "oni" ".config/oni" "config.js" "config.tsx"

echo -e "\e[32mdone"
