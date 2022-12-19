#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Please enter NOTES_TYPE"
else
	NOTES_TYPE=$1
	NOTES_DIR="$HOME/notes/${NOTES_TYPE}"
	NOTE="$(date +%F).md"

	if [[ $# -eq 2 ]]; then
		LIST=$(ls ${NOTES_DIR} | grep $2 | sed 's/.md//' | tr '\n' ' ')
		MAX=0
		IFS=' ' read -ra LIST <<< "${LIST}"
		for i in "${LIST[@]}"; do
			DATE=$( date -d "${i}" +%s)

			if [[ DATE -gt MAX ]]; then
				MAX=${DATE}
				FILE=${i}
			fi
		done

		if [[ -n ${FILE} ]]; then
			NOTE="${FILE}.md"
		fi
	fi

	$EDITOR ${NOTES_DIR}/${NOTE}
fi
