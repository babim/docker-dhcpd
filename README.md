[![](https://images.microbadger.com/badges/image/babim/dhcpd.svg)](https://microbadger.com/images/babim/dhcpd "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/dhcpd.svg)](https://microbadger.com/images/babim/dhcpd "Get your own version badge on microbadger.com")

# docker-dhcpd
DHCPD on Alpine Linux

# Run
```
docker run -it --name dhcpd --net=host -p 67:67 -p 67:67/udp -v /dhcpoption:/etc/dhcp babim/dhcpd
```

# environment value (with -e)
```
LEASETIME
MAXLEASETIME
SUBNET
NETMASK
BROADCAST
GATEWAY
DNS
WINS
DOMAIN
NTPSERVER
RANGESTART
RANGEEND
FILEBOOT
TFTPSERVER
```

# Default without -e
```
192.168.0.0 /24
```
