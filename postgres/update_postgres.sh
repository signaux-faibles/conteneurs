docker stop postgres
docker rm postgres
docker run -v /home/christophe/pgdata:/var/lib/postgresql/data:z --dns 127.0.0.1 --name postgres -e POSTGRES_PASSWORD="bépovdljauietsrn" --restart always -d -p 5432:5432 postgres
