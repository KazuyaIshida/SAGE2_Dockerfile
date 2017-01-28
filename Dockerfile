# This Dockerfile will create an image of SAGE2.

# FROM Ubuntu
FROM ubuntu:latest

# MAINTAINER is ishidakazuya
MAINTAINER ishidakazuya

# COPY package.json
COPY package.json /tmp/package.json

# Install SAGE2 
RUN echo "deb http://us.archive.ubuntu.com/ubuntu trusty main universe" >> /etc/apt/sources.list \
&& apt-get -y update \
&& apt-get -y upgrade \
&& apt-get install -y software-properties-common libavformat-extra-54 libavformat-dev libavcodec-extra-54 libavcodec-dev ffmpeg libavutil-dev git curl libswscale-dev \
&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
&& apt-get -y install wget nodejs ghostscript libwebp-dev bzip2 devscripts libx264-dev yasm libnss3-tools libimage-exiftool-perl libgs-dev imagemagick libwebp5 g++ make libgraphviz-dev libmagickcore-dev libmagickwand-dev libmagick++-dev \
&& apt-get clean \
&& cd /tmp \
&& npm install \
&& git clone https://bitbucket.org/sage2/sage2.git /sage2 \
&& cp -a /tmp/node_modules /sage2 \
&& cd /sage2 \
&& npm run in

# USE Port 9292 and 9090
EXPOSE 9292
EXPOSE 9090

# ENTRYPOINT is tail -f /dev/null
ENTRYPOINT tail -f /dev/null

