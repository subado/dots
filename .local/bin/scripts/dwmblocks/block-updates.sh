#!/usr/bin/env sh

sudo xbps-install -S >/dev/null 2>&1
updates=$(xbps-install -un | awk '{print $1}')

case $BUTTON in
1)
	message="$updates"
	if [ "$message" = "" ]; then
		message="System is up to date"
	fi
	notify-send "$message"
	;;
2)
	"$TERMINAL" -e sudo xbps-install -Suv &
	;;
esac

icon="📦"
num=$(printf '%s' "$updates" | wc -l)
[ "$updates" ] && num=$((num + 1))
echo "$icon$num"
