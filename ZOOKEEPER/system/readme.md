# [使用systemd ( systemctl ) 控制和托管zookeeper](https://www.jianshu.com/p/4c594b949b91)

file abc.service 
```shell
[Unit]
Description:描述，
After：在network.target,auditd.service启动后才启动
ConditionPathExists: 执行条件

[Service]
EnvironmentFile=变量所在文件
ExecStart=执行启动脚本
ExecReload=执行重启命令
ExecStop=执行停止命令
Environment=变量
User=服务运行的用户,
Group=服务运行的用户组
PIDFile=存放PID的文件路径
Restart=fail时重启
PrivateTmp=True表示给服务分配独立的临时空间

[Install]
Alias:服务别名
WangtedBy: 多用户模式下需要的
```


https://www.cnblogs.com/quchunhui/p/10019202.html
