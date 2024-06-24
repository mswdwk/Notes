
# Open DNS service via dnsmasq 

## 1 execute commands like this:
```shell
systemctl start dnsmasq
systemctl status dnsmasq
```

## 2 but get an error like this:

```
dnsmasq: failed to create listening socket for port 53: Address already in use
```
## 3 who occupied udp port 53 ?

```shell
systemctl -a|grep -i -B 2 dns
# result is like below
 ├─libvirtd.service
             │ ├─1254 /usr/sbin/libvirtd
             │ ├─1646 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/libexec/libvirt_leaseshelper
             │ └─1647 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/default.conf --leasefile-ro --dhcp-script=/usr/libexec/libvirt_leaseshelper
```
maybe it is libvirtd.service

## 4 stop libvirtd.service
```shell
systemctl stop libvirtd.service
```
## 5 execute commands in step 1 again





## references
[KVM虚拟化](https://www.cnblogs.com/wxx6925/p/15722289.html)
