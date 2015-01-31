#!/bin/sh
if test $# -eq 0
then
	echo "Usage: $(basename "$0") file [file2 file3 ... fileN]" 2>&1
	exit 1
fi

for i in "$@"
do
	echo "$i -> ${i%.html}"
	lynx -dump "$i" | sed 's,file:///,http://www.youtube.com/,' | egrep 'youtu.*/watch\?v=' | sed 's/^ *[0-9]*\. //;s/&.*$//' | uniq > "${i%.html}" && rm "$i"
done
