#!/usr/bin/env zsh

local PROMPT_COLOR="%(?.%{$fg[default]%}.%{$fg[red]%})"
PROMPT_PATH_COLOR=$fg[green]
GIT_PROMPT_INFO=$fg[default]

PROMPT='%{$PROMPT_PATH_COLOR%}%m:%2~ %{$PROMPT_COLOR%}>%{$reset_color%} '
RPROMPT='%{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%}"
ZSH_THEME_GIT_PROMPT_DIRTY="|%{$fg[red]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN="|%{$fg[green]%}✔"
