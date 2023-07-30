# [Arch Linux 完全安装教程 2023.6](https://www.bilibili.com/read/cv20753052)
# 1 connect network
## 1-1 through iwctl
```shell
iwctl
help
station wlan0 connect your_wifi_ssid
# wait for password prompt 
# input password
station wlan0 show
quit
ping 8.8.8.8
```
# 2 set timezone
```shell
timedatectl set-timezone Asia/Shanghai
```

# 3 disk partition
## pay attention


# 4 choose China mirror for pacman
# 5 install keyring
```shell
pacman -S archlinux-keyring 
```
echo "#base 和 base-devel 包含一套基本的系统软件，必须安装，linux 是内核，linux-firmware 是一些驱动，linux-headers 是内核头文件。 "

```shell
# linux system
pacstrap /mnt base base-devel linux-lts linux-firmware linux-lts-headers 
# must install
pacstrap /mnt networkmanager dhcpcd openssh grub os-prober efibootmgr amd-ucode 
# usefully tools
pacstrap noto-fonts-emoji noto-fonts-cjk man-db man-pages ntfs-3g cups vim git net-tools iwd 
```
# 6 mount if exists efi partition 
```shell
# mkdir /mnt/boot/efi
# mount <EFI 分区编号> /mnt/boot/efi
```
# 7 create fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 8 'chroot' enter new system disk
```shell
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
hwclock --systohc 
```
# 9 locale, edit file /etc/locale-gen , /etc/locale.conf
zh_CN.UTF-8
en_US.UTF-8

# 10 execute 'locale-gen'
```shell
locale-gen
```

# 11 config hostname, edit /etc/hostname
# 12 config root password
```shell
passwd root
```
# 13 dual system config,edit /etc/default/grub
GRUB_DISABLE_OS_PROBER=false

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg

