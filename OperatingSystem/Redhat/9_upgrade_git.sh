# 1) install git 2.27
sudo yum install rh-git227.x86_64 --releasever=7
# 2) use git-2.27 as default git
```
scl enable rh-git227 $SHELL 
#eg: scl enable rh-git227 zsh
sudo mv /usr/bin/git /usr/bin/git-1.8
sudo ln -s /opt/rh/rh-git227/root/bin/git /usr/bin/git
```
