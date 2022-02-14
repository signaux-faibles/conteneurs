#!/usr/bin/env bash

# dummy comment to just start new github action

docker build -t sf-mariadb .
docker save sf-mariadb | gzip > sf-mariadb.tar.gz
