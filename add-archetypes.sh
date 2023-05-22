#!/usr/bin/env bash

bold=$(tput bold)
normal=$(tput sgr0)

die() {
	echo "$@" >&2
	exit 1
}

check_dir() {
	[ ! -d "$1" ] && die "dir doesn't exist: $1"
}

add_arcetypes() {
	if [ $# -lt 4 ] || [ $# -gt 5 ]; then
		die "Usage: add-arcetypes.sh [-fR] -c <CONTENT-DIR> -t <TMP-DIR>

  -c
    Specify directory containing content

  -t
    Specify directory for temporary files

  -f
    Allow to use already exist dir as a tmp directory

  -R
    Regenerate archetypes of all files.
    Be careful with if your file starts with ${bold}---${normal} and it isn't archetypes,
    because your ${bold}file may be purge!${normal}"
	fi

	while [ $# -ne 0 ]; do
		case "$1" in
		-c)
			shift
			local content_dir="$1"
			shift
			;;
		-t)
			shift
			local tmp_dir="$1"
			shift
			;;
		-f)
			local force=true
			shift
			;;
		-R)
			local regen=true
			shift
			;;
		esac
	done

	check_dir "$content_dir"
	[ ! "$force"] && [ -d "$tmp_dir" ] && die "dir already exist: $tmp_dir"

	mkdir -p "$tmp_dir"

	IFS=$'\n' read -d '' -a contents < <(find "$content_dir" -type f)

	for i in "${contents[@]}"; do
		local hasArchetypes=false

		if [ "$(awk "NR==1" "$i")" == "---" ]; then
			hasArchetypes=true
		fi

		if [ "$regen" ]; then

			while [ "$hasArchetypes" = true ]; do
				sed -i '1d' "$i"
				if [ "$(awk "NR==1" "$i")" == "---" ]; then
					sed -i '1d' "$i"
					hasArchetypes=false
				fi
			done

		else
			[ "$hasArchetypes" = true ] && continue
		fi
		mv "$i" "$tmp_dir"
		local tmp_file="$tmp_dir/$(basename "$i")"

		local new_file="${i#$content_dir}"
		while [ "${new_file:0:1}" == "/" ]; do
			new_file=${new_file:1}
		done

		hugo new "$new_file"

		cat "$tmp_file" >>"$content_dir/$new_file"

		rm "$tmp_file"
	done

	[ ! "$force"] && rmdir "$tmp_dir"
}

add_arcetypes "$@"
