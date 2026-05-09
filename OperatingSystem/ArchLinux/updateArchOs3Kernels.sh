#!/bin/bash
# 1. 查看正在使用的内核
uname -r
# 2. 查看系统全部已安装内核
pacman -Qs '^linux' | grep -E 'linux|zen|lts'

# vmlinuz-linux（默认主线内核）, 紧跟 Linux 主线（mainline）最新稳定版，约每 2–3 个月升级一次主版本
# vmlinuz-linux-lts 长期支持内核, 长期（约 5 年）仅推送安全与关键 bug 修复，不主动升级主版本
# vmlinuz-linux-zen（性能调优内核) : 基于最新主线内核，叠加 Zen 专属补丁集

# 安装三个完整内核（含驱动编译用 headers）
sudo pacman -S linux linux-headers \
linux-zen linux-zen-headers \
linux-lts linux-lts-headers

# 编辑文件 /etc/default/grub  , 设置默认的启动项(内核版本 或 windows 系统)
# 更新 GRUB 引导（关键）

sudo grub-mkconfig -o /boot/grub/grub.cfg 
#正在生成 grub 配置文件 ...
#找到 Linux 镜像：/boot/vmlinuz-linux-zen
#找到 initrd 镜像：/boot/amd-ucode.img /boot/initramfs-linux-zen.img
#找到 Linux 镜像：/boot/vmlinuz-linux-lts
#找到 initrd 镜像：/boot/amd-ucode.img /boot/initramfs-linux-lts.img
#找到 Linux 镜像：/boot/vmlinuz-linux
#找到 initrd 镜像：/boot/amd-ucode.img /boot/initramfs-linux.img
#警告： os-prober 将运行以检测其它可引导分区。
#将使用 os-prober 的输出，以检测分区中可引导的二进制文件，并为其创建新的启动项。
#发现了 Windows Boot Manager，位于 /dev/nvme1n1p1@/EFI/Microsoft/Boot/bootmgfw.efi
#正在添加 UEFI 固件设置的引导菜单项……
#完成

# 设置默认开机内核 
##  先列出所有 GRUB 内核菜单条目
sudo grep menuentry /boot/grub/grub.cfg | grep -E 'linux|zen|lts'
