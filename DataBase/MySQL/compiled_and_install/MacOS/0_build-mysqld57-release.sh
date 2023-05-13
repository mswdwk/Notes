MYSQL_VERSION=5740
BOOST_VERSION=1_59_0
MYSQL_SRC=~/Repos/mysql-server
#mysql install dir
MYSQL_ISD=~/MySQL-$MYSQL_VERSION-rel 
BOOST_DIR=~/boost/boost_$BOOST_VERSION
BUILD_DIR=~/build/build-mysql${MYSQL_VERSION}-rel

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
	-DWITH_EXTRA_CHARSETS:STRING=all \ #-DWITH_SYSTEMD=1 \
	-DENABLED_LOCAL_INFILE=1 \
	$MYSQL_SRC 
}

do_make(){
	cd $BUILD_DIR
	make -j16
}

usage()
{
	echo -e "Usage:	\n\t`basename $0` prepare|make|package"
}

main(){
	case $1 in 
		prepare)
			prepare_make	
	;;
	 	make)
			do_make	
	;;
	 	package)
			cd $BUILD_DIR && make package	
	;;
		*)
			usage
	esac
}

main $*
