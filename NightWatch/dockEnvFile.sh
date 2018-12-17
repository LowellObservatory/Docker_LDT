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

# NO COMMAS!!!
#   This list is used to check/make the data storage directories
services=("apachephp" "goesmcgoesface" "webcammcwebcamface")

# NO COMMAS!!!
#   This list is for extra data dirs that I can't figure out
#   how to check in a more automated/nice fashion.
extraddirs=("goesmcgoesface/cartopy")

# If you're on OS X, `getent` isn't there because Apple didn't invent it,
#   so they instead invented a horribly more complex replacement.
#   I'm sure others have screwed around with `dscl` or whatever to 
#   get the equivalent information but I'm not going to.
DCUSERID=`getent passwd $USER | cut -d: -f3`
DCGRPID=`getent passwd $USER | cut -d: -f4`
DCDOCKERID=`getent group docker | cut -d: -f3`
DOCKDATADIR="$HOME/DockerData/"
DOCKDEVDIR="$HOME/DockerDev/NightWatch/"

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

echo "./.env contents:"
echo "==========="
cat .env
echo "==========="

echo ""

echo "Checking docker data directories..."

if [ ! -d "$DOCKDATADIR" ]; then
    echo "$DOCKDATADIR doesn't exist!"
    mkdir "$DOCKDATADIR"
else
    echo "$DOCKDATADIR exists! Excellent..."
fi
if [ ! -d "$DOCKDATADIR/logs/" ]; then
    echo "$DOCKDATADIR/logs/ doesn't exist!"
    mkdir "$DOCKDATADIR/logs/"
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
    fi

done

for i in "${extraddirs[@]}"
do
    # Check to see if the directories exist in the
    #   already specified $DCDATADIR
    dadir="$DOCKDATADIR/$i"
    if [ -d "$dadir" ]; then
        echo "$dadir is good!"
    else
        mkdir "$dadir"
    fi
done

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
