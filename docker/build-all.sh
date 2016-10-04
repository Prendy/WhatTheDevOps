#!/bin/bash
set +e
docker stop andrew-app andrew-api andrew-db
docker rm andrew-app andrew-api andrew-db
find my-node-api/api/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
find my-node-app/app/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
set -e

cp -r ~/www.poker.com/api ./my-node-api/
cp -r ~/www.poker.com/app ./my-node-app/
rm -rf ./my-node-api/api/.git
rm -rf ./my-node-app/app/.git

pushd my-nodejs
docker build --tag my-nodejs:latest .
popd
pushd my-node-app
docker build --tag my-node-app:latest .
popd
pushd my-node-api
docker build --tag my-node-api:latest .
popd
pushd my-mongodb
docker build --tag my-mongodb:latest .
popd
docker run --name andrew-db -p 27017:27017 -d my-mongodb:latest
docker run --name andrew-api -p 3001:3000 -d my-node-api:latest
docker run --name andrew-app -p 3000:3000 -d my-node-app:latest
docker ps -a
