#!/bin/bash

# DB client
docker-compose up -d influxdb; docker exec -it influxdb influx

# If you need a shell
#docker-compose up -d influxdb; docker exec -it influxdb /bin/bash

