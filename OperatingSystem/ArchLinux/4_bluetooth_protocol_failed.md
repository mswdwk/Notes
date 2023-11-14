# Problem 1

pacman -S pulseaudio-bluetooth


最近在尝试使用这台装了 Arch Linux 的笔记本连接蓝牙耳机的时候，发现总是无法成功配对

因为蓝牙键盘是可以正常连接的，判断蓝牙驱动应该是正常的，所以大概率是缺少某些蓝牙音频驱动。然后查看蓝牙的日志发现如下报错：

$ systemctl status bluetooth
...src/service.c:btd_service_connect() a2dp-sink profile connect failed for B8:D5:0B:D0:06:B0: Protocol not available

虽然在 Arch Linux Wiki 的 Bluetooth_headset 章节提示说已经默认支持 A2DP profile，但是看上面的日志应该是没有安装成功。

安装 pulseaudio-bluetooth 之后再尝试配对蓝牙耳机，发现可以正常连接并且正常当作电脑扬声器了。


# Problem 2 : Specific Bluetooth device no longer connects 
```
Oct 03 11:06:57 arch-laptop bluetoothd[471]: src/profile.c:ext_connect() Headset Voice gateway failed connect to EB:06:EF:4A:66:81: Permission denied (13)
Oct 03 11:06:58 arch-laptop bluetoothd[471]: profiles/audio/avdtp.c:avdtp_connect_cb() connect to EB:06:EF:4A:66:81: Too many levels of symbolic links (40)
```
## solution:
	Delete the already bluetooth equipment name.
# reference

[Archlinux 突然启动不了蓝牙 ](https://jone.plus/2022/10/15/problem/linux/Arch%20%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8%E8%93%9D%E7%89%99/)
[Specific Bluetooth device no longer connects](https://bbs.archlinux.org/viewtopic.php?id=259538)
[Bluetooth headset](https://wiki.archlinux.org/title/Bluetooth_headset#Pairing_works,_but_connecting_does_not)
