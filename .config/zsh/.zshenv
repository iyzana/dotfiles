export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

export PATH=$PATH:/usr/share/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.local/share/cargo/bin:$HOME/.cache/go

export EDITOR=/usr/bin/nvim

export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude dosdevices'
export FZF_CTRL_T_COMMAND='fd --type f --follow --exclude dosdevices'
export FZF_ALT_C_COMMAND='fd --type d --follow --exclude dosdevices'

export JAVA_HOME=/usr/lib/jvm/default
export QT_QPA_PLATFORMTHEME='qt5ct'

# don't spam my home folder pls
export GRADLE_USER_HOME="$HOME/.local/share/gradle"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export LESSHISTFILE="$HOME/.cache/less/history"
export GOPATH="$HOME/.cache/go"
