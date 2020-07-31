CodeViz —— 一款分析 C/C++源代码中函数调用关系的调用图生成工具
 程序开发中，有时候需要阅读别人的代码，这时理解代码的组织结构就显得非常重要。
CodeViz 是一款分析 C／C＋＋函数调用关系的调用图生成工具，非常有助于代码的阅读和
理解，该项目网址为 http://www.csn.ul.ie/~mel/projects/codeviz。
 下图是项目网站上给出的一个 kernel-2.6.12 中 alloc_pages 函数调用图例，从中可以
清晰的把握函数调用关系：
该调用图的生成命令为：
 gengraph -f alloc_pages -d 5 
 -t -s "buffered_rmqueue out_of_memory try_to_free_pages numa_node_id" 
 -i "cpuset_zone_allowed" --output-font=Arial –output-type=png
是不是感觉命令非常复杂。没关系，下面讲解了 CodeViz 的安装和使用后，再回来看这个
命令你会发现它使用起来非常方便。
安装
 1. 安装 GraphViz
 
 调用图的生成依赖于 GraphViz，所以首先要安装 GraphViz。若是安装盘上没有，
可以从 http://www.graphviz.org 下载。可以下载源码包，也可以下载对应发行版的 rpm 包
或者 deb 包，这里直接下载源码包：
 http://www.graphviz.org/pub/graphviz/stable/SOURCES/graphviz-2.20.2.tar.gz
 安装：
 tar graphviz-2.20.2.tar.gz
 cd graphviz-2.20.2 ./configure (该步可以看出 graphviz 支持多种语言，但需要相应的插件支持)
 make
 su (安装 graphviz 需要在/usr/local 下创建目录和文件)
 make install
 安装完毕，检测一下 whereis graphviz，你将看到：
 graphviz: /usr/local/lib/graphviz
 2. 简单安装 CodeViz
 这可不是简化安装，该做的都做了，只是让脚本自动完成而已：
 wget http://www.csn.ul.ie/~mel/projects/codeviz/codeviz-1.0.11.tar.gz 
 tar zxvf codeviz-1.0.11.tar.gz
 cd codeviz-1.0.11
 ./configure (缺省将 codeviz 安装到/usr/local 目录下，而需要的 gcc 编译器
安装到$HOME/gccgraph 目录下。可以通过./configure --help 查看缺省配置。)
 make 
 su (缺省安装到/usr/local 目录下，需要 root 权限)
 make install
 实际上这里会自动下载 gcc 源码包并安装，所以只要安装了 graphviz，按照这些
步骤整个安装过程就算结束了，可以使用了，非常简洁。下面为了清楚一下整个过程做一
下分步安装。
 3. 下载 GCC 编译器
 CodeViz 使用了一个 patch 版本的 GCC 编译器，而且不同的 CodeViz 版本使用的
GCC 版本也不同，可以下载 CodeViz 的源码包后查看 Makefile 文件来确定要使用的 GCC 版
本，codeviz-1.0.11 使用 GCC-3.4.6。实际上安装 CodeViz 时安装脚本会自动下载对应的 GCC
并打 patch，但是这里我们是分步安装，还是清楚一点好。 此外要注意安装脚本使用的是.
tar.gz 文件。
 ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-3.4
.6/gcc-3.4.6.tar.gz 
 4. 安装 CodeViz
 安装 GCC
 CodeViz 的安装脚本 compilers/install_gcc-3.4.6.sh 会自动检测 compilers 目录下
是否有 gcc 的源码包，若是没有则自动下载并打 patch，这里前面已经下载，直接移到该
目录即可，则剩下的就是解压安装了。install_gcc-3.4.6.sh 会解压缩 gcc，打 patch，并将
其安装到指定目录，若是没有指定目录，则缺省使用$HOME/gcc-graph，通常指定/usr/ local/gcc-graph（这时需要 root 权限）。
 tar zxvf codeviz-1.0.11.tar.gz
 mv /[path]/gcc-3.4.6.tar.gz codeviz-1.0.11/compilers
 cd codeviz-1.0.11/compilers
 ./install_gcc-3.4.6.sh /usr/local/gcc-graph
 安装 CodeViz
 cd codeviz-1.0.11
 ./configure –gccgraph=/usr/local/gcc-graph 
 (前面已经安装了 gcc，指定其目录)
 # --prefix=$HOME/codeviz (指定安装目录，缺省/usr/local 目录下)
 # --help 查看配置选项
 # make (这里不需要是因为在脚本中不会检测是否已经 make 了 gcc-3.4.6，前
面已经作过了，所以只要安装 codeviz 即可。编译的目标只是 gcc-3.4.6，codeviz 不需要编
译。具体查看 Makefile 文件)
 make install-codeviz (前面已经安装了 gcc，所谓的安装 codeviz 只是将
脚本 genfull 和 gengraph 复制到/usr/local/bin 目录下。codeviz 需要 perl 库的支持，我
的系统上缺省安装了 perl，所以没有出现什么问题。若是安装出现问题，则查看
configure 和 Makefile 确定需要安装哪些库即可)
 
 注：实际上通过使用脚本，整个安装过程十分简单，这里只是简单的分析了一下
