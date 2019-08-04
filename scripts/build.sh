#!/usr/bin/env bash

if [ $# -eq 0 ]; then
	VERSION=master
elif [ $# -eq 1 ]; then
	VERSION="$1"
else
	echo "Wrong number of arguments!"
	exit 1
fi

docker build \
--no-cache \
--pull \
--rm \
--target aerc \
--tag sfischer13/aerc:"$VERSION" \
--build-arg VERSION="$VERSION" \
.

docker image prune --force
