#!/usr/bin/env bash

set -eo pipefail

echo ">>> pushing latest image"
./scripts/docker_push.sh latest

chmod 400 der-nackte-halloumi-caddy-travis

echo $SERVER_PUBLIC_KEY >> $HOME/.ssh/known_hosts

echo ">>> restarting caddy with image dernacktehalloumi/caddy:$TRAVIS_BUILD_NUMBER"
ssh -i der-nackte-halloumi-caddy-travis $SERVER_ADDRESS "CADDY_IMAGE_TAG=$TRAVIS_BUILD_NUMBER docker-compose up --build -d caddy"
