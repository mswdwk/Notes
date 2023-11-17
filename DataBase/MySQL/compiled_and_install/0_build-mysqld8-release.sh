MYSQL_SRC=~/repos/mysql-server
MYSQL_ISD=~/MySQL-8035-rel #install dir
BOOST_DIR=/home/user/boost_1_77_0
BUILD_DIR=~/build-mysql8-rel

prepare_make(){
	rm -rf  $BUILD_DIR
	mkdir -p $BUILD_DIR
	mkdir -p $MYSQL_ISD
	cd $BUILD_DIR
	# NOTE: the libmysqld embedded server library is removed in mysql 8.0
	#cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DWITH_UNIT_TESTS=1 -DWITH_DEBUG=1 -DWITH_BOOST=$BOOST_DIR \
	#cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DCMAKE_BUILD_TYPE=RelWithDebInfo  -DWITH_BOOST=$BOOST_DIR \
	cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DCMAKE_BUILD_TYPE=release -DWITH_BOOST=$BOOST_DIR \
	-DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_bin \
	-DWITH_EXTRA_CHARSETS:STRING=all -DWITH_SYSTEMD=1 \
	-DENABLED_LOCAL_INFILE=1 \
	$MYSQL_SRC 
}

do_make(){
	cd $BUILD_DIR
	make -j16
}

usage()
{
	echo -e "Usage:	\n\t`basename $0` prepare|make"
}

main(){
	case $1 in 
		prepare)
			prepare_make	
	;;
	 	make)
			do_make	
	;;
		*)
		usage
	esac
}

main $*
