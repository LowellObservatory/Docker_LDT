#!/bin/bash

echo "Rebuilding docker-compose services..."
docker-compose down
docker-compose build
docker system prune
docker-compose up -d
