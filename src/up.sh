#!/usr/bin/env mksh
#url_base='http://nortti.eonei.tk/u'
#remote='nortti.eonei.tk:Public/u'
url_base='https://ahti.space/~nortti/u'
remote='ahti.space:public_html/u'

if test z"$1" = z"--text"
then
	shift
	extra_ext='.text'
else
	extra_ext=''
fi


for file in "$@"
do
	if test -n "$extra_ext"
	then
		fname="$(basename "$file")$extra_ext"
		scp -r "$file" "$remote/$(printf '%q' "$fname")" >&2 || { echo "Could not copy '$file'" >&2; exit 1; }
	else
		fname="$(basename "$file")"
		scp -r "$file" "$remote/" >&2 || { echo "Could not copy '$file'" >&2; exit 1; }
	fi
	echo "$url_base/$fname"
done
