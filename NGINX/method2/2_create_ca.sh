# create CA private key
openssl genrsa -out certs/CA/ca.key 4096

# self signature cert
openssl req -config openssl.conf -new -x509 -days 3650 -sha256 -key certs/CA/ca.key -extensions v3_ca -out certs/CA/ca.crt -subj /CN=ca
