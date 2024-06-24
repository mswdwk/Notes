[运行多实例的应用](https://kubernetes.io/zh-cn/docs/tutorials/kubernetes-basics/scale/scale-intro/)
# 要列出你的 Deployment，使用 get deployments 子命令：

kubectl get deployments

输出应该类似于：

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
kubernetes-bootcamp   1/1     1            1           11m
我们应该有 1 个 Pod。如果没有，请再次运行该命令。结果显示：

NAME 列出 Deployment 在集群中的名称。
READY 显示当前/预期（CURRENT/DESIRED）副本数的比例。
UP-TO-DATE 显示为了达到预期状态，而被更新的副本的数量。
AVAILABLE 显示应用有多少个副本对你的用户可用。
AGE 显示应用的运行时间。

# 查看由 Deployment 创建的 ReplicaSet，运行：

kubectl get rs

注意 ReplicaSet 名称总是遵循 [DEPLOYMENT-NAME]-[RANDOM-STRING] 的格式。 随机字符串是使用 pod-template-hash 作为种子随机生成的。

该输出有两个重要的列是：

DESIRED 显示了应用的预期副本数量，这是你在创建 Deployment 时定义的。这就是预期状态（desired state）。
CURRENT 显示了当前正在运行的副本数量。

# 扩容 Deployment 到 4 个副本。
使用 kubectl scale 命令，后面给出 Deployment 类型、名称和预期的实例数量：

kubectl scale deployments/kubernetes-bootcamp --replicas=4

要再次列举出你的 Deployment，使用 get deployments：

kubectl get deployments

更改已应用，我们有 4 个应用实例可用。
# 检查 Pod 的数量是否发生变化：

kubectl get pods -o wide

现在有 4 个 Pod，各有不同的 IP 地址。这一变化会记录到 Deployment 的事件日志中。 要检查这一点，请使用 describe 子命令：

kubectl describe deployments/kubernetes-bootcamp

你还可以从该命令的输出中看到，现在有 4 个副本。
