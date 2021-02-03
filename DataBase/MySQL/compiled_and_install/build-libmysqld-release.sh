MYSQL_SRC=~/Repos/mysql-server
MYSQL_ISD=~/MySQL5.7_Release #install dir
BOOST_DIR=/usr/local/boost_1_59_0
BUILD_DIR=~/build-mysql-release

prepare_make(){
	rm -rf  $BUILD_DIR
	mkdir -p $BUILD_DIR
	cd $BUILD_DIR
	cmake -DCMAKE_INSTALL_PREFIX=$MYSQL_ISD  -DWITH_EMBEDDED_SERVER=1 -DWITH_BOOST=$BOOST_DIR \
	-DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_bin \
	-DWITH_EXTRA_CHARSETS:STRING=all \
	-DWITHOUT_NDBCLUSTER_STORAGE_ENGINE=1 -DWITHOUT_TOKUDB_STORAGE_ENGINE=1  \
	-DENABLED_LOCAL_INFILE=1 \
	$MYSQL_SRC 
}

do_make(){
	cd $BUILD_DIR
	make -j16
}

main(){
	case $1 in 
		cmake)
			prepare_make	
	;;
	 	make)
			do_make	
	;;
	esac
}

main $*
