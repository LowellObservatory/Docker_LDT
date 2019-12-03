#!/bin/bash

echo "Checking for submodule updates..."
git submodule update --remote

echo "Rebuilding base image..."
# Build our base image by hand since docker-compose can't do it for us
source .env && echo ${DCUSERID}, ${DCGRPID}, ${MINICONDA_VERSION}
source .env && docker build --build-arg userid=${DCUSERID} \
	               --build-arg groupid=${DCGRPID} \
	               --build-arg miniconda_version=${MINICONDA_VERSION} \
		       --force-rm -f Dockerfile-ligbase --tag ligbase ./

echo "Rebuilding docker-compose services..."
docker-compose down; docker-compose build; docker system prune; docker-compose up -d
