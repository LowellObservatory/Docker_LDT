#!/bin/bash

echo "Rebuilding docker-compose services..."
docker-compose build 
docker-compose down
docker system prune -f
docker-compose up -d
