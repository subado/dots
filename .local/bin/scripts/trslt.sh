#!/bin/sh


pattern=$'\e\[(1|22|4|24)m'

buf=$(xclip -o -selection clipboard | tr '\n' ' ')
dunstify -r 2 -u low -t 50000 "$1" "$(trans -show-languages n -no-warn -show-translation-phonetics y -show-translation n -show-prompt-message n -indent 2 "$1" "$buf" | 
	sed -r "s/$pattern//g"
)"
