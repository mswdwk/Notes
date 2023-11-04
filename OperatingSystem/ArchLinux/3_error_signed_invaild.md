# problem
when yay -Syyu , then get eror below:
```
错误：lua: 来自 "Caleb Maclennan <alerque@archlinux.org>" 的签名是未知信任的
```
# solution
	sudo pacman -S archlinux-keyring

# problem 2
```
删除 kxmlgui 破坏依赖 'kxmlgui' （kfloppy 
```
# solution
	yay -Rdd kfloppy
