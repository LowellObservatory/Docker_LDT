# docker-compose setup for the DCT allsky monitor stack

Primarily for showing webcam snippets and images/animations from the all sky monitor.

## Usage

Once cloned, adjust the version numbers as needed in 
[dockEnvFile.sh](dockEnvFile.sh) and run it as the user who will be
managing the docker data.  

Ensure that the data path exists for that user as well.  The 
__entire__ directory structure needs to be created before the
first use, otherwise docker will create the directories on the fly
and they will likely have permissions problems.

Once those two steps are complete, ```docker-compose build``` should 
create the images with additional steps needed to flesh out the environment.

After it's done, ```docker-compose up -d```
should start everything.  Monitor the processes via ```docker stats```
or by setting up the monitor in Grafana.

## 2018 10 09 - Important Caveat!

It's technically functional, but functionally useless at the moment. 
Still definitely a work-in-progress.

[dockEnvFile.sh](dockEnvFile.sh) is still checking the 
[DCTStack](../DCTStack) data paths; needs to be changed and updated 
once it's clear what the outputs of this actually will be, if any.  
It also might be good to define an input site path too, if we decide 
to not put the actual site as a submodule for whatever reason.
