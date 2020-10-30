docker build -t sf-mariadb .
docker save sf-mariadb | gzip > sf-mariadb.tar.gz
