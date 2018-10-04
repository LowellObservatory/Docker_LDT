# docker-compose setup for the DCT docker stack

Primarily for monitoring of hardware and software at the moment but things
are quickly growing.

## Usage

Once cloned, adjust the version numbers as needed in 
[dockEnvFile.sh](dockEnvFile.sh) and run it as the user who will be
managing the docker data.  

Ensure that the data path exists for that user as well.  The 
__entire__ directory structure needs to be created before the
first use, otherwise docker will create the directories on the fly
and they will likely have permissions problems.

This requires that the .conf files for the 
[DataServants](https://github.com/LowellObservatory/DataServants) 
are complete and in this directory as well. Templates can be found in 
the repository for pointers on how to set them up.

Once those two steps are complete, ```docker-compose build``` should 
create the images with additional steps as well as download the
specified Grafana plugins.  After it's done, ```docker-compose up -d```
should start everything.  Monitor the processes via ```docker stats```
or by setting up the monitor in Grafana.

## 2018 10 04 - Important Caveat!

The Dockerfile for the DataServants python environment is a separate step;
I'm working on pulling that into here still, it'll be obvious once it
drops in.  Attempting to start the docker-compose file before
the pytest image is built by hand will fail!
