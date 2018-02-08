#!/bin/sh

INITIAL_SETUP_LOCK=/run/initial_setup.lock
if [ ! -f $INITIAL_SETUP_LOCK ]; then
	touch $INITIAL_SETUP_LOCK
	sed -e 's/$TAIGA_HOST/'$TAIGA_HOST'/' \
		-i /tmp/taiga-conf/config.json
	cp /tmp/taiga-conf/config.json /taiga-conf/
	ln -sf /taiga-conf/config.json /srv/taiga/front/dist/conf.json
fi

exec nginx -g 'daemon off;'