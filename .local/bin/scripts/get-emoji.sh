#!/usr/bin/env bash

FILE="${EMOJI_FILE:-emoji}"

curl https://unicode.org/Public/emoji/15.0/emoji-test.txt -o "$FILE" # Download file

sed -i -E '/^$|skin tone|^#/d' "$FILE"      # Delete skin tone emoji (only yellow emoji will stay)
sed -i '/fully-qualified/!d' "$FILE"        # Delete non fully-qualified emoji
gawk -i inplace -F '#' '{print $2}' "$FILE" # Delete everything before #
gawk -i inplace '{$2=""; print $0}' "$FILE" # Delete unicode version(third field)
sed -i -E 's/flag:|://g' "$FILE"            # Delete 'flag:' and ':'
sed -i 's/  / /g' "$FILE"                   # Replace double space with single
sed -i 's/.*/\L&/g' "$FILE"                 # To lower
