#!/bin/sh

# ALSA
# amixer set Master toggle
# if amixer get Master | tail -n1 | grep -qF '[on]'
# then
# 	dunstify -t 1000 -r 3 -u low " Unmute"
# else
# 	dunstify -t 1000 -r 3 -u low " Mute"
# fi

# Pulseaudio
num=$(pactl list sinks | awk '$1=="Sink" {print $2}' | sed 's/#//')
pactl set-sink-mute $num toggle
speaker="󰕾"
if [ $(pactl get-sink-mute $num | awk '{print $2}') = "yes" ]; then
	speaker="󰖁"
fi
dunstify -t 1000 -r 3 -u low "$speaker"
