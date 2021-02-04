# cd mysql-test
#./mtr  --extern socket=../bin/mysql1.sock --extern password=Roo123. analyze
MTR_DIR=~/MySQL5.7_1/mysql-test
ln -sf `pwd`/t/insertdata.test  $MTR_DIR/t/insertdata.test
cd $MTR_DIR
./mtr --extern socket=../bin/mysql1.sock --extern password=Roo123.  insertdata
cd -
