# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

MYSQL_INSTALL_DIR=~/MySQL5.7_1
JAVA_HOME=/usr/lib/jdk1.8.0_221
PATH=$JAVA_HOME/bin:$PATH:$HOME/.local/bin:$HOME/bin:$MYSQL_INSTALL_DIR/bin

export PATH
alias gst="git status"
