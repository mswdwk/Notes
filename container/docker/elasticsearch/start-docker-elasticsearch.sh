HOST_DIR=`pwd`
#docker run -d --name elas -p 5601:5601 -v $HOST_DIR/config:/usr/share/kibana/config elasticsearch:7.9.0
#docker run -d --name elas -p 9200:9200 -p 9300:9300  -v $HOST_DIR/sysctl.conf:/etc/sysctl.conf elasticsearch:7.9.0
docker run --name elas -p 9200:9200 -p 9300:9300  -e "discovery.type=single-node" -e ES_JAVA_OPTS="-Xms64m -Xmx128m" -v /mydata/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /mydata/elasticsearch/data:/usr/share/elasticsearch/data -v /mydata/elasticsearch/plugins:/usr/share/elasticsearch/plugins -d elasticsearch:7.9.0
