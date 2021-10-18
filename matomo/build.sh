#!/usr/bin/env bash

docker build -t sf-matomo .
docker save sf-matomo | gzip > sf-matomo.tar.gz