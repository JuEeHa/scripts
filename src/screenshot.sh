#!/bin/sh
die() {
	echo "Error: $*" >&2
	exit 1
}

usage() {
	echo "$(basename "$0") [--active|--full|--select|-afs] [--filename <filename> | -o <filename>] [--wait <seconds>|-w <seconds>]"
	exit $1
}

filename=""
wait_time=""
mode="select"
options="--format=png"

eval set -- "$(getopt -s sh -l 'filename:,wait:,active,full,select,help' 'o:w:afs' "$@")" || usage 1 >&2

while true
do
	case "$1" in
		--help)
			usage 0
			;;
		--filename | -o)
			shift
			filename=$1
			;;
		--wait | -w)
			shift
			wait_time=$1
			;;
		--active | -a)
			mode="active"
			;;
		--full | -f)
			mode="full"
			;;
		--select | -s)
			mode="select"
			;;
		--)
			[ $# -ne 1 ] && usage 1 1>&2
			break
			;;
		*)
			die "Unrecognised option '$1'"
			;;
	esac
	shift
done

if [ -n "$wait_time" ]
then
	sleep "$wait_time" || die "'$wait_time' not acceptable wait time"
fi

if [ -z "$filename" ]
then
	filename="$(date +%Y-%m-%d_%H%M%S)_screenshot.png"
fi

case "$mode" in
	active)
		maim $options --window=$(xdotool getactivewindow) "$filename"
		;;
	full)
		maim $options "$filename"
		;;
	select)
		maim $options --select "$filename"
		;;
	*)
		die "Impossible mode '$mode'"
		;;
esac
