# sane defaults
alias more='less'
export LESS='-RmgiQ'

alias shred='shred -f -n3 -z -u'

alias gw='gw --console=rich'
alias gradle='gradle --console=rich'

alias unp='unp -U'

alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffplay -hide_banner'

alias du='du -h'
alias df='df -h'
alias rm='rm -I'

vim() {
    kitty @ set-spacing padding=0
    nvim $*
    kitty @ set-spacing padding=default
}

alias ls='exa -l'
alias la='exa -la'
unalias l
unalias ll

# shorter pipes

alias -g G='| rg'
alias -g W='| wc'
alias -g L='| less'
alias -g S='| sort'
alias -g E='| sed'
alias -g X='| xargs'
alias -g U='| sort | uniq'
alias -g C='| cuts'
alias -g H='| head'
alias -g T='| tail'

# no I did not mean .config

alias git='nocorrect git'
alias yay='nocorrect yay'
alias cargo='nocorrect cargo'
alias cuts='nocorrect cuts'

# otherwise too long

markdown() { consolemd $* | less }

alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias glg="glog"

alias youtube-audio='youtube-dl -x -f bestaudio/best --audio-quality 0 --default-search "ytsearch:" --add-metadata --metadata-from-title "(?P<artist>.+?) - (?P<title>.+?)( \(.*\).*)?$" -o "%(title)s.%(ext)s"'

play() {
    mpv --video=no \
        --ytdl-format=bestaudio/best \
        --ytdl-raw-options=default-search=ytsearch \
        "ytdl://$*"
}

alias battery='upower -i $(upower -e | grep BAT) | grep percent | awk "{ print \$2 }"'

open() {
    xdg-open $@ &
}

batch-rename() {
    printf '%-60s\n' $(exa) > rename.sh
    sed -ri -e 's/(.*)/mv \1 \1/' rename.sh
    vim rename.sh
    sh rename.sh
    rm rename.sh
}

alias jc='journalctl'
alias jce='journalctl -eu'
alias jcf='journalctl -fu'
alias jcue='journalctl --user -eu'
alias jcuf='journalctl --user -fu'
