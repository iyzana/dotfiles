#!/usr/bin/env zsh

PROMPT_PATH_COLOR=$FG[117]
PROMPT_VCS_INFO_COLOR=$FG[242]
GIT_PROMPT_INFO=$FG[012]

local PROMPT_COLOR="%(?.%{$FG[077]%}.%{$FG[001]%})"

PROMPT='%{$PROMPT_COLOR%}ᐅ%{$reset_color%} '
RPROMPT='%{$PROMPT_PATH_COLOR%}%m:%3~%{$reset_color%}%{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[133]%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[118]%}✔"
