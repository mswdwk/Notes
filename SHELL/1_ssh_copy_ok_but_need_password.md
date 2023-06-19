问题现象：

执行ssh-copy-id -i .ssh/id_rsa.pub 192.168.200.100

执行 ssh 192.168.200.100

仍提示输入密码

对本机及对方的机器 排查：

1、检查 ~/.ssh   是否是 700

2、检查 /home/user 是否是 700

3、检查 ~/.ssh/authorized_keys 是否是 600
