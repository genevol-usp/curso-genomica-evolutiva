#!/bin/bash

pc=50
out=./conditional_$pc

cat ${out}_{1..64}.txt | gzip -c > ${out}_all.txt.gz && rm ${out}_{1..64}.txt 
