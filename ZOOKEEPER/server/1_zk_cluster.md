# 参考文档 [zookeeper 集群搭建 ](https://www.cnblogs.com/ysocean/p/9860529.html)

zoo.cfg配置文件改动的参数说明:
　　1)tickTime：基本事件单元，这个时间是作为Zookeeper服务器之间或客户端与服务器之间维持心跳的时间间隔，每隔tickTime时间就会发送一个心跳；最小 的session过期时间为2倍tickTime

　　2)dataDir：存储内存中数据库快照的位置，除非另有说明，否则指向数据库更新的事务日志。注意：应该谨慎的选择日志存放的位置，使用专用的日志存储设备能够大大提高系统的性能，如果将日志存储在比较繁忙的存储设备上，那么将会很大程度上影像系统性能。

　　3)client：监听客户端连接的端口。

　　4) initLimit：允许follower连接并同步到Leader的初始化连接时间，以tickTime为单位。当初始化连接时间超过该值，则表示连接失败。

　　5) syncLimit：表示Leader与Follower之间发送消息时，请求和应答时间长度。如果follower在设置时间内不能与leader通信，那么此follower将会被丢弃。

　　6) server.A=B:C:D

　　　　A：其中 A 是一个数字，表示这个是服务器的编号；

　　　　B：是这个服务器的 ip 地址；

　　　　C：Zookeeper服务器之间的通信端口；

　　　　D：Leader选举的端口。

　　我们需要修改的第一个是 dataDir ,在指定的位置处创建好目录。

　　第二个需要新增的是 server.A=B:C:D 配置，其中 A 对应下面我们即将介绍的myid 文件。B是集群的各个IP地址，C:D 是端口配置。

　　参考官方文档：https://zookeeper.apache.org/doc/r3.5.8/zookeeperStarted.html

在 上一步 dataDir 指定的目录下，创建 myid 文件。

然后在该文件添加上一步 server 配置的对应 A 数字。

　　比如我们上面的配置：

　　dataDir=/usr/local/software/zookeeper-3.3.6/data

　　然后下面配置是：

server.0=192.168.146.200:2888:3888
server.1=192.168.146.201:2888:3888
server.2=192.168.146.202:2888:3888
那么就必须在 192.168.146.200 机器的的 /usr/local/software/zookeeper-3.3.6/data 目录下创建 myid 文件，然后在该文件中写上 0 即可。
后面的机器依次在相应目录创建myid文件，写上相应配置数字即可。


启动zookeeper服务
　启动命令：

zkServer.sh start
　　停止命令：

zkServer.sh stop
　　重启命令：

zkServer.sh restart
　　查看集群节点状态：

zkServer.sh status

