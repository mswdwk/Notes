# ENV: RedHat OS 7.x   x86 , install package 'redhat-release-server'
# %24releasever , url ,404 , error
Because you do not install centos-release or redhat-release on RedHat Linux. 
In case of file '/etc/yum.conf' contains config 'distroverpkg=centos-release'.
## solutation 1: use `--releasever`
	yum --releasever=7  install xxx
## solutation 2: replace '%24releasever' to '7' in /etc/repo.yum.d/*.repo
## solutation 3: set 'distroverpkg=redhat-release-server' in file '/etc/yum.conf'
In case of you have already install 'redhat-server-release' package on your machine.
 
# Reference
[8.4.3. Using Yum Variables](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sec-using_yum_variables)
"You can use this variable to reference the release version of Red Hat Enterprise Linux. Yum obtains the value of $releasever from the distroverpkg=value line in the /etc/yum.conf configuration file. If there is no such line in /etc/yum.conf, then yum infers the correct value by deriving the version number from the redhat-release-server package. The value of $releasever typically consists of the major release number and the variant of Red Hat Enterprise Linux, for example 6Client, or 6Server."
