#!/usr/bin/fish
set -l address "Baohe"
set -l addressCn "包河区"
set -l text (string replace $address $addressCn (http "wttr.in/$address?A" -b))

printf '{"text":"%s","tooltip":"%s"}' $text $text