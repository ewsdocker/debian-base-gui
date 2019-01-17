# =========================================================================
# =========================================================================
#
#	Dockerfile
#	  Dockerfile for debian-base-gui (docker gui utilities) 
#		in a Debian docker container.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 9.6.2-gtk2
# @copyright © 2017-2019. EarthWalk Software.
# @license Licensed under the GNU General Public License, GPL-3.0-or-later.
# @package ewsdocker/debian-base-gui
# @subpackage Dockerfile
#
# =========================================================================
#
#	Copyright © 2017-2019. EarthWalk Software
#	Licensed under the GNU General Public License, GPL-3.0-or-later.
#
#   This file is part of ewsdocker/debian-base-gui.
#
#   ewsdocker/debian-base-gui is free software: you can redistribute 
#   it and/or modify it under the terms of the GNU General Public License 
#   as published by the Free Software Foundation, either version 3 of the 
#   License, or (at your option) any later version.
#
#   ewsdocker/debian-base-gui is distributed in the hope that it will 
#   be useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
#   of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with ewsdocker/debian-base-gui.  If not, see 
#   <http://www.gnu.org/licenses/>.
#
# =========================================================================
# =========================================================================
FROM ewsdocker/debian-base:9.6.2
MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# =========================================================================
#
#	gtk2 build context
#
#		docker build -t ewsdocker/debian-base-gui:9.6.2-gtk2 gtk2
#     or
#		cd gtk2
#		docker build -t ewsdocker/debian-base-gui:9.6.2-gtk2
#
# =========================================================================

ENV LMSBUILD_VERSION="9.6.2-gtk2"
ENV LMSBUILD_NAME=debian-base-gui 
ENV LMSBUILD_REPO=ewsdocker
ENV LMSBUILD_REGISTRY=""

ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="debian-base:9.6.1"

# =========================================================================

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get install -y \
            dbus-x11 \
            dmz-cursor-theme \
            file \
            fonts-dejavu \
            fonts-liberation \
            fonts-opensymbol \
            hicolor-icon-theme \
            libglib2.0 \
            libgtk2.0-0 \
            libgtk2.0-bin \
            libgtk2.0-common \
	        libx11-xcb-dev \
	        libx11-xcb1 \
	        libxrender1 \
            libxt6 \
            xauth \
            xz-utils \
 && apt-get clean all \
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt  

# =========================================================================

COPY scripts/. /

RUN chmod 775 /usr/local/bin/* 

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["/bin/bash"]
