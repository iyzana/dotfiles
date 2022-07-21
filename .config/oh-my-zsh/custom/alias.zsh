# sane defaults
alias more='less'

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
    if [[ "$TERM" = "xterm-kitty" ]] && command -v kitty > /dev/null; then
        # kitty @ set-colors "$HOME/.config/oh-my-zsh/custom/kitty-bg.conf"
        kitty @ set-spacing padding=0
        nvim $*
        kitty @ set-spacing padding=default
        # kitty @ set-colors --reset
    else
        nvim $*
    fi
}

alias ls='exa --long --group-directories-first --binary'
alias la='exa --long --all --group-directories-first --binary'
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
alias -g C='| choose'
alias -g H='| head'
alias -g T='| tail'

# no I did not mean .config

alias git='nocorrect git'
alias cargo='nocorrect cargo'
alias cuts='nocorrect cuts'

# lazy loading

nvm() {
  source ~/.nvm/nvm.sh # redefines nvm
  if [[ $# != 0 ]]; then
    nvm "$@"
  else
    echo "nvm initialized"
  fi
}

# otherwise too long

markdown() { consolemd $* | less }

alias lg='lazygit'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

alias yt-audio='yt-dlp -x -f bestaudio/best --audio-quality 0 --default-search "ytsearch:" --add-metadata --metadata-from-title "(?P<artist>.+?) - (?P<title>.+?)( \(.*\).*)?$" -o "%(title)s.%(ext)s"'

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

jwtdecode() {
  jwt="$1"
  if [ -z "$jwt" ]; then
    read jwt
  fi

  # https://unix.stackexchange.com/a/29748
  jwtparts=("${(@f)$(echo "$jwt" | tr '.' '\n')}")

  if [ ${#jwtparts[@]} != 3 ]; then
    echo "not a jwt"
    return 1
  fi

  echo "HEADER"
  (echo "${jwtparts[1]}" | base64 -id | jq) 2> /dev/null || echo "${jwtparts[1]}" | fold -w 80
  echo
  echo "PAYLOAD"
  (echo "${jwtparts[2]}" | base64 -id | jq) 2> /dev/null || echo "${jwtparts[2]}" | fold -w 80
  echo
  echo "SIGNATURE «unverified»"
  echo "${jwtparts[3]}" | fold -w 80
}

# bad netizen
function ping() {
    if [[ $@ == "netflix.com" || $@ == "duckduckgo.com" ]]; then
      echo "$@ is a bad netizen";
      (exit 2);
    else
      command ping "$@";
    fi
}

