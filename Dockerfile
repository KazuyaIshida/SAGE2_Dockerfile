# This Dockerfile creates the Docker image of SAGE2.

# FROM CentOS
FROM centos:latest

# MAINTAINER is ishidakazuya
MAINTAINER ishidakazuya

# Install SAGE2 
RUN yum -y update \
&& rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro \
&& rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm \
&& yum -y install autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel perl-devel openssl \
&& git clone https://github.com/FFmpeg/FFmpeg /root/FFmpeg \
&& cd /root/FFmpeg \
&& ./configure --disable-x86asm --enable-shared \
&& make -j8 \
&& make install \
&& cd /root \
&& curl -O http://imagemagick.org/download/ImageMagick-6.9.9-15.tar.gz \
&& tar -xvf ImageMagick-6.9.9-15.tar.gz \
&& cd ImageMagick-6.9.9-15 \
&& ./configure --with-gslib \
&& make -j8 \
&& make install \
&& cd /root \
&& curl -O https://sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.61.tar.gz \
&& tar -xvf Image-ExifTool-10.61.tar.gz \
&& cd Image-ExifTool-10.61 \
&& perl Makefile.PL \
&& make -j8 test \
&& make install \
&& cd /root \
&& curl -O https://nodejs.org/dist/v6.11.3/node-v6.11.3.tar.gz \
&& tar -xvf node-v6.11.3.tar.gz \
&& cd node-v6.11.3 \
&& ./configure \
&& make -j8 \
&& make install \
&& echo "include ld.so.conf.d/*.conf" >> /etc/ld.so.conf \
&& echo "/usr/local/lib" >> /etc/ld.so.conf \
&& ldconfig \
&& git clone https://bitbucket.org/sage2/sage2.git /usr/local/sage2 \
&& cd /usr/local/sage2 \
&& npm install \
&& rm -rf /root/node-v6.11.3 \
&& rm -rf /root/Image-ExifTool-10.61 \
&& rm -rf /root/ImageMagick-6.9.9-15 \
&& rm -rf /root/FFmpeg \
&& rm /root/node-v6.11.3.tar.gz \
&& rm /root/Image-ExifTool-10.61.tar.gz \
&& rm /root/ImageMagick-6.9.9-15.tar.gz \
&& yum remove -y autoconf automake cmake gcc gcc-c++ git libtool make mercurial perl-devel \
&& yum clean all

# EXPOSE Port 9090 and 9292
EXPOSE 9090
EXPOSE 9292

# CMD is /bin/bash
CMD /bin/bash

