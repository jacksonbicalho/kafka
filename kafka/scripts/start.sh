#!/bin/bash

# Optional ENV variables:
# * ADVERTISED_LISTENERS:
# https://kafka.apache.org/documentation/#brokerconfigs_advertised.listeners

#Set the advertised.listeners
if [ ! -z "$ADVERTISED_LISTENERS" ]; then

    ADVERTISED_LISTENERS_SCAPED="${ADVERTISED_LISTENERS//\//\\/}"

    if grep -q "^advertised.listeners" /opt/kafka/config/server.properties; then

        sed -i "s/^\(advertised\.listeners\s*=\s*\).*\$/\1$ADVERTISED_LISTENERS_SCAPED/" /opt/kafka/config/server.properties

    else
        LINE=$(grep -n "#advertised.listeners" /opt/kafka/config/server.properties | cut -d : -f 1)
        if [ $LINE > 0 ]; then
            ((++LINE))
            sed -i "${LINE}i\advertised.listeners=$ADVERTISED_LISTENERS_SCAPED" /opt/kafka/config/server.properties
        fi
    fi
fi

#start kafka server
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
