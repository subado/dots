#!/usr/bin/env sh

path=${BOOKS_DIR:-"$HOME/books"}
cd "$path" || exit 1

book=$(find . -type f ! -path '*/\.*' | cut -c3- | dmenu -i -l 10 -fn "Hack Nerd Font-12")

[ -f "$path/$book" ] || exit
xdg-open "$path/$book" &
notify-send "${book##*/} opened."
