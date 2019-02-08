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
# @version 9.6.4
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

ARG ARGBUILD_REPO="ewsdocker"
ARG ARGBUILD_NAME="debian-base-gui"
ARG ARGBUILD_VERSION="9.6.4"
#ARG ARGBUILD_EXT=

ARG ARG_SOURCE=

# ==============================================================================

ARG ARG_FROM_REPO="ewsdocker/debian-base"
ARG ARG_FROM_VERS="9.6.2"
ARG ARG_FROM_EXT=

FROM "${ARG_FROM_REPO}:${ARG_FROM_VERS}"

# ==============================================================================

MAINTAINER Jay Wheeler <EarthWalkSoftware@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# =========================================================================
#
#    Docker Build Arguments
#
# =========================================================================
#
#   ARG_SOURCE    <= url of the local source (http://alpine-nginx-pkgcache), 
#                      otherwise external source.
#
#   ARGBUILD_VERSION   <= version of debian-base-gui (9.6.4)
#
#   ARGBUILD_EXT  <= version of debian-base-gui  to build 
#					   empty ==> master version (9.6.4),
#					   -gtk2 ==> GTK-2  version (9.6.4-gtk2)
#                      -gtk3 ==> GTK-3  version (9.6.4-gtk3)
#
#   ARG_FROM_VERS <= debian-base version (9.6.1)
#
#   =======================================================================
#
#   For example, build debian-base-gui gtk3 version of the current release:
#
#     cd to the directory containing debian-base-gui Dockerfile
#
#     docker build -t ewsdocker/debian-base-gui:9.6.4-gtk3 \
#      --build-arg ARGBUILD_EXT="-gtk3" \
#      --build-arg ARGBUILD_VERSION="9.6.4" .
#
#   =======================================================================
#
#   For example, build the standard debian-base-gui (master) version 
#        of the current release from the GitHub repo:
#
#     cd to the directory containing debian-base-gui Dockerfile
#
#     docker build -t ewsdocker/debian-base-gui:9.6.4 .
#
# =========================================================================

ARG ARG_SOURCE

ARG ARGBUILD_REPO
ARG ARGBUILD_NAME
ARG ARGBUILD_VERSION
ARG ARGBUILD_EXT

ARG ARG_FROM_REPO
ARG ARG_FROM_VERS
ARG ARG_FROM_EXT

# =========================================================================
#
#   setup LMSBUILD environment
#
# =========================================================================

ENV LMSBUILD_VERSION=${ARGBUILD_VERSION:-"9.6.4"}${ARGBUILD_EXT}
ENV LMSBUILD_NAME=${ARGBUILD_NAME:-"debian-base-gui"} 
ENV LMSBUILD_REPO=${ARGBUILD_REPO:-"ewsdocker"}
ENV LMSBUILD_REGISTRY=""

# =========================================================================
#
#   setup /etc/ewsdocker-builds.txt parameters
#
# =========================================================================

ENV LMSBUILD_PARENT="${ARG_FROM_REPO}:${ARG_FROM_VERS}"

ENV LMSBUILD_DOCKER="${LMSBUILD_REPO}/${LMSBUILD_NAME}:${LMSBUILD_VERSION}" 
ENV LMSBUILD_PACKAGE="${LMSBUILD_PARENT}"

# =========================================================================
#
#   Copy scripts/icons into the proper folders
#
# =========================================================================

COPY scripts/. / 

# =========================================================================
#
#   Install and configure the GUI system and support files
#
# =========================================================================

RUN \
 # =========================================================================
 #
 #    build the apt repo cache and install base support for GUI
 #
 # =========================================================================
    apt-get -y update \
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
	        libx11-xcb-dev \
	        libx11-xcb1 \
            libxt6 \
            xauth \
            xz-utils \
 #
 # =========================================================================
 #
 #    Install gtk2, if requested
 #
 # =========================================================================
 #
 && if test "${ARGBUILD_EXT}" = "-gtk2" ; then apt-get -y install libgtk2.0-0 libgtk2.0-bin libgtk2.0-common; fi \ 
 #
 # =========================================================================
 #
 #   or gtk3, if requested
 #
 # =========================================================================
 #
 && if test "${ARGBUILD_EXT}" = "-gtk3" ; then apt-get -y install libgtk-3-0 libgtk-3-bin libgtk-3-common; fi \ 
 #
 # =========================================================================
 #
 #    clean up apt repo
 #
 # =========================================================================
 #
 && apt-get clean all \
 #
 # =========================================================================
 #
 #   create a container version tag for FullName (with no tag for 'latest' version)
 #
 # =========================================================================
 #
 && if [ "${LMSBUILD_VERSION}" != "latest" ]; then LMSBUILD_FULLNAME="${LMSBUILD_NAME}:${LMSBUILD_VERSION}"; fi \
 #
 # =========================================================================
 #
 #   rename the template to the run script name and enable editing
 #
 # =========================================================================
 #
 && cd /usr/local/bin \
 && mv template ${LMSBUILD_NAME}-${LMSBUILD_VERSION} \
 && chmod 775 ${LMSBUILD_NAME}-${LMSBUILD_VERSION} \
 #
 # =========================================================================
 #
 #   customize the docker run command
 #
 # =========================================================================
 #
 && echo -n '-v ${HOME}/.config/docker/' >> /usr/local/bin/${LMSBUILD_NAME}-${LMSBUILD_VERSION}  \
 && echo "${LMSBUILD_NAME}-${LMSBUILD_VERSION}:/root --name=${LMSBUILD_NAME}-${LMSBUILD_VERSION} ${LMSBUILD_REPO}/${LMSBUILD_FULLNAME}" >> /usr/local/bin/${LMSBUILD_NAME}-${LMSBUILD_VERSION} \
 #
 # =========================================================================
 #
 #   finish clean-up
 #
 # =========================================================================
 #
 && chmod +x /usr/bin/lms/* \
 #
 # =========================================================================
 #
 #   register the build with /etc/ewsdocker-builds.txt
 #
 # =========================================================================
 #
 && printf "${LMSBUILD_DOCKER} (${LMSBUILD_PACKAGE}), %s @ %s\n" `date '+%Y-%m-%d'` `date '+%H:%M:%S'` >> /etc/ewsdocker-builds.txt 

# =========================================================================

ENTRYPOINT ["/my_init", "--quiet"]
CMD ["/bin/bash"]
