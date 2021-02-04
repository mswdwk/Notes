# cd mysql-test
#./mtr  --extern socket=../bin/mysql1.sock --extern password=Roo123. analyze
MTR_DIR=~/MySQL5.7_1/mysql-test
ln -sf `pwd`/t/deadlock.test  $MTR_DIR/t/deadlock.test
cd $MTR_DIR
./mtr --extern socket=../bin/mysql1.sock --extern password=Roo123.  deadlock
cd -
