#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Installing config for existing software"

ln -sf "$DIR/.vimrc" "$HOME/.vimrc"
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DIR/.Xmodmap" "$HOME/.Xmodmap"
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DIR/.gitconfig" "$HOME/.gitconfig"

installdir() {
    if [[ -d "$HOME/$1" ]]; then
        rm -rf "$HOME/$1"
        ln -sf "$DIR/$1" "$HOME/$1"
    fi
}

installdir ".config/termite"
installdir ".config/kitty"
installdir ".config/trizen"
installdir ".config/yay"
installdir ".config/nvim"
installdir ".config/dunst"
installdir ".config/sway"

if [[ -d "$HOME/.config/oni" ]]; then
    ln -sf "$DIR/.config/oni/config.js" "$HOME/.config/oni/config.js"
    ln -sf "$DIR/.config/oni/config.tsx" "$HOME/.config/oni/config.tsx"
fi

if [[ -d "$HOME/.oh-my-zsh/custom" ]]; then
    ln -sf "$DIR/.oh-my-zsh/custom/alias.zsh" "$HOME/.oh-my-zsh/custom/alias.zsh"
    ln -sf "$DIR/.oh-my-zsh/custom/startx.zsh" "$HOME/.oh-my-zsh/custom/startx.zsh"
    ln -sf "$DIR/.oh-my-zsh/custom/kitty.zsh" "$HOME/.oh-my-zsh/custom/kitty.zsh"
fi

if [[ -d "$HOME/.gnome2/accels" ]]; then
    ln -sf "$DIR/.gnome2/accels/nemo" "$HOME/.gnome2/accels/nemo"
fi
