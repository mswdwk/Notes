
# Background 
Windows Operating System Have more than One Recovery Partition.
# Target
We want to delete the not needed Recovery Partiton to free disk space.
# Delete redundant recovery partition
## Find the active Recovery Partition,not delete it
  找出这个生效的恢复分区：Open 'cmd.exe', input 'reagentc /info' ,then input 'Enter' key
## Use 'diskpart' to delete the not needed/active partiton
 1) Open 'cmd.exe', input 'diskpart', press 'Enter' key
 2) choose the disk
 	```
	list disk
	select disk 2
	```
3) choose the partition, which to delete, eg: partition 6.
	```
	list partition
	select partition 6
	delete partition override
	exit
	```
	use 'override' to force delete partition
# References

[真实案例：我的电脑里有好多个恢复分区](https://www.disktool.cn/content-center/multiple-recovery-partitions-windows-10-666.html)