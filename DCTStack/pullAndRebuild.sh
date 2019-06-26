#!/bin/bash

echo "Checking for submodule updates..."
git submodule update --remote

echo "Rebuilding docker-compose services..."
docker-compose down; docker-compose build; docker system prune; docker-compose up -d
