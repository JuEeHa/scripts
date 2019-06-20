#!/bin/sh
# It will not look pretty but will be usable

process() {
	rtfreader | txt2html.sh
}

if test "$#" = 0
then
	process
else
	for i in "$@"
	do
		process < "$i" > "${i%.rtf}.html"
	done
fi
