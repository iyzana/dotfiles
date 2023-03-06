export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

export NODE_PATH=$NODE_PATH:~/.local/share/yarn/global/node_modules
export IPFS_PATH=$HOME/.local/share/ipfs

export EDITOR=/usr/bin/nvim

export LESS='-RmgiQ'
export MANPAGER="less -R --use-color -Dd+b -Du+C"

export FZF_DEFAULT_OPTS="--history=$HOME/.local/share/fzf-history/history"
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude dosdevices'
export FZF_CTRL_T_COMMAND='fd --type f --follow --exclude dosdevices'
export FZF_ALT_C_COMMAND='fd --type d --max-depth 5 --follow --exclude dosdevices'

export JAVA_HOME=/usr/lib/jvm/default
export QT_QPA_PLATFORMTHEME='qt5ct'

# don't spam my home folder pls
export GRADLE_USER_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/gradle"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/less/history"
export GOPATH="${XDG_CACHE_HOME:-$HOME/.cache}/go"
export NVM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvm"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gpg"
export NODE_REPL_HISTORY="${XDG_DATA_HOME:-$HOME/.local/share}/node_repl_history"
export MOZBUILD_STATE_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/mozbuild"

[ -e "$ZDOTDIR/secrets.zsh" ] && source "$ZDOTDIR/secrets.zsh"
