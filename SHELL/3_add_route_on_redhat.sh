
echo "add route persistent"
echo 'interface ens38's ip is in net 192.168.43.0/24'
sudo bash -c "echo '192.168.1.0/24 via 192.168.43.1' >  /etc/sysconfig/network-scripts/route-ens38"
systemctl restart network
