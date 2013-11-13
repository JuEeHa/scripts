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

echo "client: $VER"

if test -e btw_$VER.jar
then
	echo "btw_$VER.jar exists"
	test -e ~/oldmc/btw$VER/minecraft.jar && rm ~/oldmc/btw$VER/minecraft.jar
	ln btw_$VER.jar ~/oldmc/btw$VER/minecraft.jar
	
	test -e ~/.minecraft/versions/btw/btw.jar && rm ~/.minecraft/versions/btw/btw.jar
	ln btw_$VER.jar ~/.minecraft/versions/btw/btw.jar
	exit 0
fi

if test ! -e unpack-client-vanilla
then
	if test -e ~/oldmc/1.5.2/minecraft.jar
	then
		echo 'create: unpack-client-vanilla/'
		mkdir unpack-client-vanilla
		cd unpack-client-vanilla
		unzip ~/oldmc/1.5.2/minecraft.jar > /dev/null
		cd ..
	else
		echo 'error: unpack-client-vanilla cannot be created'
		exit 1
	fi
fi

if test ! -e unpack-client-$VER
then
	echo 'create: unpack-client-$VER'
	cp -r unpack-client-vanilla unpack-client-$VER
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

echo "create: btw_$VER.jar"
cd unpack-mod-$VER/MINECRAFT-JAR
cp -r * ../../unpack-client-$VER/
cd ../../unpack-client-$VER/
rm -r META-INF
zip -r ../btw_$VER.jar * > /dev/null
cd ..
echo "install: btw_client_$VER.jar"
mkdir -p ~/oldmc/btw$VER
test -e ~/oldmc/btw$VER/minecraft.jar && rm ~/oldmc/btw$VER/minecraft.jar
ln btw_$VER.jar ~/oldmc/btw$VER/minecraft.jar

test -e ~/.minecraft/versions/btw/btw.jar && rm ~/.minecraft/versions/btw/btw.jar
ln btw_$VER.jar ~/.minecraft/versions/btw/btw.jar
