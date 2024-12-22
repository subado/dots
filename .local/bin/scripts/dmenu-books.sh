#!/usr/bin/env sh

path=${BOOKS_DIR:-"$HOME/books"}
cd "$path" || exit 1

book=$(find . -type f ! -path '*/\.*' | cut -c3- | dmenu -i -p "Select a book")

[ -f "$path/$book" ] || exit
xdg-open "$path/$book" & disown
notify-send "${book##*/} opened." & disown
