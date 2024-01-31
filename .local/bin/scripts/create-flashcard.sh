#!/usr/bin/env sh

lang='en:ru'
trslt.sh "$lang"

clip=$(xclip -o -selection clipboard)
if [ "$clip" ]; then
	buf=$(echo -n "$clip" | awk '{print tolower($0)}' | tr '\n' ' ' | trans -show-languages n -no-warn -show-translation-phonetics n -show-translation n "$lang")
	origin="${buf%%$'\n'*}"
	card="$FLASHCARDS_DIR/english/$origin.md"

	if [ -f "$card" ]; then
		dunstify -u low -t 1500 "$card is already created!"
		exit 1
	fi

	declare -A conversions=(
		$'\e\[(4|24)m' '_'
		$'\e\[(1|22)m' '**'
	)

	for escaped in ${!conversions[@]}; do
		buf=$(echo -n "$buf" | sed -r "s/$escaped/${conversions[$escaped]}/g")
	done
	buf="$(echo -n "$buf" | sed "s/\*\*    /    \*\*/g" )"
	buf="$(echo -n "$buf" | sed -r "s/^    //g" )"
	buf="$(echo -n "$buf" | sed -r "s/^    /\n    /g" )"

	translation="${buf#*$'\n'}"
	mkdir -p "${card%/*}"
	echo "$origin" >>"$card"
	printf "\n?\n\n" >>"$card"
	echo -n "$translation" >>"$card"
	dunstify -u low -t 1500 "$card has been created"
fi
