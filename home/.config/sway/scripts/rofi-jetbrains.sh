#!/bin/env sh

# shellcheck disable=SC2010 # ls is used for sorting by version number
config_dir=$(ls -v "$HOME/.config/JetBrains" | grep "IntelliJIdea" | tail -n 1)
config_path="$HOME/.config/JetBrains/$config_dir"
recents_path="$config_path/options/recentProjects.xml"

query=".application.component.option | .[] \
	| select(.[\"@name\"] == \"additionalInfo\").map.entry | .[] \
	| { \
	  project: .[\"@key\"], \
		lastOpenend: .value.RecentProjectMetaInfo.option | .[] \
			| select(type == \"object\" and .[\"@name\"] == \"projectOpenTimestamp\") \
			| .[\"@value\"] \
	}"
projects=$(xq "$query" "$recents_path")

paths=$(echo "$projects" \
    | jq --raw-output '.lastOpenend + " " + .project' \
    | sort --reverse --numeric-sort \
    | cut --fields 2 --delimiter=' ' \
    | sed --expression "s#\\\$USER_HOME\\\$/projects/##" \
    | grep --invert-match --fixed-strings "\$USER_HOME\$"
)

selected=$(echo "$paths" | tofi --config ~/.config/tofi/jetbrains)
if [ -n "$selected" ]; then
    swaymsg exec -- intellij-idea-ultimate-edition "$HOME/projects/$selected"
fi
