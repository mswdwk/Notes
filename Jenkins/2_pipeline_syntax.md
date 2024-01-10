1)	pipeline 是声明式流水线的一种特定语法，他定义了包含执行整个流水线的所有内容和指令的 "block" 。
2) agent是声明式流水线的一种特定语法，它指示 Jenkins 为整个流水线分配一个执行器 (在节点上)和工作区。
3) stage 是一个描述 stage of this Pipeline的语法块。在 Pipeline syntax 页面阅读更多有关声明式流水线语法的`stage`块的信息。如 above所述, 在脚本化流水线语法中，stage 块是可选的。
4) steps 是声明式流水线的一种特定语法，它描述了在这个 stage 中要运行的步骤。
5) sh 是一个执行给定的shell命令的流水线 step (由 Pipeline: Nodes and Processes plugin提供) 。
6) junit 是另一个聚合测试报告的流水线 step (由 JUnit plugin提供)。
7) node 是脚本化流水线的一种特定语法，它指示 Jenkins 在任何可用的代理/节点上执行流水线 (和包含在其中的任何阶段)这实际上等效于 声明式流水线特定语法的`agent`。
