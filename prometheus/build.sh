docker build -t prometheus-server .
docker save prometheus-server | gzip > prometheus-server.tar.gz
