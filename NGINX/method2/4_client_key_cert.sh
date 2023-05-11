openssl genrsa -out certs/client/client.key 2048

openssl req -config openssl.conf -new -sha256 -key certs/client/client.key -out certs/client/client.csr -subj /CN=server
