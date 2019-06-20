#!/bin/sh
die() {
	echo "$0: Error: $*" 1>&2
	exit 1
}

tmpdir="$(mktemp -d)" || die "Couldn't create tempdir"
cd "$tmpdir" || die cd
youtube-dl --extract-audio "$@" || { echo "Fix this yourself"; sh; }
for i in *
do
	ffmpeg -i "$i" "$i.mp3" || die ffmpeg
done

mv *.mp3 /media/nortti/PHILIPS*/A/

cd
rm -r "$tmpdir"
