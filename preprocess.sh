#!/usr/bin/env bash


RAW_DATA_PATH=$1
ANON_DATA_PATH=$2
DATA_BIN=$3

mkdir -p $ANON_DATA_PATH

python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/test.src --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/test.aner.src
python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/test.dst --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/test.aner.dst


python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/valid.src --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/valid.aner.src
python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/valid.dst --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/valid.aner.dst


python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/train.src --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/train.aner.src
python3 preprocess/anonymize_wordpiece.py --input $RAW_DATA_PATH/train.dst --vocab preprocess/vocab.txt \
 --output  $ANON_DATA_PATH/train.aner.dst


python3 preprocess.py --workers 5 --source-lang src --target-lang dst \
  --trainpref $ANON_DATA_PATH/train.aner --validpref $ANON_DATA_PATH/valid.aner --testpref $ANON_DATA_PATH/test.aner \
  --destdir  $DATA_BIN --padding-factor 1 --joined-dictionary --srcdict preprocess/vocab_count.txt

