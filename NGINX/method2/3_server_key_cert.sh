openssl genrsa -out certs/server/server.key 2048

openssl req -config openssl.conf -new -sha256 -key certs/server/server.key -out certs/server/server.csr -subj /CN=server
