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
	for item in $@ ; do
		full_name=ftp://$server/$dir/$item
		ftp -o $dest/$item $full_name
	done
}

if [ ! -d "$dest" ]; then
	mkdir -p $dest
fi

if [ $(id -u) != 0 ]; then
	echo "This script must be run as root." 1>&2
	exit 1
fi

cp /usr/local/sbin/pkg-static ./tools
get $base

make

