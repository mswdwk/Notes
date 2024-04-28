
# 前缀键默认为“\”。使用以下命令，可以将前缀键定义为逗号：

let mapleader=","
使用以下命令，利用转义符“\”将前缀键设置为空格键也是不错的主意：

let mapleader = "\<space>"

链接：https://www.zhihu.com/question/20741941/answer/16080645
# map 映射

在vim配置文件中经常会看到map、nmap、imap、vmap、vnoremap、nunmap、nmapclear等，都是什么意思呢？

map前的n、v、nore、un等表示下列含义：

nore	非递归
n	普通模式生效
v	可视模式生效
i	插入模式生效
c	命令行模式生效
un	后面跟组合键, 表示删除这个映射
clear	清楚相关模式下所有映射

## noremap是不会递归的映射 (大概是no recursion)
 例如
noremap Y y
noremap y Y
不会出现问题 
## 前缀代表生效范围
inoremap就只在插入(insert)模式下生效
vnoremap只在visual模式下生效
nnoremap就在normal模式下(狂按esc后的模式)生效
这样可以减少快捷键所用到的键位组合的个数

https://www.cnblogs.com/firestar277/p/14665816.html
https://blog.haoxiang.org/2013/11/vim-replace-by-line-number/
