# Problem: grub error,when windows reboot because of upgrade
``` 
error: unknow filesystem
Entering rescue mode...
grub rescue>
```
# grub help
## use 'ls' to get the partition filesystem
## use 'set' to config the right partition

# repair the linux launch partition
```
grub rescue> set root=(hd0,partition_name_1)
grub rescue> set prefix=(hd0,partition_name_1)/boot/grub
grub rescue> insmod normal
```