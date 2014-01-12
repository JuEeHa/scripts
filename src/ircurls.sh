#!/bin/sh

geturls() {
	tr ' ' '\n' | grep http | sed 's/\.$//;s/\,$//'
}

if test z"$1" = z""
then
	geturls | xargs fbb
else
	geturls | xargs "$@"
fi
