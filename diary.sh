#!/usr/bin/env bash

PREFIX="${DIARY_DIR:-$HOME/.diary}"

write()
{
	case "$1" in
		-d|--date) local path="$(date -d "$2" +'%Y/%m/%d')"; shift 2 ;;
		*) local path="${1%/}"; shift ;;
	esac

	local file="$PREFIX/$path.md"

	local working_dir="$PREFIX/$(dirname "$path")"
	mkdir -p -v "$working_dir"

	$EDITOR "+cd $working_dir" $file
}

show()
{
	local path="${1%/}"
	local file="$PREFIX/$path.md"

	echo "Diary"
	tree -N -C -l --noreport "$PREFIX/$path" | tail -n +2 | sed -E 's/\.md(\x1B\[[0-9]+m)?( ->|$)/\1\2/g'
}

case "$1" in
	write) shift;			write "$@" ;;
	show) shift;			show "$@" ;;
	*)
esac
