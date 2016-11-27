FROM babim/alpinebase

RUN apk add --no-cache dhcp

ADD entrypoint.sh /entrypoint.sh

EXPOSE 67/udp 67/tcp

RUN touch /var/lib/dhcp/dhcpd.leases && chmod +x /entrypoint.sh

VOLUME ["/etc/dhcp","/var/lib/dhcp/"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
