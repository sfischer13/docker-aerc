#!/usr/bin/env bash

if [ $# -eq 0 ]; then
	VERSION=master
elif [ $# -eq 1 ]; then
	VERSION="$1"
else
	echo "Wrong number of arguments!"
	exit 1
fi

CONFIG=~/.config/aerc

docker run --rm -i \
--mount type=bind,source="$CONFIG",target=/home/docker/.config/aerc \
sfischer13/aerc:"$VERSION"
