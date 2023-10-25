#docker run -d --name prometheus bitnami/prometheus:latest
docker rm prometheus

#/etc/prometheus/prometheus.yml 
#docker run -d --name prometheus \
#		    -v /data1/prometheus:/opt/bitnami/prometheus/data \
#			-v ./prometheus.yml:/etc/prometheus/prometheus.yml \
#			    bitnami/prometheus:latest
#
#			-v ./prometheus.yml:/opt/bitnami/prometheus/conf/prometheus.yml \

docker run -d --name prometheus -p 9090:9090 \
			    -v ./prometheus.yml:/etc/prometheus/prometheus.yml \
				    prom/prometheus
