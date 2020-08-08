CA_NAME=$1
CLIENT_NAME=$2.$1

openssl genrsa \
    -out $CA_NAME/client/$CLIENT_NAME.client.key \
    4096

openssl req \
    -subj "/CN=$CLIENT_NAME" \
    -new \
    -key $CA_NAME/client/$CLIENT_NAME.client.key \
    -out $CA_NAME/client/$CLIENT_NAME.client.csr

echo extendedKeyUsage = clientAuth > $CA_NAME/client/$CLIENT_NAME.client.cnf

openssl x509 \
    -req \
    -days 365 \
    -sha256 \
    -in $CA_NAME/client/$CLIENT_NAME.client.csr \
    -CA $CA_NAME/ca/$CA_NAME.ca.cert \
    -CAkey $CA_NAME/ca/$CA_NAME.ca.key \
    -CAcreateserial \
    -out $CA_NAME/client/$CLIENT_NAME.client.cert \
    -extfile $CA_NAME/client/$CLIENT_NAME.client.cnf

chmod 0444 $CA_NAME/client/$CLIENT_NAME.client.cert

chmod 0400 $CA_NAME/client/$CLIENT_NAME.client.key

rm -f \
    $CA_NAME/client/$CLIENT_NAME.client.cnf \
    $CA_NAME/client/$CLIENT_NAME.client.csr
