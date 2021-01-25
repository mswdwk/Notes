HOST_DIR=`pwd`
docker run -d --name kibana -p 5601:5601 -v $HOST_DIR/config:/usr/share/kibana/config kibana:7.9.3
