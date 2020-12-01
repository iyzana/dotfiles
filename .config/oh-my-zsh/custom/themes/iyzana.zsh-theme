#!/usr/bin/env zsh

function preexec() {
  timer=$(date +%s%3N)
}

function precmd() {
  if [ $timer ]; then
    local now=$(date +%s%3N)
    local d_ms=$(($now-$timer))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))
    if ((h > 0)); then elapsed=${h}h${m}m
    elif ((m > 0)); then elapsed=${m}m${s}s
    elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
    elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
    else unset elapsed
    fi

    unset timer
  fi
}

local PROMPT_COLOR="%(?.%{$fg[default]%}.%{$fg[red]%})"
PROMPT_PATH_COLOR=$fg[green]
GIT_PROMPT_INFO=$fg[default]

PROMPT='%{$PROMPT_PATH_COLOR%}%m:%2~ %{$PROMPT_COLOR%}>%{$reset_color%} '
RPROMPT='${elapsed} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%}"
ZSH_THEME_GIT_PROMPT_DIRTY="|%{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="|%{$fg[green]%}✔"
