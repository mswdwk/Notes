MYSQL_SRC=~/mysql-8.0.25-src
MYSQL_ISD=~/MySQL-8025 #install dir
BOOST_DIR=/usr/local/boost_1_73_0
BUILD_DIR=~/build-mysql8

prepare_make(){
	rm -rf  $BUILD_DIR
	mkdir -p $BUILD_DIR
	mkdir -p $BUILD_ISD
	cd $BUILD_DIR
	# NOTE: the libmysqld embedded server library is removed in mysql 8.0
	#cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DWITH_UNIT_TESTS=1 -DWITH_DEBUG=1 -DWITH_BOOST=$BOOST_DIR \
	cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DWITH_DEBUG=1 -DWITH_BOOST=$BOOST_DIR \
	-DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_bin \
	-DWITH_EXTRA_CHARSETS:STRING=all \
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
