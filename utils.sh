#!/usr/bin/env bash

PROGRAM="${0##*/}"
GETOPT="getopt"

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ITALIC=$(tput sitm)

[ "$DEBUG" ] && set -x

die() {
	echo "$PROGRAM: $*"
	echo "Try '$PROGRAM --help' for more information."
	exit 1
}

contains() {
	local value="$1"
	shift
	for i in "$@"; do
		if [ "$i" = "$value" ]; then
			return 0
		fi
	done
	return 1
}
