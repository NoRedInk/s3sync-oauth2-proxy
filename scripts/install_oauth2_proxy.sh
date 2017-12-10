#!/bin/sh set -ex

export GOPATH=/go GOBIN=/usr/local/bin PATH=/go/bin:/usr/local/go/bin:$PATH

mkdir -p /usr/src/oauth2_proxy
mkdir -p /go
cd /usr/src/oauth2_proxy

wget "https://github.com/${OAUTH2_PROXY_REPO}/archive/${OAUTH2_PROXY_COMMIT}.tar.gz" -O oauth2_proxy.tar.gz
tar -C /usr/src/oauth2_proxy -xzf oauth2_proxy.tar.gz --strip-components=1
go get -v -d
go install -v
rm -rf /go /usr/src/oauth2_proxy /usr/local/go
