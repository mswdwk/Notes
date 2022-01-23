# These steps show you how to add New Added Disk into current VG(the disk Volume Group)

## 0) Env 
	Hardware Env
	a) the Linux System is CentOS/Redhat 7.x 
	b) the Cpu Architecture is x86_64

    Software Env 
	a) the New Added Disk Block Device is /dev/sdb
	b) the VG name is rhel
	c) /dev/mapper/rhel-home is mounted on /home

## 1) login system as root, or use root Privileges like 'sudo xxx' to 
   executed the following commands.

## 2) create physical volume 
```
	pvcreate /dev/sdb
```
	If success,the shell terminal will print:
		"
 		Physical volume "/dev/sdb" successfully created.
		"

## 3) show the new created physical volume
	pvdisplay

## 4) add the PV into VG 'rhel'
```
	# usage: vgextend VG PV
	vgextend rhel /dev/sdb 
```
## 5) extend 20GB disk space to the already exists partiton /dev/mapper/rhel-home
```
	lvextend -L +20GB  /dev/mapper/rhel-home
```
	OR
```
	lvextend -L +20GB  /dev/rhel/home
```
	If success,the shell terminal will print:
		"
		Size of logical volume rhel/home changed from <75.00 GiB (19199 extents) to <95.00 GiB (24319 extents).
  		Logical volume rhel/home successfully resized.
		"

## 6) Let the added 20GB disk space to take effect on '/home'
	Use 'df -T' to display all partiton filesystem type.
	If the filesystem is xfs,then execute 'xfs_growfs /home' to take effect.
	"
		meta-data=/dev/mapper/rhel-home  isize=512    agcount=4, agsize=4914944 blks
				 =                       sectsz=512   attr=2, projid32bit=1
				 =                       crc=1        finobt=0 spinodes=0
		data     =                       bsize=4096   blocks=19659776, imaxpct=25
				 =                       sunit=0      swidth=0 blks
		naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
		log      =internal               bsize=4096   blocks=9599, version=2
				 =                       sectsz=512   sunit=0 blks, lazy-count=1
		realtime =none                   extsz=4096   blocks=0, rtextents=0

	"
	

## 7) create a new partiton /dev/mapper/rhel-data, named 'data'

```
	#use all free disk space on VG rhel
	lvcreate -l 100%VG -n data rhel	
```
	If success,the shell terminal will print.
	' 
		Logical volume "data" created.
	'	

## 8) Mount New Created Partition 'data'	
### 8-1) temporary mount 
```
	mkdir /data
	mount /dev/mapper/rhel-data /data
```
### 8-2) parmanent mount on /etc/fstab
	Append the following content into file /etc/fstab
```
	/dev/mapper/rhel-data   /data                   xfs     defaults        0 0	
```
