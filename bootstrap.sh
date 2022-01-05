if ! grep 'DISTRIB_ID=Arch' /etc/lsb-release > /dev/null; then
    echo "can only bootstrap arch linux"
    exit
fi

echo "installing basic packages"
sudo pacman -Syu --needed base-devel git curl

is_installed() {
    command -v "$1" > /dev/null
}

if ! is_installed "paru"; then
    echo "installing paru"
    cd /tmp || exit
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg --syncdeps --install --noconfirm
fi

install_command() {
    if ! is_installed "$1"; then
        echo "installing $2"
        paru -S "$2" --noconfirm
    fi
}

install_file() {
    if [ ! -e "$1" ]; then
        echo "installing $2"
        paru -S "$2" --noconfirm
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
install_file "/usr/share/fonts/TTF/FiraCode-Regular.ttf" "ttf-fira-code" # font in terminal
install_file "/usr/share/fonts/TTF/Roboto-Regular.ttf" "ttf-roboto" # font in Albert
install_file "/usr/share/fonts/noto/NotoSans-Regular.ttf" "noto-fonts" # fallback font
install_file "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc" "noto-fonts-cjk" # asian scripts font
install_file "/usr/share/fonts/noto/NotoColorEmoji.ttf" "noto-fonts-emoji" # emoji font

sh "$HOME/.dotfiles/install.sh"
