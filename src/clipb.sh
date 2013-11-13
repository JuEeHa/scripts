#!/bin/sh
test z"$1" = z"a" && cat >> ~/.clipbored
if test z"$1" = z"."
then
	echo "$*" >> ~/.clipbored
	exit 0
fi
leafpad ~/.clipbored
