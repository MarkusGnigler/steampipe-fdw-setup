docker build -t fdw-db .

docker run -d --name fdw-db \
    -e POSTGRES_USER=fdw \
    -e POSTGRES_DB=fdw \
    -e POSTGRES_PASSWORD=fdw-secret \
    -e STEAMPIPE_CACHE=false \
    fdw-db \
    postgres -c log_statement=all

sleep 8

docker run --rm \
    -e PGPASSWORD=fdw-secret \
    --link fdw-db:postgres \
    -v $(pwd)/shared:/shared \
    fdw-db \
    psql -h postgres -d fdw -U fdw -a -f /shared/setup.sql

docker rm -f fdw-db
