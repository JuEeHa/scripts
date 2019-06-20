#!/bin/sh
usage() {
	echo "$(basename "$0") [--listen|-l socks_port] [--remote|-r remote_host] [--port|-p remote_port] [--user|-u username]"
	exit $1
}

remote=ahti-saarelainen.zgrep.org
port=22
listen=1080
user="$(whoami)"

eval set -- "$(getopt -s sh -l 'listen:,remote:,port:,user:,help' 'l:r:p:u:' "$@")" || usage 1 >&2

while true
do
	case "$1" in
		--help)
			usage 0
			;;
		--listen | -l)
			shift
			listen="$1"
			;;
		--remote | -r)
			shift
			remote="$1"
			;;
		--port | -p)
			shift
			port="$1"
			;;
		--user | -u)
			shift
			user="$1"
			;;
		--)
			[ $# -ne 1 ] && usage 1 1>&2
			break
			;;
	esac
	shift
done

echo "Listening on port $listen"
ssh -N -D "$listen" -p "$port" "$user@$remote"
