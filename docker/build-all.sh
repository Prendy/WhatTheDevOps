#!/bin/bash
set +e
docker stop andrew-app andrew-api
docker rm andrew-app andrew-api
set -e

pushd my-nodejs
docker build --tag my-nodejs:latest .
popd
pushd my-node-app
docker build --tag my-node-app:latest .
popd
pushd my-node-api
docker build --tag my-node-api:latest .
popd
docker run --name andrew-api -p 3001:3000 -d my-node-api:latest
docker run --name andrew-app -p 3000:3000 -d my-node-app:latest
docker ps -a
