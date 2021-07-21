# %24releasever , url ,404 , error
Because you do not install centos-release on RedHat Linux.
## solutation 1: use `--releasever`
	yum --releasever=7  install xxx
## solutation 2: replace '%24releasever' to '7' in /etc/repo.yum.d/*.repo

