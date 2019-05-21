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

alias vim='nvim'
alias sudo='nocorrect sudo ' # expand aliases after sudo

alias ls='exa -l'
alias la='exa -la'
unalias l
unalias ll

# fs helpers

alias md='mkdir -p'
alias rd='rmdir'

td() {
	mkdir -p $1
	cd $1
}

# shorter pipes

alias -g G='| rg'
alias -g W='| wc'
alias -g L='| less'
alias -g S='| sed'
alias -g X='| xargs'
alias -g U='| sort | uniq'
alias -g C='| cuts'

# no I did not mean .config

alias trizen='nocorrect trizen'
alias yay='nocorrect yay'
alias git='nocorrect git'
alias cargo='nocorrect cargo'
alias cuts='nocorrect cuts'

# otherwise too long

alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias glg="glog"

alias youtube-audio='youtube-dl -x -f bestaudio/best --audio-quality 0 --default-search "ytsearch:" --add-metadata --metadata-from-title "(?P<artist>.+?) - (?P<title>.+?)( \(.*\).*)?$" -o "%(title)s.%(ext)s"'

play() {
    mpv --volume 80 --video no \
        --ytdl-format=bestaudio/best \
        --ytdl-raw-options=default-search=ytsearch \
        "ytdl://$*"
}

alias battery='upower -i $(upower -e | grep BAT) | grep percent | awk "{ print \$2 }"'

open() {
    xdg-open $@ &
}

alias irc='ssh -t ctdo tmux a'
