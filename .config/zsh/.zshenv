export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

export PATH=$PATH:/usr/share/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.local/share/cargo/bin:$HOME/.cache/go
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
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export GOPATH="$XDG_CACHE_HOME/go"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export GNUPGHOME="$XDG_DATA_HOME/gpg"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

[ -e "$ZDOTDIR/secrets.zsh" ] && source "$ZDOTDIR/secrets.zsh"
