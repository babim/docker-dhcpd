#!/bin/sh

# value
DEFAULTLEASETIME=${DEFAULTLEASETIME:-600}
MAXLEASETIME=${MAXLEASETIME:-7200}
SUBNET=${SUBNET:-192.168.0.0}
NETMASK=${NETMASK:-255.255.255.0}
BROADCAST=${BROADCAST:-192.168.0.255}
GATEWAY=${GATEWAY:-192.168.0.1}
DNS=${DNS:-192.168.0.1}
DOMAIN=${DOMAIN:-example.com}

# set config
if [ ! -f "/etc/dhcp/dhcpd.conf" ]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
default-lease-time $DEFAULTLEASETIME;
max-lease-time $MAXLEASETIME;
subnet $SUBNET netmask $NETMASK {
	option routers $GATEWAY;
	option subnet-mask $NETMASK;
	option broadcast-address $BROADCAST;
	option domain-name-servers $DNS;
	option domain-name "$DOMAIN";
	option domain-search "$DOMAIN";
}
EOF
fi

exec "$@"
