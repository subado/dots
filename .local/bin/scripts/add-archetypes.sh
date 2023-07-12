#!/usr/bin/env bash

source utils.sh

usage() {
	cat <<-_EOF
		usage: ${BOLD}$PROGRAM${NORMAL} [-f] ${ITALIC}CONTENT-DIR${NORMAL} [${ITALIC}content${NORMAL}...]

		  ${BOLD}-f, --force${NORMAL}
		      Force gegenerate archetypes for all files.
		      Be careful with if your file starts with ${BOLD}---${NORMAL} and it isn't archetypes,
		      because your ${BOLD}file may be purge!${NORMAL}
	_EOF
}

eval set -- "$(getopt -o hf -l help,force -n "$PROGRAM" -- "$@")"

while true; do
	case "$1" in
	-h | --help)
		usage && exit 0
		;;
	-f | --force)
		force=1
		shift
		;;
	--)
		shift
		break
		;;
	esac
done

[ "$1" = "" ] && die 'missing content directory operand'
[ -d "$1" ] || die "doesn't exist: $1"
CONTENT_DIR=$(realpath "$1")
shift

while true; do
	content=$1
	[ "$content" ] && shift

	[ -f "${content:="$CONTENT_DIR"}" ] || [ -d "$content" ] || die "doesn't exist: $content"

	while IFS= read -r file; do
		IFS= read -r line <"$file"

		[ "$line" = '---' ] &&
			if [ "$force" ]; then
				sed -i '1d' "$file"
				while IFS= read -r line; do
					sed -i '1d' "$file"
					[ "$line" = '---' ] && break
				done <"$file"
			else
				continue
			fi

		temp="$(mktemp)"
		mv "$file" "$temp"

		hugo new "${file##"$CONTENT_DIR/"}" || eval "mv $temp $file; exit 1"
		cat "$temp" >>"$file"

		rm "$temp"

	done < <(find "$content" -type f)

	[ $# -eq 0 ] && break
done
