#!/bin/sh

tmpdir=$(mktemp -d)
prefix=$(hostname)
timestamp=$(date +%Y-%m-%d)

collection() {
	cd
	
	name="${prefix}_$1_$timestamp.txz"
	shift
	
	echo "Creating $name"
	tar cJf "$tmpdir/$name" "$@" 2> /dev/null || exit 1
	
	cd $tmpdir
	sha512 -r "$name" >> ${prefix}_sha512_$timestamp || exit 2
}

remote_scp() {
	echo "echo 'Copying (scp) to $(echo $1 | cut -d : -f 1)'" >> $tmpdir/cmd.sh
	echo "scp *.txz ${prefix}_sha512_$timestamp $1/ || exit 1" >> $tmpdir/cmd.sh
}

remote_ssh() {
	host="$1"
	shift
	echo "echo 'Executing commands on $host'" >> $tmpdir/cmd.sh
	echo "ssh $host $@ || exit 1" >> $tmpdir/cmd.sh
}

local_cp() {
	echo "echo 'Copying (cp) to $1'" >> $tmpdir/cmd.sh
	echo "cp *.txz ${prefix}_sha512_$timestamp $1/ || exit 1" >> $tmpdir/cmd.sh
}

touch $tmpdir/${prefix}_sha512_$timestamp
touch $tmpdir/cmd.sh

. ~/.backupshrc

cd $tmpdir

sh cmd.sh || exit 3

cd
rm -r $tmpdir
