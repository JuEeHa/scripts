#!/bin/sh
gettodo() {
	grep '/\* TODO' "$1"*.c "$1"*.h 2> /dev/null
	grep '# TODO' "$1"*.sh "$1"*.py 2> /dev/null
}

if test z"$1" = z""
then
	gettodo
else
	SDIR=$(pwd)
	for i in "$@"
	do
		if test -d "$i"
		then
			gettodo $i/
		fi
	done
fi
