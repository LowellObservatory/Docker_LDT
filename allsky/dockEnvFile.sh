#/bin/bash
#
#   Bootstrap script to make a docker-compose .env file
#   that will set all of our default/desired variables for runtime.
#   Only works on Linux hosts.
#
#   Created by RTH 
#     2018/10/09

# Desired component versions, hardcoded for production & stability.
#   These should match the tags in the relevant docker hub pages.
#   Use a PHP version already bundled with apache because it's easier.
#   Also use the longer tag so it's clear what distribution is at the base
export PHP_VERSION="7.2-apache-stretch"

# If you're on OS X, `getent` isn't there because Apple didn't invent it,
#   so they instead invented a horribly more complex replacement.
#   I'm sure others have screwed around with `dscl` or whatever to 
#   get the equivalent information but I'm not going to.
DCUSERID=`getent passwd $USER | cut -d: -f3`
DCGRPID=`getent passwd $USER | cut -d: -f4`
DCDOCKERID=`getent group docker | cut -d: -f3`
DOCKDATADIR="$HOME/DockerData/"
DOCKDEVDIR="$HOME/DockerDev/allsky/"

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
echo "# Component versions to use" >> .env
echo "PHP_VERSION=$PHP_VERSION" >> .env

# Grab the NFS mount information
if [ -f "./nfsMounts.conf" ]; then
    source "./nfsMounts.conf"
    echo "NFSRIP=$nfsrip" >> .env
    echo "NFSRDIR=$nfsrdir" >> .env
    echo "NFSLDIR=$nfsldir" >> .env
else
    echo "No NFS mounts defined! Skipping."
fi

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
