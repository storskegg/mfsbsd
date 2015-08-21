#!/bin/sh
server=ftp.freebsd.org

dir=pub/FreeBSD/releases/amd64/amd64/10.2-RELEASE
dest=./release/10.2-RELEASE

base="MANIFEST \
	base.txz \
	doc.txz \
	games.txz \
	kernel.txz \
	lib32.txz \
	ports.txz \
	src.txz "

get() {
	ftplist=""
	for item in $@ ; do
		full_name=ftp://$server/$dir/$item
		ftplist="$ftplist $full_name"
	done

	echo "About to get the following:"
	echo "$ftplist"

	ftp -o $dest $ftplist
}

if [ ! -d "$dest" ]; then
	mkdir -p $dest
fi

get $base
