#!/bin/sh
for i in "$@"
do
	printf "%s\n" "${i%.mdp}"
	if test -e _top -a -e _bottom -a -e "$i"
	then
		NAME="$(egrep '^# ' "$i" | sed -E 's/^# +(.*) *$/\1/')"
		cat _top > "${i%.mdp}.html"
		amdtbl.awk "$i" | markdown >> "${i%.mdp}.html"
		cat _bottom >> "${i%.mdp}.html"
		sed -i "s/__title__/$NAME/g" "${i%.mdp}.html"
	else
		echo 'need: _top, _bottom, arg'
	fi
done
