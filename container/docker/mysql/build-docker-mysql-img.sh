DIR=~/MySQL5.7_1 
ln -Pf `pwd`/Dockerfile $DIR/Dockerfile
sudo docker build $DIR -t mysql:5.7 
