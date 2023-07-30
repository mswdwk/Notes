#!/bin/bash

systemctl enable NetworkManager dhcpcd


echo "
networkmanager - 连接互联网（不用 netctl）

dhcpcd - 分配 ip 地址

openssh - ssh服务

cups - 打印机

nano 或 micro - 都是好用的命令行文本编辑器，micro 的快捷键更接近 Windows 自带的记事本。

git - 100%会用到的，现在不装以后也会被当作依赖安装

grub - 必须安装，引导系统用

os-prober - 双系统必须安装

 efibootmgr - UEFI 必须安装

intel-ucode 或 amd-ucode - CPU 微码必须安装

man-db 和 man-pages - 查看软件包的文档

ntfs-3g - 只读挂载 ntfs 分区（访问 Windows 文件）双系统必须安装

firefox  - 浏览器

noto-fonts-cjk 和 noto-fonts-emoji - 谷歌设计的字体（包含中文和 emoji）

 作者：kc0ver https://www.bilibili.com/read/cv20753052 出处：bilibili
"
