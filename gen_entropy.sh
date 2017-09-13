#!/bin/sh

FNAME="entropy.bin"

if [ -f $FNAME ]; then
    echo "$FNAME already exists"
    exit 1
fi

ENTROPY=`dd if=/dev/urandom bs=4k count=1 | xxd -p -c 1000000`

echo "enter password to encrypt new entropy"
echo $ENTROPY | openssl aes-256-cbc -a -in - -out $FNAME -md sha256

