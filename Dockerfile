FROM babim/alpinebase

RUN apk add --no-cache dhcp

ADD dhcpd.conf /etc/dhcp/dhcpd.conf

EXPOSE 67/udp 67/tcp

RUN ["touch", "/var/lib/dhcp/dhcpd.leases"]

VOLUME ["/etc/dhcp","/var/lib/dhcp/"]

CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
