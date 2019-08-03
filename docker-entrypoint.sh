#!/usr/bin/env bash

set -e -o pipefail

if [ "$1" = '--help' ]; then
    exec ls -1 /home/docker /local/bin /local/share/aerc
fi

exec "$@"
