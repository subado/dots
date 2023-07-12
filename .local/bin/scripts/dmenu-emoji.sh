#!/usr/bin/env sh

grep -v "#" "${EMOJI_FILE:-emoji}" | dmenu -i -l 20 -fn "Hack Nerd Font-15" | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
clip="$(xclip -o -selection clipboard)"
[ "$clip" != "" ] && notify-send "$clip copied to clipboard."
