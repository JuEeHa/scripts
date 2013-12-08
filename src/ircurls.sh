#!/bin/sh
if test z"$1" = z""
then
	fbb $(for i in $(cat); do echo $i | grep http; done)
else
	"$@" $(for i in $(cat); do echo $i | grep http; done)
fi
