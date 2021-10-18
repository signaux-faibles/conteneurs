#!/usr/bin/env bash

docker build -t postgres .
docker save postgres | gzip > postgres.tar.gz