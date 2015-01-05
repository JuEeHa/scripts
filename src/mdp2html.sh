#!/bin/sh
for i in $*
do
	echo ${i%.mdp}
	if test -e _top -a -e _bottom -a -e "$i"
	then
		if test -e ${i%.mdp}.title
		then
			NAME=$(cat ${i%.mdp}.title)
		else
			NAME=$(echo $(basename ${i%.mdp}) | tr '_' ' ')
		fi
		cat _top > ${i%.mdp}.html
		amdtbl.awk $i | markdown >> ${i%.mdp}.html
		cat _bottom >> ${i%.mdp}.html
		sed -i "s/__title__/$NAME/g" ${i%.mdp}.html
	else
		echo 'need: _top, _bottom, arg'
	fi
done
