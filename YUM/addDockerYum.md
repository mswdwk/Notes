linux docker升级,CentOS7 下 Docker 升级到最新版本
1、查看系统要求

Docker 要求 CentOS 系统的内核版本高于 3.10 ,查看CentOS的内核版本。

uname -a

2、删除旧版本

yum remove docker docker-common docker-selinux docker-engine

3、安装需要的软件包

yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

4、设置Docker yum源

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

官方源有可能会很慢，不愿意等的把软件仓库地址替换腾讯云的镜像为:

sudo sed -i 's+download.docker.com+mirrors.cloud.tencent.com/docker-ce+' /etc/yum.repos.d/docker-ce.repo

别忘了，刷新yum缓存

sudo yum makecache fast

5、查看所有仓库中所有docker版本

可以查看所有仓库中所有docker版本,并选择特定的版本安装。

yum list docker-ce --showduplicates | sort -r

6、安装docker

sudo yum install docker-ce

由于repo中默认只开启stable仓库，故这里安装的是最新稳docker-ce-cli-19.03.1-3.el7.x86_64。

如果要安装特定版本：

sudo yum install docker-ce-18.06.1.ce

7、启动

设置为开机启动

systemctl enable docker

启动

systemctl start docker

查看启动状态

systemctl status docker

查看版本

docker version
