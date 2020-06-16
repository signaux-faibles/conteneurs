docker build -t keycloak .
docker save keycloak | gzip > keycloak.tar.gz
