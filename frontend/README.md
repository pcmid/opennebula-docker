# OpenNebula Frontend

```bash
# initialize the config and database
docker compose -f docker-compose.yaml -f docker-compose.init.yaml up 
```
```bash
# edit your config
vim one/etc/one/oned.conf
...
```

```bash
# start the frontend
docker compose -f docker-compose.yaml -f docker-compose.init.yaml up 
```
