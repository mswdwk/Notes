BASEDIR=~/MySQL5.7/
new_password=RT@21.com
$BASEDIR/bin/mysql -uroot -p -A -e "alter user root@localhost indentified by \"${new_password}\""
