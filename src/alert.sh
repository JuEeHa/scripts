#!/bin/sh
while test $(date +%H:%M) != $1:$2
do
	sleep 5
done
