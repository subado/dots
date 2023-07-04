#!/usr/bin/env sh

PROGRAM="${0##*/}"
GETOPT="getopt"

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ITALIC=$(tput sitm)

[ "$DEBUG" ] && set -x

die() {
	echo "$PROGRAM: $@" >&2
	echo "Try '$PROGRAM --help' for more information."
	exit 1
}

check_dir() {
	[ ! -d "$1" ] && die "dir doesn't exist: $1"
}

contains() {
	local value="$1"
	shift
	for i in "$@"; do
		if [ "$i" == "$value" ]; then
			return 0
		fi
	done
	return 1
}
