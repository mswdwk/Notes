# 1. badblock
```shell
badblock -o bad.log -v /dev/sda1
```
# 2. smartctl
## 2.1 install smartmontools by `sudo yum install smartmontools`
## 2.2 check 磁盘的 Smart 功能是否支持，我们采用命令`smartctl -i /dev/sda`,For SATA drives use `smartctl -i -d ata /dev/xxx`
## 2.3 Enable S.M.A.R.T. support with:
`smartctl -s on /dev/xxx            ### For SCSI Disks`
`smartctl -s on -d ata /dev/xxx     ### for SATA Disks`
## 2.4 through command `sudo smartctl -H /dev/sda1` to get a quick PASS/FAIL test of disk health

# 3.reference 
1)https://www.thegeekdiary.com/how-to-check-a-disk-for-bad-blocks-or-disk-errors-on-centos-rhel/
2)[Linux硬盘的检测--smartctl详细介绍](https://www.cnblogs.com/fiberhome/p/8275961.html)