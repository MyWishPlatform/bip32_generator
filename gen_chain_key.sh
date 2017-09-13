#!/bin/sh

IN_FNAME="entropy.bin"

if [ ! -f $IN_FNAME ]; then
    echo "no $IN_FNAME file"
    exit 1
fi

echo "enter account id"
read ID
OUT_FNAME="chain_key_$ID.bin"

echo "enter password to decrypt entropy.bin"
ENTROPY=`openssl aes-256-cbc -d -a -in $IN_FNAME -out - -md sha256`

CHAIN_KEY=`echo $ENTROPY | bip32gen -i entropy -f - -x -o xprv -F - m/"$ID"h/0`

echo "enter password to encrypt new master key"
echo $CHAIN_KEY | openssl aes-256-cbc -a -in - -out $OUT_FNAME -md sha256

echo
echo "success. see $OUT_FNAME"
