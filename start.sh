#!/bin/sh

update_configs() {
    [ "$TAIGA_SCHEME" = 'https' ] && TAIGA_WS_SCHEME=wss || TAIGA_WS_SCHEME=ws
    sed -e 's/$TAIGA_HOST/'$TAIGA_HOST'/' \
        -e 's/$TAIGA_SCHEME/'$TAIGA_SCHEME'/' \
        -e 's/$TAIGA_WS_SCHEME/'$TAIGA_WS_SCHEME'/' \
        /tmp/taiga-conf/config.json > /taiga-conf/config.json

    ln -sf /taiga-conf/config.json /srv/taiga/front/dist/conf.json
}

update_configs

exec nginx -g 'daemon off;'
