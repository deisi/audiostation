#!/bin/sh

if [ ! -f "/etc/mopidy/mopidy.conf" ]
then
    cp /etc/default/mopidy.conf  /etc/mopidy/mopidy.conf
fi

mopidy --config /etc/mopidy/mopidy.conf local scan "$@"
mopidy --config /etc/mopidy/mopidy.conf "$@"
