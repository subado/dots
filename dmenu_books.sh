#!/bin/bash

path="$HOME/books/"
#book_files=$(find ${path} -type f ! -path "${path}.*" |  sed "s|^${path}||")
IFS=$'\n' read -d '' -a book_files < <(find ${path} -type f ! -path "${path}.*")

for i in "${!book_files[@]}";
do
  book_files[$i]="${book_files[$i]#$path}"
done
book=$(printf '%s\n' "${book_files[@]}" | dmenu -i -l 10 -fn "Hack Nerd Font-12")

[[ -n $book ]] || exit
zathura "$path$book" &
notify-send "${book#*/} opened."
