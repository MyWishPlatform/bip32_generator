if [ $# -lt 3 ]; then
    echo "usage: gen_keys account from to"
    exit 1
fi

IN_FNAME="chain_key_$1.bin"
OUT_FNAME="result-$1-from-$2-to-$3.bin"

if [ ! -f $IN_FNAME ]; then
    echo "no file $IN_FNAME"
    exit 1
fi

echo "enter password to decrypt chain key"
CHAIN_KEY=`openssl aes-256-cbc -d -a -in $IN_FNAME -out -`
echo

echo "enter another password to ecrypt generated keys"
echo $CHAIN_KEY | bip32gen -i xprv -f - -x -o privkey -F - -X `seq $2 $3` | openssl aes-256-cbc -a -in - -out $OUT_FNAME
echo

echo "success: see $OUT_FNAME"
