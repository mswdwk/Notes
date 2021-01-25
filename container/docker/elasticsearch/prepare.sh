mkdir -p /mydata/elasticsearch/config
mkdir -p /mydata/elasticsearch/data
chmod -R +666 /mydata/
echo "http.host: 0.0.0.0" >> /mydata/elasticsearch/config/elasticsearch.yml
