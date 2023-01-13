# https://www.runoob.com/w3cnote/bash-shortcut.html
1) bind keys in sessions
bind "\C-a": beginning-of-line
bind "\C-b": backward-char
bind "\C-e": end-of-line
bind "\C-k": kill-line

2) Permanent bind keys,add fellowing contents in file /etc/inputrc
"\C-a": beginning-of-line
"\C-b": backward-char
"\C-e": end-of-line
"\C-k": kill-line


3) note 1
/C-    control prefix
/M-    meta prefix
/e     an escape character
//     backslash
/"     literal ", a double quote
/’     literal ’, a single quote

4) note 2
##查看Readline中可以使用的函数名称
bind -l
##查看当前绑定的案件配置与其对应的功能
bind -v
##已经绑定的快捷键
bind -p

##绑定自定义执行命令shell命令的快捷键
bind -x '"/C-x/C-l":ls -al'
## 绑定后，按[C-x,C-L]就能执行ls -al

## 绑定内置函数功能
bind "/C-x":backword-delte-char
##这个是这行Readline库中的函数backword-delte-char

