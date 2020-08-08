CA_NAME=$1
CLIENT_NAME=$2.$1

openssl genrsa \
    -out $CA_NAME/server/$CLIENT_NAME.server.key \
    4096

openssl req \
    -subj "/CN=$CLIENT_NAME" \
    -new \
    -key $CA_NAME/server/$CLIENT_NAME.server.key \
    -out $CA_NAME/server/$CLIENT_NAME.server.csr

echo subjectAltName = DNS:$CLIENT_NAME >> $CA_NAME/server/$CLIENT_NAME.server.cnf

echo extendedKeyUsage = serverAuth >> $CA_NAME/server/$CLIENT_NAME.server.cnf

openssl x509 \
    -req \
    -days 365 \
    -in $CA_NAME/server/$CLIENT_NAME.server.csr \
    -CA $CA_NAME/ca/$CA_NAME.ca.cert \
    -CAkey $CA_NAME/ca/$CA_NAME.ca.key \
    -CAcreateserial \
    -out $CA_NAME/server/$CLIENT_NAME.server.cert \
    -extfile $CA_NAME/server/$CLIENT_NAME.server.cnf

chmod 0444 $CA_NAME/server/$CLIENT_NAME.server.cert

chmod 0400 $CA_NAME/server/$CLIENT_NAME.server.key

rm -f \
    $CA_NAME/server/$CLIENT_NAME.server.cnf \
    $CA_NAME/server/$CLIENT_NAME.server.csr
