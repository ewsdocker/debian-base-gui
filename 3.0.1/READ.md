## debian-base-gui
*EarthWalkSoftware/debian-base-gui* builds upon *EarthWalkSoftware/debian-base* to include basic X11 client graphics packages to leverage the docker host's display.  

A docker image for [EarthWalkSoftware/debian-base-gui](https://hub.docker.com/r/earthwalksoftware/debian-base-gui/) is available from [EarthWalk Software](https://hub.docker.com/r/earthwalksoftware) at [Doc Hub](https://hub.docker.com).

______
### Docker Tags

**docker pull** will pull the **latest** image by default, but you can specify other versions (or tags) in the Docker **Tags** link, above.  For a description of how the debian-base-gui tags work, go to the [Docker Tags](https://github.com/EarthWalkSoftware/debian-base-gui/wiki/Docker-Tags) page of the [EarthWalk Software debian-base-gui Wiki](https://github.com/EarthWalkSoftware/debian-base-gui/wiki).

----

**Read more** about **EarthWalkSoftware/debian-base-gui** at [EarthWalk Software debian-base-gui Wiki](https://github.com/EarthWalkSoftware/debian-base-gui/wiki).

______
### Packages
Among the additional packages are 
- *dbus-x11*
- *dmz-cursor-theme*
- *file*
- *fonts-dejavu*
- *fonts-liberation*
- *hicolor-icon-theme*
- *libdbus-glib-1-2*
- *libglib2.0*
- *libstdc++6*
- *libx11-xcb-dev*
- *libx11-xcb1*
- *libxrender1*
- *libxt6*
- *xauth*
- *xz-utils*

______
### Creating a container
The following command will create a docker container named *gui* and start a console version of *bash*:

    docker run -it \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v /tmp/.docker.xauth:/tmp/.docker.xauth \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v /etc/localtime:/etc/localtime:ro \
               --rm \
               --name=gui \
           earthwalksoftware/debian-base-gui /bin/bash  

______
### Docker RUN options

The following settings are (the minimum) required docker RUN options for all containers created using, or deriving *FROM*, the *earthwalksoftware/debian-base-gui* docker image:

#### Environment variables

- *DISPLAY*  
Used to set the docker host's display to use. Normally, set to the default host display  

    -e DISPLAY=unix${DISPLAY}

#### Volumes

- *X11-unix*  
Maps the *docker container*'s to the *docker host*'s X11 driver. Normally set to  

    -v /tmp/.X11-unix:/tmp/.X11-unix  

- *docker.xauth*  
Maps the docker container's to the docker host's xauth file.  Normally set to  

    -v /tmp/.docker.xauth:/tmp/.docker.xauth  

- *.Xauthority*  
Maps the  docker container's .Xauthority file to the docker host's .Xauthority file.  Normally set to  

    -v ${HOME}/.Xauthority:${HOME}/.Xauthority  

______
## Simple tests

#### Test 1
Copy the docker command above (*Creating a container*) and paste it into a docker host command line to create a temporary docker container named *gui*.  At the *bash* prompt (#), enter the following command:

    apt install mousepad  
    /usr/bin/mousepad  

A graphical dialog should appear containing the *mousepad* editor main window.  Exit the *mousepad* program, then exit the container (*exit* 2 times).

#### Test 2
Add a new volume to the command above, mapping a local folder container text documents (e.g., *$HOME/Documents*) to an arbitrary folder in the container (e.g., */documents*):

    -v ${HOME}/Documents:/documents

Perform the steps in *Test 1* to open the mousepad application.  Using the mousepad file manager, browse to the new folder (*/documents*) and open a text document there.

______
### locale
The following locale is automatically created in the image:  

    locale-gen en_US
    update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX   
    
This setting may be changed in the Dockerfile (using the RUN command) when building a new container from the *earthwalksoftware/debian-base-gui* image, 

------
### The name's too long! (or, how to localize a docker image from a repository)
This can be resolved in 3 steps:

- Pull the image down to the local docker host:  

    docker pull earthwalksoftware/debian-base-gui:latest  

- Tag the new image with a shorter name (e.g. - *debian-base-gui:1.0.0*):  

    docker tag earthwalksoftware/debian-base-gui:latest debian-base-gui:1.0.0  

- Remove the original image tag:  

    docker rmi earthwalksoftware/debian-base-gui:latest  

- View docker images  

    docker images  

The *debian-base-gui:1.0.0* image is now located on the local docker host.

------
### Security concerns
This implementation does not do much to *harden* the docker host-container interface.  It is fairly light-weight and intended for use on secure internal and/or external LANs and/or vLANs.  

When using the X11 server over a WAN (e.g., Internet), additional steps to isolate the docker container from the docker host must be taken.  Docker offers many RUN-time options for controlling the host-container interface, and can be explored at the Docker Docs site:

  https://docs.docker.com/engine/reference/run/#operator-exclusive-options

Alternatively, a more robust and secure solution, such as *x11docker* and *x11docker-gui*, is worthy of investigation:

  https://github.com/mviereck/x11docker  

------
### Licensed by Academic Free License v 3.0

Read the license at https://github.com/EarthWalkSoftware/debian-base-gui/wiki/License
____

*2017-12-26. Jay Wheeler @ EarthWalkSoftware*
