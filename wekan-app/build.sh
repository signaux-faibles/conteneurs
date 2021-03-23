docker build -t wekan-app .
docker save wekan-app | gzip > wekan-app.tar.gz