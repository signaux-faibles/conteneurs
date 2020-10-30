docker build -t prometheus .
docker save prometheus | gzip > prometheus.tar.gz