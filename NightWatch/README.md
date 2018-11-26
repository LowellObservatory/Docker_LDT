# docker-compose setup for the NightWatch Prototype(s)

Primarily for showing weather images, webcam snippets and images/animations 
from the all sky camera.

## Usage

Once cloned, adjust the version numbers as needed in 
[dockEnvFile.sh](dockEnvFile.sh).

Run the ```dockEnvFile.sh``` as the user who will be
managing the docker data.  This will set up everything that
```docker-compose``` needs to build the services and start them.

Ensure that the data path exists for that user as well.  The 
__entire__ directory structure needs to be created before the
first use, otherwise docker will create the directories on the fly
and they will likely have permissions problems.

Once those steps are complete, ```docker-compose build``` should 
create the images with additional steps needed to flesh out the environment.

After it's done, ```docker-compose up -d```
should start everything.  Monitor the processes via ```docker stats```
or by setting up the monitor in Grafana.
