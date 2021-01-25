Kibana server is not ready yet
# start kibana
docker run -d --name kibana -p 5601:5601 kibana:7.9.3

#
docker run -d --name kibana -p 5601:5601 \
-v /usr/local/docker/kibana/config:/usr/share/kibana/config kibana:7.9.3
