#!/bin/bash

prefix="$HOME/books"
book_files=( "$prefix"/*/*\.* )
book_files+=( "$prefix"/*\.* )
book_files=( "${book_files[@]#"$prefix"/}" )
book=$(printf '%s\n' "${book_files[@]}" | dmenu -i -l 10 -fn "Hack Nerd Font-12")

[[ -n $book ]] || exit
zathura "$prefix/$book" &
notify-send "${book#*/} opened."
