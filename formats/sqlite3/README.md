# SQLite3

## Create database

```
docker run \
  --volume `pwd`/formats:/mnt/formats \
  --env SQLITE3_DB="/mnt/formats/sqlite3/whiskey.db" \
  whiskey:latest \
  rake sqlite3:create
```
