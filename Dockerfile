FROM golang:1.9-alpine

ENV SUPERVISOR_VERSION=3.3.3
ENV S3_LOCAL_DIR=/home/shared/s3

RUN apk update && apk add -u \
    git \
    python \
    py-pip \
    bash \
    openssl \
    tar \
    wget \
    ca-certificates

RUN pip install --upgrade pip
RUN pip install --upgrade awscli pid supervisor==$SUPERVISOR_VERSION

WORKDIR /home/

COPY scripts/install_oauth2_proxy.sh /tmp/
RUN chmod +x /tmp/install_oauth2_proxy.sh

ENV OAUTH2_PROXY_REPO bitly/oauth2_proxy
ENV OAUTH2_PROXY_COMMIT d75f626cdd664fa75552717c4abd3018877d3b2c
RUN . /tmp/install_oauth2_proxy.sh

RUN mkdir -p /etc/supervisor/config.d/
COPY config/supervisor/*.conf /etc/supervisor/config.d/
COPY config/supervisord.conf /etc/supervisor/
COPY config/crontab crontab
RUN crontab crontab

RUN mkdir scripts
COPY scripts/run_s3sync.py scripts/run_s3sync.py
RUN chmod +x scripts/*

RUN mkdir -p "$S3_LOCAL_DIR"

CMD ["/usr/bin/supervisord"]
