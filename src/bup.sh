#!/bin/sh
if test z"$BUP" = z""
then
	echo 'Define $BUP'
	exit 1
fi

tar cv $* | xz -zc - > ~/Dropbox/bup-t61p/bup-$BUP-$(date +%Y-%m-%d).tar.xz
