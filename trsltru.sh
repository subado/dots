#!/bin/sh

buf=$(xclip -o)
dunstify -r 1 -u low -t 50000 'ru' "$(trans -b :ru "$buf")"
