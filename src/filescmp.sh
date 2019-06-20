#!/bin/sh
if test $# -ne 3
then
	echo "$(basename "$0") local_dir remote_host remote_dir" 1>&2
	exit 1
fi

local="$1"
host="$2"
remote="$3"

local_files="$(mktemp)"
remote_files="$(mktemp)"

ls "$local" | sort > "$local_files"
ssh "$host" ls "$remote" | sort > "$remote_files"

diff -u "$remote_files" "$local_files" | egrep -v '^\+\+\+|^---' | egrep '^[+-]'

rm "$local_files" "$remote_files"
