FROM nginx:alpine

ARG VERSION=6.0.1

ENV TAIGA_HOST=taiga.lan \
    TAIGA_PORT=80 \
    TAIGA_SCHEME=http

WORKDIR /srv/taiga

RUN apk add --no-cache curl && \
    rm /etc/nginx/conf.d/default.conf && \
    mkdir /run/nginx && \
    curl -#L https://github.com/taigaio/taiga-front-dist/archive/$VERSION.tar.gz > dist.tar.gz && \
    tar -xzf dist.tar.gz && mv taiga-front-dist-* front && \
    cd front && \
    rm dist/conf.example.json

WORKDIR /srv/taiga/front/dist

COPY start.sh /
COPY nginx.conf /etc/nginx/conf.d/
COPY config.json /tmp/taiga-conf/

VOLUME ["/taiga-conf"]

CMD ["/start.sh"]
