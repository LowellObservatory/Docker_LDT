#!/bin/bash

echo "Checking for submodule updates..."
git submodule update --remote

echo "Rebuilding base image..."
# Build our base image by hand since docker-compose can't do it for us
docker build --force-rm -f NightShift/dockerfiles/nightshiftDockerfile --tag nightshiftbase NightShift/

echo "Rebuilding docker-compose services..."
docker-compose down; docker-compose build; docker system prune; docker-compose up -d
