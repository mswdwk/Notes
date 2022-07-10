# Background
My EFI partition is only 100MB, and it is full usage.
So I need to extend some free DISK space to EFI partition.
# Target: extend about 400MB disk space to EFI partion
# ATTENTION: Keep Windows 11 and ArchLinux working well even if reboot.
# TOOLS: Diskgenius
# BOOT PARTION:
   	ArchLinux:   mount /dev/nvme0n1p1  /boot/efi
		Archlinux own boot partition is IN /boot/grub/
   	Windows 11: boot partition /EFI is IN Archlinux /boot/efi/EFI    
## Boot-patition-demo-On-Archlinux
     /boot/efi/EFI/
		  |-Archlinux
			|-grubx64.efi
		  |-Boot
			|-bootx64.efi
		  |-Microsoft
			|-Boot
			    |-BCD
			|-bootmgfw.efi
		  	|-Recovery
			    |-BCD
# Adjust Windows C disk size, release 400MB disk space from the C disk head.
## Zero 1: BACKUP your Important Personal Data ON Windows System Disk 'C:'.
	For example, "C:/Users/yourusername/Documents".
## Zero 2: BACKUP your EFI partion data,which is used to boot your OS
	Windows System by Firmware
## First, Login Windows 11 System, download Diskgenius and run
## Second, choose the Windows 'C:' disk
	right click it, then choose 'Adjust Partition Size',then you'll get disk sector start id of this partition.
## Three, calculate the Start Secotr of 'C:' disk
	As a Secotr Size is 512 Bytes, if you want to release 400MB disk space from 
	'C:' disk, you need 400 *1024 *1024 /512= 819600 sectors.
	Assume that 'C:' disk Start sector is 100*1024*2 (sector) before change, 
	move back 400MB, Then the 'C:' disk Start sector location is 
	100 * 1024 * 2 (sector) + 400 * 1024 * 2（sector）= 1024000 (sector)
## Four, adjust the Start Sector of 'C:' disk
	input 1024000 to the Start Sector Location
## Five, Apply
   A few memont later , your Windows 11 System will reboot, Diskgenius works
,then 'C:' disk space reduce 400MB, however , 'C:' system Disk is OK.
# Adjust EFI partition size, you'd better run fdisk on Linux System.
## if you want to delete MSR partition ,make sure MSR partion has no contents.
   use diskgenius on to check
## you can use fdisk to create MSR partition on Linux System.
	MSR: maybe is '10 Microsoft reserved'
## Use fdisk/gdisk to extend EFI partion
1) if boot partiton is '/dev/nvme0n1p1', 
 shell> sudo fdisk /dev/nvme0n1
2) backup data in  efi partition
3) delete efi partition
4) create new efi partition, full usage of the head 500MB disk space.
5) set the partition type to EFI
6) shell> mkfs.vfat /dev/nvme0n1p1
7) shell> sudo mount /dev/nvme0n1p1 /boot/efi
8) copy back origin data in efi partition
## [optional] update grub.cfg
```shell
grub-mkconfig -o /boot/grub/grub.cfg 
```
# Tips
## if your windows EFI partition data lost or erased 
    create a Windows Install U disk, then boot from the Window Install U Disk.
    Input Shift + F10, then enter Command interface.
    Input 'bcdboot C:\Windows /s S: /f uefi /l zh-cn ',if success, you'll recover the 
    Windows Boot EFI partition data to /EFI.
    Comment:  '/s' special the ESP partition,
	     'S' is the disk label you assign by 'diskpart' command to EFI partition
              '/f' special the format uefi
	      '/l' specail the language
	      'C:\Windows' specail the 'Windows System' disk location,maybe is 'D:\Windows' 
	      and so on.

# Optimization
## what occupy the EFI partition 100MB disk space
	Answer:
	1) Before efi partition adjust
	   The efi partiton mount point and grub install location are setted like below.
	```shell
	mount /dev/nvme0n1p1 /boot
	sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ArchLinux 
	```
	As you see,the grub and efi are both under /boot/, which has only 100MB disk space. 
	
	 2) Before efi partition adjust 
	The /boot/grub occupies about 65MB, the /boot/efi/ occupies about 34MB.
	The efi partiton has almostly no disk space left.
## Optimization
	Keep /dev/nvme0n1p1 only mount /boot/efi not contains /boot/grub.
	Split /boot/grub and /boot/efi,let /boot/grub occupies the Linux 
	System partition disk space.
	```shell
	mount /dev/nvme0n1p1 /boot/efi
	sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
	```
	When you install grub by 'pacman -S grub', it is installed under /boot/grub,which is the
	ArchLinux System disk space not the efi(/dev/nvme0n1p1) disk space.
	If you want to auto mount, Do not forget to update /etc/fstab.
## Conclusion
### Maybe you do not need to adjust efi partition size
	Only adjust the efi mount point on Archlinux system on section 'Optimization'.
   	A H.
   	Maybe this is the better solution.
   	So,you shuld spent some time to find out the Root Cause, compare different solutions, 
   	Then you'll get the better.
# REFERENCES
1) [Archlinux+win10双系统扩容Boot/ESP分区](https://www.shuzhiduo.com/A/pRdBN2n6dn/)
2) [GRUB/Restore the GRUB Bootloader](https://wiki.manjaro.org/index.php/GRUB/Restore_the_GRUB_Bootloader/en)
3) [Windows 10 缺少 efi 分区无法启动的修复](https://blog.csdn.net/mostone/article/details/119984602)
4) [Windows 更换硬盘后通过 BCDBoot 命令修复 UEFI 启动引导](https://weiku.co/article/309/)
5) [Windows 7/8/8.1/10/11 误删EFI启动项，无法开机解决方案（U盘+原版镜像）](https://www.csdn.net/tags/MtTaMg1sMTU3MzI3LWJsb2cO0O0O.html)