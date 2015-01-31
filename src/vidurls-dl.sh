#!/bin/sh
if test $# -ne 1 -a $# -ne 2
then
	echo "Usage: $(basename "$0") file" 1>&2
	exit 1
fi

numvids=5
if test $# -eq 2
then
	numvids="$1"
	shift
fi	

if test $(wc -l "$1" | sed 's/^ *//;s/ .*$//') -le "$numvids"
then
	ytdl $(cat "$1") && rm "$1" || exit 1
else
	# remove '' after -i if using GNU sed
	ytdl $(head -n "$numvids" "$1") && sed -i '' "1,${numvids}d" "$1" || exit 1
fi
