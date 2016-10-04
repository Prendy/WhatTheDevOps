#!/bin/bash
set +e
docker stop andrew-app
docker rm andrew-app
set -e

pushd my-nodejs
docker build --tag my-nodejs:latest .
popd
pushd my-node-app
docker build --tag my-node-app:latest .
popd
docker run --name andrew-app -p 3000:3000 -d my-node-app:latest
docker ps -a
