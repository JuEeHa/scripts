#!/bin/sh
if test $# -eq 0
then
	echo "Usage: $(basename "$0") file [file2 file3 ... fileN]" 2>&1
	exit 1
fi

for i in "$@"
do
	echo "$i -> ${i%.html}"
	grep -o 'href="/watch?v=[^&"]*[&"]' "$i" | sed 's,^href="\(.*\)&,http://www.youtube.com\1,' | uniq > "${i%.html}" && rm "$i"
done
