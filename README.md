# docker-dhcpd
DHCPD on Alpine Linux

# Run
```
docker run -it --name dhcpd --net=host babim/dhcpd
```

# environment value (with -e)
```
DEFAULTLEASETIME
MAXLEASETIME
SUBNET
NETMASK
BROADCAST
GATEWAY
DNS
DOMAIN
RANGESTART
RANGEEND
```

# Default without -e
```
192.168.0.0 /24
Gateway: 192.168.0.1
DNS: 192.168.0.1
Range: 192.168.0.10 - 192.168.0.200
Domain: example.lan
```
