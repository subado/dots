#!/bin/bash

updates=$(xbps-install -un | awk '{print $1}')

case $BUTTON in
	1)
		xbps-install -S >/dev/null 2>&1 &
		notify-send "Synchronize remote repository index files"
		;;
	2) $TERMINAL -e sudo xbps-install -Suy & ;;
	3)
		if [[ $updates != "" ]]; then
			notify-send "$updates"
		fi
		;;
esac
icon="📦"
updatesNum="$(echo -n $updates | wc -l)"

echo "$icon$updatesNum"
