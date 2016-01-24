#!/bin/sh

tmpdir=$(mktemp -d)
prefix=$(hostname)
timestamp=$(date +%Y-%m-%d)

die() {
	echo tmpdir: $tmpdir 1>&2
	echo "Error: $@" 1>&2
	exit 1
}

collection() {
	cd
	
	name="${prefix}_$1_$timestamp.txz"
	shift
	
	echo "Creating $name"
	tar cJf "$tmpdir/$name" "$@" || die "tar returned $?"
	
	cd $tmpdir
	sha512 -r "$name" >> ${prefix}_sha512_$timestamp || die "sha512 returned $?"
	cd
}

remote_scp() {
	echo "echo 'Copying (scp) to $(echo $1 | cut -d : -f 1)'" >> $tmpdir/cmd.sh
	echo "scp *.txz ${prefix}_sha512_$timestamp $1/ || exit 1" >> $tmpdir/cmd.sh
}

remote_scp_pubkey() {
	echo "echo 'Copying (scp) to $(echo $1 | cut -d : -f 1)'" >> $tmpdir/cmd.sh
	echo "scp -i '$2' *.txz ${prefix}_sha512_$timestamp $1/ || exit 1" >> $tmpdir/cmd.sh
}

remote_ssh() {
	host="$1"
	shift
	echo "echo 'Executing commands on $host'" >> $tmpdir/cmd.sh
	echo "ssh $host $@ || exit 1" >> $tmpdir/cmd.sh
}

remote_ssh_pubkey() {
	host="$1"
	shift
	key="$1"
	shift
	echo "echo 'Executing commands on $host'" >> $tmpdir/cmd.sh
	echo "ssh -i '$key' $host $@ || exit 1" >> $tmpdir/cmd.sh
}

local_cp() {
	echo "echo 'Copying (cp) to $1'" >> $tmpdir/cmd.sh
	echo "cp *.txz ${prefix}_sha512_$timestamp $1/ || exit 1" >> $tmpdir/cmd.sh
}

touch $tmpdir/${prefix}_sha512_$timestamp
touch $tmpdir/cmd.sh

. ~/.backupshrc

cd $tmpdir

sh cmd.sh || die "remote_* or local_* failed"

cd
rm -r $tmpdir
