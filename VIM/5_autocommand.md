[VIM学习笔记 自动命令(autocmd)](https://zhuanlan.zhihu.com/p/98360630)



自动命令，是在指定事件发生时自动执行的命令。利用自动命令可以将重复的手工操作自动化，以提高编辑效率并减少人为操作的差错。
# 定义自动命令
可以使用以下格式的autocmd命令，来定义自动命令：

:autocmd [group] events pattern [nested] command
group，组名是可选项，用于分组管理多条自动命令；
events，事件参数，用于指明触发命令的一个或多个事件；
pattern，限定针对符合匹配模式的文件执行命令；
nested，嵌套标记是可选项，用于允许嵌套自动命令；
command，指明需要执行的命令、函数或脚本。
