#!/bin/bash

chr=chr21
vcf=./data/ALL.${chr}_GRCh38.genotypes.20170504.vcf.gz
samples=./data/yri_sample_ids.txt
yrivcf=./data/${chr}.yri.filtered

#bcftools view --samples-file $samples $vcf |\
#    bcftools view --min-af 0.05:minor --genotype ^miss -m2 -M2 --trim-alt-alleles \
#    -o $yrivcf -O z - 
#
#bcftools query -f '%ID %AN %AC{0}\n' $yrivcf |\
#    awk '{printf "%s %f\n",$1,$3/$2}' > ./data/allele_freq.tsv
#
#zcat $vcf | grep -v '^#' | awk '{print $2}' | uniq -c | awk '$1 >= 2 {print $2}' > duplicated_vars.txt

vcftools --gzvcf $vcf --keep $samples \
    --exclude-positions duplicated_vars.txt --min-alleles 2 --max-alleles 2 --maf 0.05 --max-maf 0.95 \
    --recode \
    --out $yrivcf    

#vcftools --gzvcf $yrivcf --out ./data/genos --hardy
