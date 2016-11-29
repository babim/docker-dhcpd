#!/bin/sh -e

# value
LEASETIME=${LEASETIME:-600}
MAXLEASETIME=${MAXLEASETIME:-7200}
SUBNET=${SUBNET:-192.168.0.0}
NETMASK=${NETMASK:-255.255.255.0}
#BROADCAST=${BROADCAST:-192.168.0.255}
GATEWAY=${GATEWAY:-192.168.0.1}
DNS=${DNS:-8.8.8.8}
#DOMAIN=${DOMAIN:-example.lan}
#NTPSERVER=${NTPSERVER:-192.168.0.1}
#WINS=${WINS:-192.168.0.1}
#RANGESTART=${RANGESTART:-192.168.0.10}
#RANGEEND=${RANGEEND:-192.168.0.200}
FILEBOOT=${FILEBOOT:-pxelinux.0}
#TFTPSERVER=${TFTPSERVER:-192.168.0.200}

# set config
if [ ! -f "/etc/dhcp/dhcpd.conf" ]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
default-lease-time $LEASETIME;
max-lease-time $MAXLEASETIME;
subnet $SUBNET netmask $NETMASK {
	option subnet-mask $NETMASK;
EOF

if [[ ! -z "${GATEWAY}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option routers $GATEWAY;
EOF
fi
if [[ ! -z "${BROADCAST}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option broadcast-address $BROADCAST;
EOF
fi
if [[ ! -z "${DNS}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option domain-name-servers $DNS;
EOF
fi
if [[ ! -z "${DOMAIN}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option domain-name "$DOMAIN";
	option domain-search "$DOMAIN";
EOF
fi
if [[ ! -z "${RANGESTART}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	range $RANGESTART $RANGEEND;
EOF
fi
if [[ ! -z "${NTPSERVER}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option nntp-server $NTPSERVER;
EOF
fi
if [[ ! -z "${WINS}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
	option netbios-name-servers $WINS;
EOF
fi
if [[ ! -z "${TFTPSERVER}" ]]; then
cat <<EOF>> /etc/dhcp/dhcpd.conf
       filename "$FILEBOOT";
       next-server $TFTPSERVER;
EOF
fi

cat <<EOF>> /etc/dhcp/dhcpd.conf
}
EOF
fi

exec "$@"
