#!/bin/sh
timestamp="$(date +%Y%m%d%H%M)"
for fname in "$@"
do
	name="$(printf "%s" "$fname" | sed 's/\..*$//')"
	ext="$(printf "%s" "$fname" | sed 's/^[^.]*//')"
	mv "$fname" "$name-$timestamp$ext"
done
