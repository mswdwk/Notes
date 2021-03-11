 [Linux系统调用--getrusage函数详解](https://www.cnblogs.com/iihcy/p/5105839.html)

Linux系统调用--getrusage函数详解
功能描述：
    获得进程的相关资源信息。如：用户开销时间，系统开销时间，接收的信号量等等;
 
用法：
   #include <sys/types.h>
   #include <sys/time.h>
   #include <sys/resource.h>
 
   #define   RUSAGE_SELF     0
   #define   RUSAGE_CHILDREN     -1
   
   int getrusage(int who, struct rusage *usage); 
    当调用成功后，返回0，否则-1；  
 
参数：
    who：可能选择有
    RUSAGE_SELF：获取当前进程的资源使用信息。以当前进程的相关信息来填充rusage(数据)结构
    RUSAGE_CHILDREN：获取子进程的资源使用信息。rusage结构中的数据都将是当前进程的子进程的信息
    usage：指向存放资源使用信息的结构指针。
 
rusage(数据)结构定义在/usr/include/sys/resource.h中，下面是rusage的结构：
struct rusage {
        struct timeval ru_utime; // user time used 
        struct timeval ru_stime; // system time used 
        long ru_maxrss; // maximum resident set size 
        long ru_ixrss; // integral shared memory size
        long ru_idrss; // integral unshared data size 
        long ru_isrss; // integral unshared stack size 
        long ru_minflt; // page reclaims 
        long ru_majflt; // page faults 
        long ru_nswap;// swaps
        long ru_inblock; // block input operations 
        long ru_oublock; // block output operations 
        long ru_msgsnd; // messages sent 
        long ru_msgrcv; //messages received 
        long ru_nsignals; // signals received 
        long ru_nvcsw; // voluntary context switches 
        long ru_nivcsw; // involuntary context switches 
};
 
 
举个例子：
int who = RUSAGE_SELF;
struct rusage usage;
int ret;
ret = getrusage(who, &usage);
这样你就可以用usage获取你想要的东西了；
同样wait3()和wait4()两个函数也可以得到进程资源信息.
 
得到CPU使用时间的用法：
struct rusage rup;
getrusage(RUSAGE_SELF, &rup);
long sec = rup.ru_utime.tv_sec + rup.ru_stime.tv_sec;
long usec = rup.ru_utime.tv_usec + rup.ru_stime.tv_usec;
sec += usec/1000000;
usec %= 1000000;
