if hash kitty 2> /dev/null; then
    # this is way to slow
    # kitty + complete setup zsh | source /dev/stdin
    alias icat="kitty +kitten icat"
    alias gdt="git difftool"
    alias gdts="git difftool --staged"
fi
