#!/usr/bin/env bash

set -e

char_sources=(/usr/lib/python3.11/site-packages/picker/data/{arrows,block_elements,box_drawing,braille_patterns,control_pictures,domino_tiles,enclosed_alphanumeric_supplement,enclosed_alphanumerics,general_punctuation,ideographic_description_characters,latin-1_supplement,letterlike_symbols,math,mathematical_operators,miscellaneous_mathematical_symbols-a,miscellaneous_mathematical_symbols-b,playing_cards,specials}.csv)

cache_dir="$HOME/.cache/picker/unicode"
char_file="$cache_dir/all"
state_dir="$HOME/.local/state/picker/unicode"
hist_file="$state_dir/history"

mkdir -p "$cache_dir"
cat "${char_sources[@]}" \
	| awk '!seen[$0]++' \
	> "$char_file"

mkdir -p "$state_dir"
if [ ! -e "$hist_file" ]; then
	echo END >> "$hist_file"
fi

mru_sorted=$(awk 'FNR == NR { lineno[$1] = NR; next }
     {print lineno[$1] == "" ? "999999" : lineno[$1], $0;}' \
			 "$hist_file" \
			 "$char_file" \
		 | sort -k 1,1n -s \
		 | cut -d' ' -f2-)

selection=$(echo "$mru_sorted" | fzf --layout=reverse --color=16 --info=right --prompt='Unicode Character > ' --tiebreak=index)

echo "$selection" | cat - "$hist_file" >> "$hist_file.tmp"
nl "$hist_file.tmp" |sort -k2 -k 1,1n|uniq -f1|sort -n|cut -f2| head -n 30 > "$hist_file"
rm "$hist_file.tmp"

swaymsg move scratchpad
sleep .05 # quickly accepting focus is seemingly too hard for an electron app
echo "$selection" | cut -d' ' -f1 | tr -d '\n' | wtype -
