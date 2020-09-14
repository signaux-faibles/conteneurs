docker build -t sf-mysql .
docker save sf-mysql | gzip > sf-mysql.tar.gz
