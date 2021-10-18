#!/usr/bin/env bash

docker build -t wekan-db .
docker save wekan-db | gzip > wekan-db.tar.gz