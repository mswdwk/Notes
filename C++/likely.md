作用
likely unlikely是为编译器提供对分支优化的提示，基本用于if-else的分支优化场景。if-else在汇编时会将else分支的命令生成跳转语句（jmp），而跳转会影响程序性能，所以如果大部分情况下都是else分支成立的话，程序每次都会执行跳转，从而影响效率，使用likely和unlikely即可以告诉编译器大部分情况下哪个分支更有可能成立，从而将该分支的语句编译到前面，提高运行效率。

注意，编译时需要加 -O2选项
可以用objdump -S XXX 来查看汇编指令
使用unlikely()时，汇编指令为je（相等则跳转）
而使用likely()时，汇编指令为jne （不相等则跳转,相等不跳转）
