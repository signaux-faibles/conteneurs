docker build -t gollum .
docker save gollum | gzip > gollum.tar.gz
