FROM postgres:15

RUN apt-get update && \
    apt-get install -y postgresql-15-pglogical && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
