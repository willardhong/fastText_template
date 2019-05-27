#!/bin/bash
### this is a template for classify text using fastText
### you can run in both command line by copy and paste or as ./*.sh
### willard hong 5/26/2019

###########################################
### step 1. clean data
###########################################

#cat data/yelp/yelp_review.csv | python parse_yelp_dataset.py > data/yelp/yelp_review.v1.csv
#cat data/yelp/yelp_review.csv | python remove_stop_words.py > data/yelp/no_stop_words.txt
#cat data/yelp/yelp_review.v1.csv | tr '[:upper:]' '[:lower:]' > data/yelp/yelp_review.v2.csv

#cat data/yelp/yelp_review.v1.csv \
#    | sed -e "s/'/ ' /g" \
#     -e 's/"//g' -e 's/\./ \. /g' -e 's/<br \/>/ /g' \
#     -e 's/,/ , /g' -e 's/(/ ( /g' -e 's/)/ ) /g' \
#     -e 's/\!/ \! /g' \
#     -e 's/\?/ \? /g' -e 's/\;/ /g' \
#     -e 's/\:/ /g' > data/yelp/yelp_review.v2.csv

#cat data/yelp/yelp_review.v2.csv | sed 's/\,//g' > data/yelp/yelp_review.v3.csv
#cat data/yelp/yelp_review.v3.csv | sed 's/\.//g' > data/yelp/yelp_review.v4.csv
#cat data/yelp/yelp_review.v5.csv | tr -s " " > data/yelp/yelp_review.v6.csv

#cat data/yelp/yelp_review.v2.csv | shuf > data/yelp/yelp_review.v3.csv

#STR=$(wc -l < data/yelp/yelp_review.v3.csv)
#echo $STR    

### split into test and val 

#awk -v fact=0.80 \
#    'NR <= 5261668 * fact {print > "data/yelp/train.txt"; next} {print > "data/yelp/val.txt"}' \
#    data/yelp/yelp_review.v3.csv

###########################################
### step 2. build fastText model 
###########################################

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model
#fasttext test model/yelp/star_model.bin data/yelp/val.txt

###########################################
### step 3. build confusion matrix
###########################################

#cut -f 1 -d ' ' data/yelp/val.txt > data/yelp/val.testlabel
#cut -f 2- -d ' ' data/yelp/val.txt > data/yelp/val.testsentences
#fasttext predict model/yelp/star_model.bin data/yelp/val.testsentences > pexp

#python fasttext_confusion_matrix.py data/yelp/val.testlabel pexp

###########################################
### step 4. Hyperparameter tuning
###########################################

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model -epoch 25

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model -lr 1.0

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model -wordNgrams 2

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model -wordNgrams 3

#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model -wordNgrams 2 -lr 1.0 -epoch 10

###########################################
### step 5. optional ... use your own embedding
###########################################
#fasttext supervised -input data/yelp/train.txt -output model/yelp/star_model_withprevecs -pretrainedVectors wiki-news-300d-1M.vec -dim 300

###########################################
### step 6. Model quantization
###########################################

#fasttext quantize -output "model/yelp/star_model" -input "data/yelp/train.txt" -qnorm -retrain -epoch 1 -cutoff 100000

fasttext test model/yelp/star_model.ftz data/yelp/val.txt
