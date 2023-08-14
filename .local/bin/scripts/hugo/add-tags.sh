#!/usr/bin/env sh

. utils.sh

command -v yq >/dev/null 2>&1 ||
	cat <<-_EOF
		${BOLD}yq${NORMAL} is not executable!
		Install yq to use this script.
	_EOF

usage() {
	cat <<-_EOF
		usage: ${BOLD}$PROGRAM${NORMAL} ${ITALIC}CONTENT_DIR${NORMAL}
	_EOF
}

eval set -- "$("$GETOPT" -o h -l help -n "$PROGRAM" -- "$@")"

while true; do
	case $1 in
	-h | --help) usage && exit 0 ;;
	--) shift && break ;;
	esac
done

[ "$1" = "" ] && die 'missing content directory operand'
[ -d "$1" ] || die "doesn't exist: $1"
CONTENT_DIR=$(realpath "$1")
shift

while read -r content; do
	echo "$content"

	if yq --front-matter=process "$content" >/dev/null 2>&1; then

		tags=${content#"$CONTENT_DIR"/}
		tags=${tags%/*}
		tags=$tags/
		while [ "$tags" ]; do
			tag=${tags%%/*}
			tags=${tags#*/}

			if [ "$(yq --front-matter=extract ".tags[] | select(. == \"$tag\")" "$content")" = "" ]; then
				echo "$tag"
				yq -i --front-matter=process ".tags += [\"$tag\"] | .tags[] style=\"double\"" "$content"
			fi
		done
	else
		echo "Can't add tags to $content. $content hasn't archetypes"
	fi

done <<-_EOF
	$(find "$CONTENT_DIR" -mindepth 2 -type f -name '*.md')
_EOF
