import csv
import sys
w = csv.writer(sys.stdout)
for row in csv.DictReader(sys.stdin):
    w.writerow(['__label__'+row['stars'].lower(), row['text'].replace('\n', '').lower()])

