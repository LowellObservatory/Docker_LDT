#/bin/bash
#
#   Bootstrap script to make a docker-compose .env file
#   that will set all of our default/desired variables for runtime.
#   Only works on Linux hosts.
#
#   Created by RTH 
#     2018/08/22

# Desired component versions, hardcoded for production & stability
export TELEGRAF_VERSION="1.7"
export INFLUXDB_VERSION="1.6"
export CHRONOGRAF_VERSION="1.6"
export GRAFANA_VERSION="5.2.4"
export ACTIVEMQ_VERSION="5.15.4"

# If you're on OS X, `getent` isn't there because Apple didn't invent it,
#   so they instead invented a horribly more complex replacement.
#   I'm sure others have screwed around with `dscl` or whatever to 
#   get the equivalent information but I'm not going to.
DCUSERID=`getent passwd $USER | cut -d: -f3`
DCGRPID=`getent passwd $USER | cut -d: -f4`
DCDOCKERID=`getent group docker | cut -d: -f3`
DOCKDATADIR="$HOME/DockerData/"
DOCKDEVDIR="$HOME/DockerDev/DCTStack/"

# This next one is super annoying, but this 
#   has to be RELATIVE to the current directory
#   since COPY in Dockerfiles is relative to 
#   the build context (which is '.').
LIGCODEDIR="$HOME/Codes/LIG/"

# Now put it all into the .env file
# Print a header so we know its vintage
echo "# Created on `date -u` by $USER" > .env
echo "#" >> .env
echo "# User/group setup, to keep containers from running as root" >> .env
echo "DCUSERID=$DCUSERID" >> .env
echo "DCGRPID=$DCGRPID" >> .env
echo "DCDOCKERID=$DCDOCKERID" >> .env
echo "DCDATADIR=$DOCKDATADIR" >> .env
echo "DCDEVDIR=$DOCKDEVDIR" >> .env
echo "LIGCODEDIR=$LIGCODEDIR" >> .env
echo "# Component versions to use" >> .env
echo "TELEGRAF_VERSION=$TELEGRAF_VERSION" >> .env
echo "INFLUXDB_VERSION=$INFLUXDB_VERSION" >> .env
echo "CHRONOGRAF_VERSION=$CHRONOGRAF_VERSION" >> .env
echo "GRAFANA_VERSION=$GRAFANA_VERSION" >> .env
echo "ACTIVEMQ_VERSION=$ACTIVEMQ_VERSION" >> .env

echo "./.env contents:"
echo "==========="
cat .env
echo "==========="

echo ""

echo "Checking docker data directory..."
if [ ! -d "$DOCKDATADIR" ]; then
    echo "$DOCKDATADIR doesn't exist!"
    mkdir "$DOCKDATADIR"
    mkdir "$DOCKDATADIR/influxdb"
    mkdir "$DOCKDATADIR/grafana"
    mkdir "$DOCKDATADIR/telegraf"
    mkdir "$DOCKDATADIR/chronograf"
    mkdir "$DOCKDATADIR/lig"
    mkdir "$DOCKDATADIR/logs"
else
    echo "$HOME/DockerData/ exists! Hooray!"
    echo ""
    echo "========== NOTE =========="
    echo "I'm assuming that all the directories we need exist;"
    echo "If they don't, they'll get created as root:root"
    echo "and everything will end in tears."
    echo "========== NOTE =========="
    echo ""
fi

echo "Done! You can now use 'docker-compose ...' as usual."
