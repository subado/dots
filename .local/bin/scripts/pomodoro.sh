#!/bin/sh

if [ "$(pidof pomodoro.sh)" ]
then
	dunstify -t 5000 "Pomodoro already start"
else
	if [ $# -eq 1 ]
	then
		case "$1" in
			"-work" ) dunstify -t 5000 "Start work for 25min";sleep 25m;dunstify -t 50000000 "Go break";;
			"-break" ) dunstify -t 5000 "Start break for 5min";sleep 5m;dunstify -t 50000000 "Go work";;
		esac
	fi
fi
