#!/bin/bash

# Depends on the bind mounts specified in the .env file
#  to actually access the influxdb data in the right place!

source ./.env

if [ -z "$INFLUXDB_VERSION" ]
then
    INFLUXDB_VERSION='latest'
fi

if [ -z "$DCDATADIR" ]
then
    DCDATADIR="$HOME/DockerData/"
fi

if [ -z "$DCDEVDIR" ]
then
    DCDEVDIR="$HOME/DockerDev/DCTStack/"
fi

outdir="$DCDEVDIR/influxbackupdump"
if [ -d "$outdir" ]
then
    echo "Good, $outdir exists for backup output"
else
    mkdir "$outdir"
fi

dstr="docker exec -it influxdb influxd backup -portable /home/influxbackups"

echo "Copy and run this command:"
echo ""
echo "$dstr"
echo ""
