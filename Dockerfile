FROM alpine:3.7

LABEL name "Docker LND"
LABEL maintainer "the729 <lnd.docker@wutj.info>"

ARG LND_VERSION=0.5-beta

RUN cd /root && mkdir .lnd && \
    apk add --no-cache ca-certificates openssl tar && \
    wget https://github.com/lightningnetwork/lnd/releases/download/v${LND_VERSION}/lnd-linux-amd64-v${LND_VERSION}.tar.gz && \
    tar xzvf lnd-linux-amd64-v${LND_VERSION}.tar.gz && \
    mv lnd-linux-amd64-v${LND_VERSION}/lncli /bin/ && \
    mv lnd-linux-amd64-v${LND_VERSION}/lnd /bin/ && \
    apk del --purge tar openssl && \
    rm -Rf lnd-linux-amd64-v${LND_VERSION}

VOLUME /root/.lnd

EXPOSE 9735 10009 8080

ENTRYPOINT  ["/bin/lnd"]
