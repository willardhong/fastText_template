#!/bin/bash

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

#awk -v fact=0.80 \
#    'NR <= 5261668 * fact {print > "data/yelp/train.txt"; next} {print > "data/yelp/val.txt"}' \
#    data/yelp/yelp_review.v3.csv

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model
#fasttext test result/yelp/star_model.bin data/yelp/val.txt
#cut -f 1 -d ' ' data/yelp/val.txt > data/yelp/val.testlabel
#cut -f 2- -d ' ' data/yelp/val.txt > data/yelp/val.testsentences
#fasttext predict result/yelp/star_model.bin data/yelp/val.testsentences > pexp

#python fasttext_confusion_matrix.py data/yelp/val.testlabel pexp

### Hyperparameter tuning

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model -epoch 25

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model -lr 1.0

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model -wordNgrams 2

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model -wordNgrams 3

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model -wordNgrams 2 -lr 1.0 -epoch 10

#fasttext supervised -input data/yelp/train.txt -output result/yelp/star_model_withprevecs -pretrainedVectors wiki-news-300d-1M.vec -dim 300
