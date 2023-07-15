# config
echo "`date` start config"
source ./0_vars.sh
echo "INSTALL_DIR_NAME=$INSTALL_DIR_NAME"

echo "`date` start clean data dir: $BASEDIR"
rm -fr $BASEDIR/
#init dir

echo "`date` start init data dir"
mkdir -p $BASEDIR/data/data
mkdir -p $BASEDIR/data/tmp
mkdir -p $BASEDIR/data/undo
mkdir -p $BASEDIR/data/redo
mkdir -p $BASEDIR/log
mkdir -p $BASEDIR/data/binlog
mkdir -p $BASEDIR/data/relaylog
mkdir -p $BASEDIR/etc
