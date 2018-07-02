FROM sage2/master:latest
MAINTAINER ishidakazuya

RUN apt-get -y update \
&& apt-get -y upgrade \
&& cd /sage2 \
&& npm install --production \
&& npm run in \
&& apt-get -y remove curl bzip2 \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

EXPOSE 9090
EXPOSE 9292
WORKDIR /sage2
CMD /bin/bash

