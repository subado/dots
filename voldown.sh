#!/bin/sh

# ALSA
# amixer set Master 1-
# dunstify -t 1000 -r 3 -u low " $(amixer get Master | sed -rn '$s/[^[]+\[([0-9]+%).*/\1/p')"

# Pulseaudio
num=$(pactl list sinks | awk '$1=="Sink" {print $2}' | sed 's/#//')
pactl set-sink-volume $num -1%
dunstify -t 1000 -r 3 -u low "󰝞 $(pactl get-sink-volume $num | awk '$1=="Volume:" {print $5}')"
