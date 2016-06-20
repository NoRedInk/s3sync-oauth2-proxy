FROM ubuntu:trusty
MAINTAINER eterna2 <eterna2@hotmail.com>

RUN apt-get update && apt-get install -y \
  automake \
  autotools-dev \
  g++ \
  git \
  libcurl4-gnutls-dev \
  libfuse-dev \
  libssl-dev \
  libxml2-dev \
  make \
  pkg-config \
  supervisor

WORKDIR /home/

COPY scripts/* /tmp/
RUN chmod +x /tmp/*.sh
RUN . /tmp/install_s3fs.sh

COPY config/fuse.conf /etc/fuse.conf
COPY config/supervisor/*.conf /etc/supervisor/conf.d/

RUN mkdir scripts
COPY scripts/runS3fs.sh scripts/runS3fs.sh
RUN chmod +x scripts/*

CMD ["/usr/bin/supervisord"]
