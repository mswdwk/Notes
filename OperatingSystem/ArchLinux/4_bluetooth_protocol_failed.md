pacman -S pulseaudio-bluetooth


最近在尝试使用这台装了 Arch Linux 的笔记本连接蓝牙耳机的时候，发现总是无法成功配对

因为蓝牙键盘是可以正常连接的，判断蓝牙驱动应该是正常的，所以大概率是缺少某些蓝牙音频驱动。然后查看蓝牙的日志发现如下报错：

$ systemctl status bluetooth
...src/service.c:btd_service_connect() a2dp-sink profile connect failed for B8:D5:0B:D0:06:B0: Protocol not available

虽然在 Arch Linux Wiki 的 Bluetooth_headset 章节提示说已经默认支持 A2DP profile，但是看上面的日志应该是没有安装成功。

安装 pulseaudio-bluetooth 之后再尝试配对蓝牙耳机，发现可以正常连接并且正常当作电脑扬声器了。


# reference

[Archlinux 突然启动不了蓝牙 ](https://jone.plus/2022/10/15/problem/linux/Arch%20%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8%E8%93%9D%E7%89%99/)
