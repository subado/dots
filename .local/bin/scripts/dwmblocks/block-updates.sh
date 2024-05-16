#!/usr/bin/env sh

if command -v xbps-install >/dev/null 2>&1; then
	doas xbps-install -S >/dev/null 2>&1
	updates=$(xbps-install -un | awk '{print $1}')

	case $BUTTON in
	1)
		notify-send "${updates:-System is up to date}"
		;;
	2)
		"$TERMINAL" -e sudo xbps-install -Suv &
		;;
	esac

	icon="📦"
	num=0
	[ "$updates" ] && num=$(echo "$updates" | wc -l)
	echo "$icon$num"
fi
