#!/bin/sh
tarball() {
	tar cv "$1" | xz -zc > ~/Dropbox/$(basename "$1").tar.xz || return 1
}
if test $# = 0
then
	echo "usage: $0 dir"
	exit 1
fi
if test -e ~/Dropbox/$(basename "$1").tar.xz
then
	echo 'Already exists'
	exit 1
fi
CDIR=$(pwd)
cd $1
make clean
cd $CDIR
if tarball "$1"
then
	rm -rf "$1"
else
	echo 'Something failed, not deleting'
	exit 1
fi
