# OpenNebula Frontend

## initialize the config and database
```bash
docker compose -f docker-compose.yaml -f docker-compose.init.yaml up 
```

## edit your config
```bash

vim /etc/one/oned.conf
...
```

## start the frontend
```bash
docker compose -f docker-compose.yaml -f docker-compose.main.yaml up 
```
