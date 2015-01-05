#!/bin/sh

getfile() {
	echo "$HOME/btwfiles/BTWMod$(printf "%s\n" "$1" | tr '.' '-').zip"
}

cd ~/btw

if test ! -n "$1"
then
	VER=$(ls ../btwfiles | sort -rn | head -n 1 | tail -c +7 | cut -d '.' -f 1 | tr '-' '.')
else
	VER=$1
fi

echo "server: $VER"

if test -e btw_server_$VER.jar
then
	echo "btw_server_$VER.jar exists"
	
	test -e ~/oldmc/btw$VER/btw_server.jar && rm ~/oldmc/btw$VER/btw_server.jar
	ln btw_server_$VER.jar ~/oldmc/btw$VER/btw_server.jar
	
	exit 0
fi

if test ! -e unpack-srv-vanilla
then
	if test -e ~/oldmc/1.5.2/minecraft_server.jar
	then
		echo 'create: unpack-srv-vanilla/'
		mkdir unpack-srv-vanilla
		cd unpack-srv-vanilla
		unzip ~/oldmc/1.5.2/minecraft_server.jar > /dev/null
		cd ..
	else
		echo 'error: unpack-srv-vanilla cannot be created'
		exit 1
	fi
fi

if test ! -e unpack-srv-$VER
then
	echo 'create: unpack-srv-$VER'
	cp -r unpack-srv-vanilla unpack-srv-$VER
fi

if test ! -e unpack-mod-$VER
then
	if test ! -e $(getfile $VER)
	then
		echo "error: $(getfile $VER) not found"
		exit 1
	else
		echo "create: unpack-mod-$VER"
		mkdir unpack-mod-$VER
		cd unpack-mod-$VER
		unzip $(getfile $VER) > /dev/null
		cd ..
	fi
fi

echo "create: btw_server_$VER.jar"
cd unpack-mod-$VER/MINECRAFT_SERVER-JAR
cp -r * ../../unpack-srv-$VER/
cd ../../unpack-srv-$VER/
zip -r ../btw_server_$VER.jar * > /dev/null
cd ..
echo "install: btw_server_$VER.jar"
mkdir -p ~/oldmc/btw$VER
test -e ~/oldmc/btw$VER/btw_server.jar && rm ~/oldmc/btw$VER/btw_server.jar
ln btw_server_$VER.jar ~/oldmc/btw$VER/btw_server.jar
