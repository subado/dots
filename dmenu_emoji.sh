#!/bin/bash

grep -v "#" ~/scripts/emojis.txt | dmenu -i -l 20 -fn "Hack Nerd Font-15" | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
[[ -n $(xclip -o -selection clipboard) ]] && notify-send "$(xclip -o -selection clipboard) copied to clipboard."
