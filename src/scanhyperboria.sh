#!/bin/sh
wget -q -6 -O - http://[fcd5:2e6b:3b37:ae1d:ad61:1c2d:8b5:ab7a]/hyperdb/hyperdb.db | sort | nmap -6 -iL - -n -PN -sT -p80 --open -oG - | grep '/open/' | sed 's/^Host: /http:\/\/\[/g'|sed 's/ .*/\]\//g' > ~/hyperboria.sites
