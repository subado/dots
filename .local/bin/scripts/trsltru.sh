#!/bin/sh

buf=$(xclip -o -selection clipboard)
dunstify -r 1 -t 50000 'ru' "$(trans -b :ru "$buf")"
