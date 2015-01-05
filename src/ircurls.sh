#!/bin/sh

geturls() {
	tr ' ' '\n' | grep http | sed 's/\.$//;s/\,$//'
}

if test z"$1" = z""
then
	fbb $(geturls)
else
	"$@" $(geturls)
fi
