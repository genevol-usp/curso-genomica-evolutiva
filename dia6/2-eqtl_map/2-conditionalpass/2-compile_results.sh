#!/bin/bash

pc=20
out=/scratch/bio5789/conditionalpass/conditional_$pc

cat ${out}_{1..64}.txt | gzip -c > ${out}_all.txt.gz && rm ${out}_{1..64}.txt 
