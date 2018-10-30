# docker-compose setup for the DCT docker stack

Primarily for monitoring of hardware and software at the moment but things
are quickly growing.

## Usage

Once cloned, adjust the version numbers as needed in 
[dockEnvFile.sh](dockEnvFile.sh) and run it as the user who will be
managing the docker data.  

**NOTE** remember to clone on the command line so you can 
grab the submodules in one go as well:

```git clone --recurse-submodules https://github.com/LowellObservatory/DockerDev.git```

If you forget, then navigate to the LIG subdirectory and do this:

```git submodule update --init --recursive```

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

## 2018 10 05 - Important Caveat!

I haven't tested a fresh start/clone since I put in the LIG
codes as submodules; it's possible I'm forgetting a 
```git submodule update --remote --merge``` step before everything
will build, or maybe it's an initial flag during the initial clone
operation that I'm forgetting.  Just a warning.
