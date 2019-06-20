#!/bin/sh
passphrase_file=~/.backupsh_passphrase

die() {
	echo "$0: Error: $*" 1>&2
	exit 1
}

for name in "$@"
do
	echo "Extracting $name"
	openssl enc -d -aes-256-cbc -md sha256 -pass file:"$passphrase_file" -in "$name" | tar xJ || die "Failed to extract $name"
done
