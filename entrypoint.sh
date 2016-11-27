#!/bin/sh

# value
LEASETIME=${LEASETIME:-600}
MAXLEASETIME=${MAXLEASETIME:-7200}
SUBNET=${SUBNET:-192.168.0.0}
NETMASK=${NETMASK:-255.255.255.0}
#BROADCAST=${BROADCAST:-192.168.0.255}
#GATEWAY=${GATEWAY:-192.168.0.1}
#DNS=${DNS:-192.168.0.1}
#DOMAIN=${DOMAIN:-example.lan}
#RANGESTART=${RANGESTART:-192.168.0.10}
#RANGEEND=${RANGEEND:-192.168.0.200}
FILEBOOT1=${FILEBOOT:-pxelinux.0}
#TFTPSERVER=${TFTPSERVER:-192.168.0.200}

# set config
if [ ! -f "/etc/dhcp/dhcpd.conf" ]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
default-lease-time $LEASETIME;
max-lease-time $MAXLEASETIME;
subnet $SUBNET netmask $NETMASK {
	option subnet-mask $NETMASK;
EOF
if [[ ! -z "${BROADCAST}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option broadcast-address $BROADCAST;
EOF
if [[ ! -z "${DNS}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option domain-name-servers $DNS;
EOF
if [[ ! -z "${DOMAIN}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option domain-name "$DOMAIN";
	option domain-search "$DOMAIN";
EOF
if [[ ! -z "${RANGESTART}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	range $RANGESTART $RANGEEND;
EOF
if [[ ! -z "${GATEWAY}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option routers $GATEWAY;
EOF	
if [[ ! -z "${TFTPSERVER}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
       filename "$FILEBOOT1";
       next-server $TFTPSERVER
EOF
cat <<EOF>> /etc/dhcp/dhcpd.conf
}
EOF
fi

exec "$@"