整个安装过程。要进行实际的定制安装建议阅读 codeviz 中的安装脚本和配置文件，例如
configure 脚本、 Makefile 文件和 compilers 目录下的 install_gcc-3.4.6.sh 脚本。具体分
析这里不再详述。
 好了，CodeViz 安装完成了，下面看一下它的使用吧。
使用
 GraphViz 支持生成不同风格的调用图，但是一些需要安装额外的支持工具或者库程序，
有兴趣的读者可以到 http://www.graphviz.org 上查找相关资料。这里重点讲述 CodeViz 的
使用方法，具体的图像风格控制不再详述。
 CodeViz 使用两个脚本来生成调用图，一个是 genfull，该脚本可以生成项目的完整调
用图，因此调用图可能很大很复杂，缺省使用 cdepn 文件来创建调用图；另一个是
gengraph，该脚本可以对给定一组函数生成一个小的调用图，还可以生成对应的
postscript 文件。安装时这两个脚本被复制到/usr/local/bin 目录下，所以可以直接使用
而不需要指定路径。 编译
 打了 patch 的 gcc/g++为编译的每个 C/C++文件生成.cdepn 文件，该文件包含函数调
用信息、声明信息等等。注意到 patch 的 gcc 安装到了/usr/local/gcc-graph 目录下。多
数项目使用变量 CC 表示要使用的 gcc，所以使用 patch 的 gcc 的最方便的方法是
 make CC=$HOME/gcc-graph/bin/gcc CXX=$HOME/gcc-graph/bin/g++
或者调整路径变量让你安装的 gcc 目录出现到系统缺省的 gcc 目录之前
 PATH=/usr/local/gcc-graph/bin:$PATH
若是项目没有使用 CC 或者 CXX 宏，则需要你来编辑 Makefile 文件或者设置路径变量。
文件编译时生成对应的 cdepn 文件。
 下面写一个简单的程序来实验一下：
 #include <stdio.h>
 void test(void);
 int
 main(void)
 {
 test();
 return 0;
 } 
 void test()
 {
 return;
 }
编译$/usr/local/gcc-graph/bin/gcc test.c，这时可以看到 test.c 文件所在目录生成文
件 test.c.cdepn。编译成功！
 生成调用图
 前面已经有了 test.c.cdepn 文件，下面生成函数调用图。
 首先使用 genfull 创建 full.graph 文件，可以使用 genfull --help 或者 genfull --
man 来查看如何使用。最简单的方式是在项目的顶级目录以无参数方式运行。由于项目的
完全调用信息非常庞大，所以通常只是简单的生成项目的 full.graph，然后在后面使用
gengraph 获取需要的调用信息。若是需要完整信息则将 full.graph 由 dot 处理然后查看
生成的 postscript 文件。(dot 是 GraphViz 中的一个工具，具体使用没有深究过，感兴趣
的读者可以自行查阅^^)。到 test.c 文件所在目录运行 genfull，可以看到生成了full.graph 文件。
 查看 full.graph 文件 cat full.graph 可以得到：
 digraph fullgraph {
 node [ fontname=Helvetica, fontsize=12 ];
 "test" [label="test\ntest.c:13:"];
 "main" [label="main\ntest.c:6:"];
 "main" -> "test" [label="test.c:8"];
 }
 
 接下来使用 gengraph 生成函数调用图，可以使用 gengraph –help 或者 gengraph –
man 来查看如何使用。这里关注 3 个选项：-f，指定顶级函数；-o，指定输出的 postfile
文件名；--output-type，指定输出类型，例如 png、gif、html 和 ps，缺省为 ps。
 执行 gengraph -f main，可以看到 test.c 所在目录下生成了 main.ps 文件，清楚的描
述了函数调用关系。
使用进阶 
 选项参数
 使用 gengraph 时的选项使用的参数值要使用“”括起来，例如
 gengraph –output-type “png” -f main 
 命名冲突
 在一个复杂的项目中，full.graph 并不十分完美。例如，kernel 中的模块有许多同名
函数，这时 genfull 不能区分它们。有两种方法可以解决这个问题。
 第一种方法，将由 cdepn 生成的图与 cobjdump 生成的图作比较。因为 cobjdump 是分
析二进制映像得到的信息，所以出错的可能性比较小，只是没有 inline 函数和宏的信息。
例如，在内核中可以这样：
 genfull -g cobjdump -o full.graph-objdump
 genfull -g cdepn -o full.graph-cdepn
 gengraph -t -d 5 -g full.graph-objdump -f kswapd -o kswapd-objdump.ps
 gengraph -t -d 5 -g full.graph-cdepn -f kswapd -o kswapd-cdepn.ps
