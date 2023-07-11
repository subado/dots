#!/usr/bin/env bash

FILE="emojis.txt"

curl https://unicode.org/Public/emoji/15.0/emoji-test.txt -o "$FILE"
sed -i -E '/^$|skin tone|^#/d' "$FILE"
sed -i '/fully-qualified/!d' "$FILE"
gawk -i inplace -F '#' '{print $2}' "$FILE"
gawk -i inplace '{$0=gensub(/\s*\S+/,"",2)}1' "$FILE"
sed -i -E 's/flag:|:|^ //g' "$FILE"
