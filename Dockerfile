FROM hurricane/dockergui:x11rdp1.3
#FROM hurricane/dockergui:x11rdp
#FROM hurricane/dockergui:xvnc

MAINTAINER David Coppit <david@coppit.org>

# User/Group Id gui app will be executed as
ENV USER_ID=99
ENV GROUP_ID=100

ENV APP_NAME="Filebot"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
  && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Remove built-in Java 7
RUN apt-get purge -y openjdk-\* icedtea\*

# Auto-accept Oracle JDK license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Filebot needs Java 8
RUN add-apt-repository ppa:webupd8team/java \
  && apt-get update \
  && apt-get install -y oracle-java8-installer \
  && apt-get clean

# To find the latest version: https://www.filebot.net/download.php?mode=s&type=deb&arch=amd64
# We'll use a specific version for reproducible builds 
RUN set -x \
  && wget -N 'http://downloads.sourceforge.net/project/filebot/filebot/FileBot_4.6/filebot_4.6_amd64.deb' -O /root/filebot.deb \
  && dpkg -i /root/filebot.deb && rm /root/filebot.deb \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Otherwise RDP rendering of the UI doesn't work right.
RUN sed -i 's/java /java -Dsun.java2d.xrender=false /' /usr/bin/filebot

# Default resolution
ENV WIDTH=1280
ENV HEIGHT=720

EXPOSE 3389

COPY startapp.sh /startapp.sh

## I'm not sure if these are actually needed, but they suppress some Java exceptions
#RUN apt-get update \
#  && apt-get install -y libxslt1-dev libgl1-mesa-dev \
#  && apt-get clean
#
## Suppress some errors in the log
#RUN mkdir -p /var/lib/tomcat7/logs

VOLUME ["/input", "/output"]
