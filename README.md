## ewsdocker/debian-base-gui:9.5.2  

**ewsdocker/debian-base-gui** is built on the **ewsdocker/debian-base** docker image, providing a simple GUI stack.  

____  

A pre-made docker image of **ewsdocker/debian-base-gui** is available from [ewsdocker/debian-base-gui](https://hub.docker.com/r/ewsdocker/debian-base-gui/) at [Docker Hub](https://hub.docker.com).  
______  


**Visit our [ewsdocker/debian-base-gui Wiki](https://github.com/ewsdocker/debian-base-gui/wiki) for complete documentation of this docker image.**  

____  

**NOTE**

**ewsdocker/debian-base-gui** is designed to be used on a Linux system configured to support **Docker** _user namespaces_.  Refer to [ewsdocker Containers and Docker User Namespaces](https://github.com/ewsdocker/ewsdocker.github.io/wiki/UserNS-Overview) for an overview and additional information.  

______  


**Installing ewsdocker/debian-base**  

The following scripts will download the the selected **ewsdocker/debian-base** image, create a container, setup and populate the directory structures, create the run-time scripts, and install the application's desktop file(s).  

The <i>default</i> values will install all directories and contents in the <b>docker host</b> user's home directory (refer to <a href="#mapping">Mapping docker host resources to the docker container</a>, below).  

**ewsdocker/debian-base:9.5.2**
  
    docker run --rm \
               -v ${HOME}/bin:/userbin \
               -v ${HOME}/.local:/usrlocal \
               -e LMS_BASE="${HOME}/.local" \
               -v ${HOME}/.config/docker:/conf \
               -v ${HOME}/.config/docker/debian-base-9.5.2:/root \
               --name=debian-base-9.5.2 \
           ewsdocker/debian-base:9.5.2 lms-setup  

____  

**Running the installed scripts**

After running the above command script, and using the settings indicated, the docker host directories, mapped as shown in the above tables, will be configured as follows:

 - the executable scripts have been copied to **~/bin**;  
 - the application desktop file(s) have been copied to **~/.local/share/applications**, and are availablie in any _task bar_ menu;  
 - the associated **debian-base-"version"** executable script (shown below) will be found in **~/.local/bin**, and _should_ be customized with proper local volume names;  

____  

**Execution scripts**  

**ewsdocker/debian-base:9.5.2**  
  
    docker run -it \
               --rm \
               -e DISPLAY=unix${DISPLAY} \
               -v /tmp/.X11-unix:/tmp/.X11-unix \
               -v /tmp/.docker.xauth:/tmp/.docker.xauth \
               -v ${HOME}/.Xauthority:${HOME}/.Xauthority \
               -v /etc/localtime:/etc/localtime:ro \
               -v ${HOME}/workspace-base-9.5.2:/workspace \
               -v ${HOME}/.config/docker/debian-base-9.5.2:/root \
               --name=debian-base-9.5.2 \
           ewsdocker/debian-base:9.5.2 /bin/bash

____  


**Simple tests**  

**Test 1**  

Copy the docker command above (*Creating a container*) and paste it into a docker host command line to create a temporary docker container named **debian-base-9.5.2**.  At the *bash* prompt (**#**), enter the following command:  

    apt-get -y update
    apt-get -y install mousepad  
    /usr/bin/mousepad  

A graphical dialog should appear containing the *mousepad* editor main window.  Exit the *mousepad* program, then exit the container (*exit* 2 times).  

**Test 2**  

Add a new volume to the command above, mapping a local folder container text documents (e.g., *$HOME/Documents*) to an arbitrary folder in the container (e.g., */documents*):  

    -v ${HOME}/Documents:/documents  

Perform the steps in *Test 1* to open the mousepad application.  Using the mousepad file manager, browse to the new folder (*/documents*) and open a text document there.  

____  


**Copyright © 2018. EarthWalk Software.**  
**Licensed under the GNU General Public License, GPL-3.0-or-later.**  

This file is part of **ewsdocker/debian-base-gui**.  

**ewsdocker/debian-base-gui** is free software: you can redistribute 
it and/or modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation, either version 3 of the 
License, or (at your option) any later version.  

**ewsdocker/debian-base-gui** is distributed in the hope that it will 
be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License
along with **ewsdocker/debian-base-gui**.  If not, see 
<http://www.gnu.org/licenses/>.  

