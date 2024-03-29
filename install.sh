#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

set -e
set -o pipefail
shopt -s failglob

link() {
    if [[ -e "$FROM_DIR/$1" ]]; then
        echo -e "\e[90mlinking $1"
        mkdir -p "$(dirname "$TO_DIR/$1")"
        ln -sf "$FROM_DIR/$1" "$TO_DIR/$1"
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
        rm -rf "${TO_DIR:?}/$2"
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

link_local_file() {
    if exists "$1"; then
        shift
        echo -e "\e[90mlinking $1/$3 to $2"
        ln -sf "$2" "$TO_DIR/$1/$3"
    fi
}

echo -e "\e[0mprocessing direcotry $HOME"

FROM_DIR="$DIR/home"
TO_DIR="$HOME"
HOST=$(hostname)

link_file "zsh" ".zshenv"
link_in_dir "zsh" ".config/zsh" ".zshenv" ".zshrc"
link_in_dir "zsh" ".config/oh-my-zsh/custom" "alias.zsh" "kitty.zsh"
link_in_dir "zsh" ".config/oh-my-zsh/custom/themes" "iyzana.zsh-theme"

link_file "Xorg" ".Xmodmap"  ".xinitrc" ".fehbg"
link_file "tmux" ".tmux.conf"
link_file "git" ".gitconfig"
link_file "nemo" ".gnome2/accels/nemo"
link_file "picom" ".config/picom.conf"

link_dir "termite" ".config/termite"
link_dir "kitty" ".config/kitty"
link_dir "yay" ".config/yay"
link_dir "paru" ".config/paru"
link_dir "nvim" ".config/nvim"
link_dir "dunst" ".config/dunst"
link_dir "mako" ".config/mako"
link_dir "sway" ".config/sway"
link_local_file "sway" ".config/sway" "$HOST.conf" "local.conf"
link_dir "swaylock" ".config/swaylock"
link_dir "waybar" ".config/waybar"
link_local_file "waybar" ".config/waybar" "$HOST.conf" "config"
link_dir "wob" ".config/wob"
link_dir "zathura" ".config/zathura"
link_dir "i3" ".config/i3"
link_dir "i3status" ".config/i3status"
link_dir "alacritty" ".config/alacritty"
link_dir "rofi" ".config/rofi"
link_dir "git" ".local/share/git/hooks"
link_dir "direnv" ".config/direnv"
link_dir "tofi" ".config/tofi"

if exists 'firefox'; then
    FROM='.mozilla/firefox/chrome'
    TO_GLOB=("$HOME"/.mozilla/firefox/*.default/chrome)
    TO="${TO_GLOB[0]}"
    rm -rf "$TO"
    echo -e "\e[90mlinking $FROM"
    ln -sf "$FROM_DIR/$FROM" "$TO"
fi

echo -e "\e[0mprocessing direcotry /etc"

sudo bash <<EOF
    $(declare -f link skip exists link_file link_dir link_in_dir link_local_file)
    FROM_DIR="$DIR/etc"
    TO_DIR="/etc"
    HOST=$(hostname)

    link_file "pacman" "pacman.conf";
    link_in_dir "reflector" "pacman.d/hooks" "50-reflector.hook";
EOF

echo -e "\e[32mdone"
