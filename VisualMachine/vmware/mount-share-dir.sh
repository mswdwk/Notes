# mount share dir from windows
sudo mkdir -p /mnt/hgfs/
sudo vmhgfs-fuse -o subtype=vmhgfs-fuse,allow_other /mnt/hgfs/
