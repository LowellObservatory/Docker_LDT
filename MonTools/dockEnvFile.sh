#/bin/bash
#
#   Bootstrap script to make a docker-compose .env file
#   that will set all of our default/desired variables for runtime.
#   Only works on Linux hosts.
#
#   Created by RTH 
#     2018/08/22

# Desired component versions, hardcoded for production & stability
export TELEGRAF_VERSION="1.21.2"
export INFLUXDB_VERSION="1.8.10"
export CHRONOGRAF_VERSION="1.9.1"
export KAPACITOR_VERSION="1.6.2"
export GRAFANA_VERSION="8.3.3"
export LOKI_VERSION="2.4.2"
export REDIS_VERSION="6.2.6"

# NO COMMAS!!!
#   This list is used to check/make the data storage directories
services=("chronograf" "kapacitor" "grafana" "influxdb" "telegraf" "loki" "logstash" "redis" "ftp")

# If you're on OS X, `getent` isn't there because Apple didn't invent it,
#   so they instead invented a horribly more complex replacement.
#   I'm sure others have screwed around with `dscl` or whatever to 
#   get the equivalent information but I'm not going to.
DCUSERID=`getent passwd $USER | cut -d: -f3`
DCGRPID=`getent passwd $USER | cut -d: -f4`
DCDOCKERID=`getent group docker | cut -d: -f3`
DOCKDATADIR="$HOME/DockerData/"
DOCKDEVDIR="$HOME/Docker_LDT/MonTools/"

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
echo "TELEGRAF_VERSION=$TELEGRAF_VERSION" >> .env
echo "INFLUXDB_VERSION=$INFLUXDB_VERSION" >> .env
echo "CHRONOGRAF_VERSION=$CHRONOGRAF_VERSION" >> .env
echo "KAPACITOR_VERSION=$KAPACITOR_VERSION" >> .env
echo "GRAFANA_VERSION=$GRAFANA_VERSION" >> .env
echo "LOKI_VERSION=$LOKI_VERSION" >> .env
echo "REDIS_VERSION=$REDIS_VERSION" >> .env

echo "./.env contents:"
echo "==========="
cat .env
echo "==========="

echo ""

echo "Checking docker data directories..."

if [ ! -d "$DOCKDATADIR" ]; then
    echo "$DOCKDATADIR doesn't exist!"
    mkdir "$DOCKDATADIR"
    echo "...so I made it good."
else
    echo "$DOCKDATADIR exists! Excellent..."
fi
if [ ! -d "$DOCKDATADIR/logs/" ]; then
    echo "$DOCKDATADIR/logs/ doesn't exist!"
    mkdir "$DOCKDATADIR/logs/"
    echo "...so I made it good."
else
    echo "$DOCKDATADIR/logs exists! Good..."
fi

echo ""

for i in "${services[@]}"
do
    # Check to see if the directories exist in the 
    #   already specified $DCDATADIR
    dadir="$DOCKDATADIR/$i"
    if [ -d "$dadir" ]; then
        echo "$dadir is good!"
    else
        mkdir "$dadir"
        echo "...so I made it good."
    fi

    # Now do the same for the log directories
    # Check to see if the directories exist in the 
    #   already specified $DCDATADIR

    ldir="$DOCKDATADIR/logs/$i"
    if [ -d "$ldir" ]; then
        echo "$ldir is good!"
    else
        echo "$ldir is nogood!"
        mkdir "$ldir"
        echo "...so I made it good."
    fi

done

backdir="$DOCKDEVDIR/influxbackupdump"
if [ -d "$backdir" ]; then
    echo "$backdir is good!"
else
    echo "$backdir is nogood!"
    mkdir "$backdir"
    echo "...so I made it good."
fi

boltdir="$DOCKDATADIR/ftp/nexstorm"
if [ -d "$boltdir" ]; then
    echo "$boltdir is good!"
else
    echo "$boltdir is nogood!"
    mkdir "$boltdir"
    echo "...so I made it good."
fi

echo ""
echo "========== NOTE =========="
echo "If any directories are missed and docker creates"
echo "them at runtime, they'll get created as root:root"
echo "and everything will end in tears."
echo ""
echo "Same is true if there are any mkdir errors up there!"
echo "========== NOTE =========="
echo ""

echo "Done! You can now use 'docker-compose ...' as usual."
