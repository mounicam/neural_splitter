#!/usr/bin/env bash


DATA_BIN=$1
CP=$2

CUDA_VISIBLE_DEVICES=$3 python3  train.py $DATA_BIN -a bert_rand --max-update 100000  \
    --lr 0.0001 --optimizer adam --save-dir $CP --user-dir my_model --batch-size 16 --update-freq 4 \
    --lr-scheduler inverse_sqrt --warmup-updates 40000 --max-source-positions 512 --max-target-positions 512 \
    --bert-path cased_L-12_H-768_A-12/bert_model.ckpt