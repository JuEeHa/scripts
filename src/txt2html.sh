#!/bin/sh
# It will not look pretty but will be usable

chars() {
	sed 's,<,\&lt;,;
	     s,>,\&gt;,;'
}

paragraphs() {
	echo '<p>'
	if $para_on_nl
	then
		sed 's,$,</p><p>,'
	else
		sed 's,^ *$,</p><p>,'
	fi
	echo '</p>'
}

links() {
	# If ']' is included it should go first, a quirk of how regexps work
	terminators="])}<>; "
	sed 's,http://[^'"$terminators"']*,<a href="&">&</a>,'
}

process() {
	chars | paragraphs | links
}

para_on_nl=true
if test z"$1" = z"-d"
then
	para_on_nl=false
	shift
fi

if test "$#" = 0
then
	process
else
	for i in "$@"
	do
		process < "$i" > "${i%.txt}.html"
	done
fi
