# reference : https://wiki.archlinux.org/title/PC_speaker

# close bell when logout by desktop gui
on shell termianl, execute below command.
```shell
xset -b 
```
or 
append `xset -b ` in file /etc/xprofile

# Close bell in terminal
in file /etc/inputrc 
```shell
set bell-style none
```
