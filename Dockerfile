FROM golang:1.9-alpine

ENV SUPERVISOR_VERSION=3.3.3

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
ENV OAUTH2_PROXY_COMMIT a9c55bd6d1caeaa7ba20236b2e85129c8219b865
RUN . /tmp/install_oauth2_proxy.sh

RUN mkdir -p /etc/supervisor/config.d/
COPY config/supervisor/*.conf /etc/supervisor/config.d/
COPY config/supervisord.conf /etc/supervisor/

RUN mkdir scripts shared
RUN chmod +x scripts/*

CMD ["/usr/bin/supervisord"]
