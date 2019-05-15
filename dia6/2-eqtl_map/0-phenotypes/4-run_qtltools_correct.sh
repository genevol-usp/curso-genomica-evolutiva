#!/bin/bash

BED=./phenotypes.bed.gz

# 0 PCs
QTLtools correct --bed $BED --normal --out ./phenotypes_0.bed
bgzip ./phenotypes_0.bed && tabix -p bed ./phenotypes_0.bed.gz

# 10-100 PCs
for pcs in $(seq 10 10 100)
do
    COV=./covariates_pheno_$pcs.txt
    OUT=./phenotypes_$pcs.bed

    QTLtools correct --bed $BED --cov $COV --normal --out $OUT
    bgzip $OUT && tabix -p bed $OUT.gz
done
