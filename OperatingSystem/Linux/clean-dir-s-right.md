 我有一个目录,显示权限掩码drwsrwsr-x.当我尝试将权限重置为755时,S仍然存在.

什么是“s”,为什么我不能将权限更改回775(drwxrwxr-x)？
您在用户和组列中的“执行”位置看到的是SetUID(执行时设置用户ID)和SetGID(执行时设置组ID)位.

Unix文件权限实际上是一个4位八进制数字SUGO

> S控制SetUID(4),SetGID(2)和“Sticky”(1)位
> U控制文件所有者的Read(4)/ Write(2)/ Execute(1)位
> G控制文件组的读/写/执行位
> O控制其他人的读/写/执行位.

您可以使用chmod ug-s目录或chmod 0755目录从目录中删除setuid位
