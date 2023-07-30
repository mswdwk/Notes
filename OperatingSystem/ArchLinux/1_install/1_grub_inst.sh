#!/bin/bash

# after 'arch-chroot'

current_hardware_arch=`uname -m`
echo "current_hardware_arch=$current_hardware_arch"

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
