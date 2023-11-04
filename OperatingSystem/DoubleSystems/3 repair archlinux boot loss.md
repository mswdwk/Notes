# 1. Problem
When launch your computer , enter Windows System directly, Linux System Entry lost.
windows system version is 11.

# 2. Analyze
## 2.1 Mount EFI Partition
On Windows System, mount EFI partition On 'Z:' by open cmd.
```shell
# mount 
mountvol Z: /S
cd Z:
Z:
dir 
```
## 2.2 Observe Default / Archlinux / Microsoft boot file
```shell
$ ls -l EFI/Microsoft/Boot/*.efi
-rwxr-xr-x 1 lenovo 197121 1688024 Nov  4 07:21 EFI/Microsoft/Boot/bootmgfw.efi*
-rwxr-xr-x 1 lenovo 197121 1671144 Nov  4 07:21 EFI/Microsoft/Boot/bootmgr.efi*
-rwxr-xr-x 1 lenovo 197121  131928 Jan 15  2023 EFI/Microsoft/Boot/cbmr_driver.efi*
-rwxr-xr-x 1 lenovo 197121 1450880 Nov  4 07:21 EFI/Microsoft/Boot/memtest.efi*

$ ls -l EFI/Boot/bootx64.efi
-rwxr-xr-x 1 lenovo 197121 1688024 Nov  4 07:21 EFI/Boot/bootx64.efi*

$ ls -l EFI/ArchLinux/grubx64.efi
-rwxr-xr-x 1 lenovo 197121 151552 Jan 14  2023 EFI/ArchLinux/grubx64.efi*
$ md5sum EFI/Boot/bootx64.efi
433224d074127c34064dfa0d732a9977 *EFI/Boot/bootx64.efi

$ md5sum EFI/Microsoft/Boot/bootmgfw.efi
433224d074127c34064dfa0d732a9977 *EFI/Microsoft/Boot/bootmgfw.efi
```
## 2.3 Doubtful Point
Both size, datetime and md5 value are the same between file 'EFI/Boot/bootx64.efi' and 'EFI/Microsoft/Boot/bootmgfw.efi'.

## 2.4 Conclusion
Windows 11 System use 'Microsoft/Boot/bootmgfw.efi' override file 'Boot/bootx64.efi' when update.

# 3 Solution
You can change to archlinux boot through copy 'ArchLinux/grubx64.efi' to 'Boot/bootx64.efi' as default efi bios boot file.
## 3.1 Change Default Boot File to ArchLinux
You'd better backup file Boot/bootx64.efi before override it.
```shell
cd Z:/EFI
cp  ArchLinux/grubx64.efi Boot/bootx64.efi
```

# 4. Last
On Windows System, unmount EFI partition
```cmd
mountvol Z: /D
```

# 5. Reference
[如何在Windows下管理UEFI启动项](https://zhuanlan.zhihu.com/p/162931312)