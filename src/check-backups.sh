#!/bin/sh
die() {
	echo "$0: Error: $*" 1>&2
	exit 1
}

if test $# -ne 2
then
	echo "Usage: $0 pubkey sigfile" 1>&2
	exit 1
fi

pubkey="$1"
sigfile="$2"
sumsfile="${sigfile%.sig}"

signify-openbsd -V -e -p "$pubkey" -x "$sigfile" -m "$sumsfile" || die signify
sha512sum -c "$sumsfile"
