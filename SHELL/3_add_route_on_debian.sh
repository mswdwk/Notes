#!/bin/bash env

OS=`uname -o`

ROUTE_SCRIPT=/etc/network/if-up.d/set-route 
echo 'add persistent route'

if [ "$OS" = "GNU/Linux" ];then
	#sudo ip route add 192.168.43.0/24 via 192.168.1.6
	#sudo bash -c "echo '192.168.1.0/24 via 192.168.43.1' >  /etc/sysconfig/network-scripts/route-ens38"
	
	sudo bash -c "cat <<EOF > $ROUTE_SCRIPT  
#!/bin/sh
ip route del 192.168.43.0/24
# host 192.168.1.6 has another ip address 192.168.43.1 .
ip route add 192.168.43.0/24 via 192.168.1.6 dev enp0s31f6
EOF"
	sudo chmod +x  $ROUTE_SCRIPT
	sudo systemctl restart NetworkManager
else
	echo "unsupport"
fi
