#!/bin/bash

# source activate huggingface 
# wandb login

# export MODEL_DIR=bert-base-uncased
# export MODEL_NAME=bert-base-uncased

# export MODEL_DIR=roberta-base
# export MODEL_NAME=roberta-base

# export MODEL_DIR=microsoft/BiomedNLP-PubMedBERT-base-uncased-abstract-fulltext
# export MODEL_NAME=msBert

export MODEL_DIR=[pretrainedmodeldir]
export MODEL_NAME=PubmedBERTbase-MimicBig-EntityBERT

export SEED=42
export LEARNING_RATE=4e-5
export EPOCH=3
export LR_SCHEDULER_TYPE=cosine_with_restarts
export OUTPUT_DIR=[outputdir]/thyme_$MODEL_NAME\_lr.$LEARNING_RATE\_$LR_SCHEDULER_TYPE\_epoch.$EPOCH\_seed.$SEED
export CACHE_DIR=[cachedir]

export TRAIN_FILE=[datadir]/train.csv
export VAL_FILE=[datadir]/val.csv
export DEV_FILE=[datadir]/dev.csv
export TEST_FILE=[datadir]/test.csv


python [transformersdir]/transformers/examples/pytorch/text-classification/run_glue_ens.py \
--model_name_or_path $MODEL_DIR  \
--do_train  \
--do_eval  \
--do_predict  \
--train_file $TRAIN_FILE \
--validation_file $VAL_FILE \
--test_file $TEST_FILE \
--learning_rate $LEARNING_RATE  \
--num_train_epochs $EPOCH  \
--max_seq_length 100  \
--output_dir $OUTPUT_DIR  \
--per_device_eval_batch_size=32 \
--per_device_train_batch_size=32  \
--gradient_accumulation_steps 2  \
--overwrite_output \
--cache_dir $CACHE_DIR \
--overwrite_cache \
--seed $SEED \
--lr_scheduler_type $LR_SCHEDULER_TYPE \
--resample \
--log_level info \
--topk 5 \
--logging_strategy epoch \
--save_strategy epoch \
--evaluation_strategy epoch \
--do_ensemble \
--prune_beta 1  &

# --custom_metric \
# --metric_targets no_none \
# --score_type 'macro avg' \
# --metric_as f1-score \
# --load_best_model_at_end \
# --metric_for_best_model accuracy 

# --logging_strategy steps \
# --logging_steps 1 \
# --save_strategy steps \
# --save_steps 13238 \
# --evaluation_strategy steps \
# --eval_steps 1 \