这里生成了两个调用图，可以通过比较来确保准确性。 另一种方法是使用 genfull 的-s 选项，-s 指定了检测哪些子目录。例如 kernel 中在
mm 目录和 drivers/char/drm 目录下都定义了 alloc_pages 函数，那么可以以下列方式调用
genfull：
 genfull -s "mm include/linux drivers/block arch/i386"
实际的使用中，-s 非常方便，建议使用该方式。
 使用 Daemon/Client 模式
 当 full.graph 很大时，大量的时间花费到读取输入文件上了，例如 kernel 的
full.graph 是很大的，前面生成的大约有 15M，这还不是全部内核的函数调用分析信息。
为了节省时间，可以将 gengraph 以 daemon 方式运行，这要使用-p 选项：
 gengraph -p -g linux-2.6.25/full.graph
该命令返回时 gengraph 以 daemon 方式运行，同时在/tmp 目录下生成了 codeviz.pipe 文件。
要生成函数调用图，可以使用-q 选项：
 gengraph -q -t -d 2 -f alloc_pages
要终止 gengraph 的运行，使用如下命令：
 echo QUIT > /tmp/codeviz.pipe
 
一个例子
 现在我们来看如何生成内核的函数调用图，以 2.6.25 中 alloc_pages 函数为例。
 首先是编译内核，这里我们的目的是查看函数调用关系，并非安装新内核，所以直接
进行配置编译：
 make menuconfig 
 make CC=/usr/local/gcc-graph/bin/gcc bzImage
 make CC=/usr/local/gcc-graph/bin/gcc modules
 生成调用图：
 genfull -s 
 "mm include/linux drivers/block arch/i386 fs init lib kernel net ipc"
这里使用了-s 选项，虽然仍然会产生冲突，但是对于 kernel 的基本部分来说多数还是没
有冲突的。这里的选择也是为了自己将来分析 kernel 用，你可以根据自己的需要来生成
full.graph。
 生成了 full.graph 后调用 gengraph 生成 alloc_pages 的函数调用图，这里我们先直
接使用项目网站上使用的命令，然后再进行解释：
 gengraph -f alloc_pages -d 5 
 -t -s "buffered_rmqueue out_of_memory try_to_free_pages numa_node_id" 
 -i "cpuset_zone_allowed" 
 --output-font "Arial" –output-type "png"这时生成了 alloc_pages.png 文件，用图像查看器查看，你会发现图非常复杂，而且不好
显示。这是因为与 kernel-2.6.12 相比，kerne-2.6.25 已经变化了很多，前面指定的一些函
数可能已经不存在或者变换了调用关系。不要紧，我们先讲解该命令是如何定制的，然后
再调整命令来生成适合 2.6.25 内核版本的 alloc_pages 函数调用图。
 Step 1: gengraph -f alloc_pages
 不 足：花费时间太长，而且可能有很深的调用层次，导致调用图十分复杂。
 Step 2: gengraph -d 5 -f alloc_pages
 不足：调用图非常复杂，主要是有很多无意义的工具函数。
 Step 3: gengraph -d 5 -t -f alloc_pages
 不足：调用图还是很复杂，因为有些函数展开后很复杂，可以只是显示它的
 存在，而不展开调用图
 Step 4: gengraph -d 5 -t 
 -s "buffered_rmqueue out_of_memory try_to_free_pages numa_node_id" 
 -f alloc_pages
 不足：函数调用的底层有些函数重复，只是不同的调用方式，比较混乱，可
 以 忽略这些函数
 Step 5: gengraph -d 10 -t 
 -s "buffered_rmqueue out_of_memory try_to_free_pages numa_node_id" 
 -i "cpuset_zone_allowed" 
 -f alloc_pages -
 -d 指定 最大调用层数
 -s 仅仅 显示指定函数，而不对其调用进行展开
 -i 忽略 指定函数
 注：定制命令的标准是函数调用图简单明了，易于把握，否则就没有意义了
 现在知道如何定制命令了，那来生成 kernel-2.6.25 中 alloc_pages 函数的调用图吧，
具体的分析过程不描述了，这里直接给出一个简单的定制命令：
 gengraph -f alloc_pages -d 3 -t --output-font="Arial" --output-type="png"
对应的函数调用图如下：是不是太简单了，呵呵，偷一下懒吧，该函数太复杂了，读者可以自行把握，根据自己的
需要设置参数。 
小结
 本文简单讲解了 CodeViz 的安装和使用。CodeViz 依赖于 GraphViz，因而可以生成十
分丰富的函数调用图。具体选项的使用以及图像格式的选择可由读者根据个人需要和喜好
自己揣摩使用。
参考
 
 1. Understanding the Linux Virtual Memory Manager, Mel Gorman
 2. http://www.csn.ul.ie/~mel/projects/codeviz

https://blog.csdn.net/linux_kax1_tcds_6a/article/details/19711085?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.edu_weight&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.edu_weight
