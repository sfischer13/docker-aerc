#!/usr/bin/env bash

docker images --quiet --filter=reference="sfischer13/aerc:*" | xargs -r docker rmi --force

docker image prune --force
