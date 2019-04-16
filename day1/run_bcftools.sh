#!/bin/bash

VCF=./data/ALL.chr22_GRCh38.genotypes.20170504.vcf.gz
SAMPLES=./data/yri_sample_ids.txt
YRIVCF=./data/chr22.yri.filtered.vcf.gz

bcftools view --samples-file $SAMPLES $VCF |\
    bcftools view --min-af 0.05:minor --genotype ^miss -m2 -M2 --trim-alt-alleles \
    -o $YRIVCF -O z - 
