mkdir $1

mkdir $1/ca $1/server $1/client

openssl genrsa \
    -out $1/ca/$1.ca.key \
    4096

openssl req \
    -subj "/CN=$1" \
    -new \
    -x509 \
    -days 365 \
    -key $1/ca/$1.ca.key \
    -sha256 \
    -out $1/ca/$1.ca.cert

chmod 0444 $1/ca/$1.ca.cert

chmod 0400 $1/ca/$1.ca.key
