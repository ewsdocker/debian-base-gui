# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for debian-base-gui (docker x11 utilities) 
#		in a Debian 9.2 (Stretch) docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 1.0.0
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package debian-base-gui
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#		http://opensource.org/licenses/academic.php
#
# =========================================================================
# =========================================================================
FROM earthwalksoftware/debian-base:9.2
MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get install -y \
            dbus-x11 \
            dmz-cursor-theme \
            file \
            fonts-dejavu \
            fonts-liberation \
            hicolor-icon-theme \
            libglib2.0 \
	        libx11-xcb-dev \
	        libx11-xcb1 \
	        libxrender1 \
            libxt6 \
            xauth \
            xz-utils \
 && apt-get clean all 

ENTRYPOINT ["/my_init"]
CMD ["/bin/bash"]

