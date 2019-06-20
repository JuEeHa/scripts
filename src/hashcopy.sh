#!/bin/sh
url_base='https://ahti.space/~nortti/h'
remote='ahti.space:public_html/h'

if test z"$1" = z"--text"
then
	shift
	extra_ext='.text'
else
	extra_ext=''
fi


for file in "$@"
do
	if test -z "$extra_ext"
	then
		ext="$(printf "%s" "$file" | sed -E 's/^[^.]*//')"
		if test -z "$ext"
		then
			ext=".bin"
		else
			ext=".$ext"
		fi
	else
		ext="$extra_ext"
	fi

	fname="$(sha256sum "$file" | cut -d ' ' -f 1)$ext"
	scp -r "$file" "$remote/$fname" >&2 || { echo "Could not copy '$file'" >&2; exit 1; }
	echo "$url_base/$fname"
done
