#!/bin/bash

echo "Checking for submodule updates..."
git submodule update --remote

echo "Rebuilding base image..."
# Build our base image by hand since docker-compose can't do it for us
docker build --force-rm -f NightShift/dockerfiles/nightshiftDockerfile --tag nightshiftbase NightShift/

echo "Rebuilding other images..."
docker compose build

echo "Restarting..."
# HACK TO KEEP DATA PROCESSING WHILE DEBUGGING
docker compose down djangostack; docker system prune -f; docker compose up -d
