if ! grep 'DISTRIB_ID=Arch' /etc/lsb-release > /dev/null; then
    echo "can only bootstrap arch linux"
    exit
fi

echo "updating package database"
sudo pacman -Sy

is_installed() {
    command -v "$1" > /dev/null
}

install_pacman() {
    if ! is_installed "$1"; then
        echo "installing $1"
        sudo pacman -S "$1" --noconfirm
    fi
}

install_pacman "git"
install_pacman "curl"

if ! is_installed "yay"; then
    echo "installing yay"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg --syncdeps --install --noconfirm
fi

install_command() {
    if ! is_installed "$1"; then
        echo "installing $2"
        yay -S "$2" --noconfirm
    fi
}

install_file() {
    if [ ! -e "$1" ]; then
        echo "installing $2"
        yay -S "$2" --noconfirm
    fi
}

install_command "zsh" "zsh"

if [ ! -e "$HOME/.config/oh-my-zsh" ]; then
    echo "installing oh-my-zsh"
    curl -sSLo /tmp/install-oh-my-zsh.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh 
    export ZSH="$HOME/.config/oh-my-zsh"
    sh /tmp/install-oh-my-zsh.sh --unattended
fi

install_command "nvim" "neovim"

install_command "kitty" "kitty"
install_file "/usr/share/fonts/OTF/FiraCode-Regular.otf" "otf-fira-code" # font in terminal
install_file "/usr/share/fonts/TTF/Roboto-Regular.ttf" "ttf-roboto" # font in Albert
install_file "/usr/share/fonts/noto/NotoSans-Regular.ttf" "noto-fonts" # fallback font
install_file "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc" "noto-fonts-cjk" # asian scripts font
install_file "/usr/share/fonts/noto/NotoColorEmoji.ttf" "noto-font-emoji" # emoji font

sh "$HOME/.dotfiles/install.sh"
