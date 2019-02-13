#!/bin/sh

INITIAL_SETUP_LOCK=/taiga-conf/.initial_setup.lock
if [ ! -f $INITIAL_SETUP_LOCK ]; then
	touch $INITIAL_SETUP_LOCK
	[ "$TAIGA_SCHEME" = 'https' ] && TAIGA_WS_SCHEME=wss || TAIGA_WS_SCHEME=ws
	sed -e 's/$TAIGA_HOST/'$TAIGA_HOST'/' \
		-e 's/$TAIGA_SCHEME/'$TAIGA_SCHEME'/' \
		-e 's/$TAIGA_WS_SCHEME/'$TAIGA_WS_SCHEME'/' \
		-i /tmp/taiga-conf/config.json
	cp /tmp/taiga-conf/config.json /taiga-conf/
	ln -sf /taiga-conf/config.json /srv/taiga/front/dist/conf.json
else
    ln -sf /taiga-conf/config.json /srv/taiga/front/dist/conf.json
fi

exec nginx -g 'daemon off;'
