#!/bin/sh

buf=$(xclip -o)
dunstify -r 2 -u low -t 50000 'en' "$(trans -b :en "$buf")"
