# sane defaults
alias more='less'

alias shred='shred -f -n3 -z -u'

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

td() {
  IFS=$'\n' files=($(fd --type file --type symlink --max-depth=3 --full-path ".*${1}.*/todo.*" "$HOME/projects"))
  if [[ "${#files}" -gt 1 ]]; then
    file=$(echo "$files" | fzf --prompt "Which file did you mean?" --reverse)
    if [[ -z "$file" ]]; then
      return
    fi
    vim "$file";
  elif [[ "${#files}" -eq 0 ]]; then
    IFS=$'\n' files=($(fd --type directory --max-depth=3 --full-path ".*${1}.*" "$HOME/projects"))
    if [[ "${#files}" -gt 1 ]]; then
      file=$(echo "$files" | fzf --prompt "Which project did you mean?" --reverse)
      if [[ -z "$file" ]]; then
        return
      fi
      vim "$file/todo.md";
    elif [[ "${#files}" -eq 0 ]]; then
      echo "No matching project found"
    else
      vim "$files/todo.md";
    fi
  else
    vim "$files";
  fi
}

alias ls='exa'
alias ll='exa --long --group-directories-first --binary'
# use all twice to show . and ..
alias la='exa --long --all --all --group --binary --time-style=long-iso'
unalias l

alias ip='ip --color'

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

# lazy loading

nvm() {
  setopt local_options no_aliases
  source /usr/share/nvm/init-nvm.sh # redefines nvm
  if [[ $# != 0 ]]; then
    nvm "$@"
  else
    echo "nvm initialized"
    echo -n "node version: "
    node --version
  fi
}

# otherwise too long

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
    for f in *; do
      if [[ "$f" == "rename.sh" ]]; then
        continue
      fi
      printf 'mv %1$-80s %1$s\n' "\"$f\""
    done > rename.sh
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
  input="$1"
  if [ -z "$input" ]; then
    read input
  fi

  jwt=$(echo "$input" | grep --only "ey[-_+/0-9a-zA-Z=.]*")

  if [ -z "$jwt" ]; then
    jwt="$input"
  fi
  if [ "$jwt" != "$input" ]; then
    echo "\033[31mExtracted jwt from input\033[0m" >&2
    echo >&2
  fi

  # https://unix.stackexchange.com/a/29748
  jwtparts=("${(@f)$(echo "$jwt" | tr '.' '\n')}")

  if [ ${#jwtparts[@]} != 2 ] && [ ${#jwtparts[@]} != 3 ]; then
    echo "not a jwt"
    return 1
  fi

  (
    echo -n '{"header":'
    (echo -n "${jwtparts[1]}" | base64 -id | jq) 2> /dev/null || echo '"'${jwtparts[1]}'"'
    echo -n ',"payload":'
    (echo -n "${jwtparts[2]}" | base64 -id | jq) 2> /dev/null || echo '"'${jwtparts[2]}'"'
    echo -n ',"signature":"'${jwtparts[3]}'"}'
  ) | jq
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

