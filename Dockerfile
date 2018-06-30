FROM babim/alpinebase

## alpine linux
RUN apk add --no-cache wget bash && cd / && wget --no-check-certificate https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh && \
    chmod 755 /option.sh && apk del wget
    
RUN apk add --no-cache dhcp

ADD entrypoint.sh /entrypoint.sh

EXPOSE 67/udp 67/tcp

RUN touch /var/lib/dhcp/dhcpd.leases && chmod +x /entrypoint.sh

#VOLUME ["/etc/dhcp","/var/lib/dhcp/"]
VOLUME ["/etc/dhcp"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
