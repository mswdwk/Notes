_fifofile="$$.fifo"
mkfifo $_fifofile     # 创建一个FIFO类型的文件
exec 6<>$_fifofile    # 将文件描述符6写入 FIFO 管道， 这里6也可以是其它数字
rm $_fifofile         # 删也可以，
 
degree=10  # 定义并行度
 
#根据并行度设置信号个数
#事实上是在fd6中放置了$degree个回车符
for ((i=0;i<${degree};i++));do
    echo
done >&6
 
for i in `seq 1 20` # 循环20次
do
    # 从管道中读取(消费掉)一个字符信号
    # 当FD6中没有回车符时，停止，实现并行度控制
    read -u6
    {
        sleep 1  # 实际任务的命令
        echo "degree=$degree executing $i"
        echo >&6 # 当进程结束以后，再向管道追加一个信号，保持管道中的信号总数量
    } &
done
 
wait # 等待所有任务结束
 
exec 6>&- # 关闭管道
