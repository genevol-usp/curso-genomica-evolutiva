#!/bin/bash

# dados de entrada e saída
chr=chr$1
vcf=./data/ALL.${chr}_GRCh38.genotypes.20170504.vcf.gz
samples=./data/yri_sample_ids.txt
yrivcf=./results/${chr}.yri.filtered

mkdir -p ./results

# extrair variants duplicadas no VCF
zcat $vcf |\
    grep -v '^#' |\
    awk '{print $2}' |\
    uniq -c |\
    awk '$1 >= 2 {print $2}' > ./results/duplicated_vars.txt

# selecionar indivíduos YRI
# excluir posições duplicadas
# selecionar apenas variantes bialélicas
# selecionar variantes com MAF >= 5%
vcftools --gzvcf $vcf --keep $samples \
    --exclude-positions ./results/duplicated_vars.txt \
    --min-alleles 2 --max-alleles 2 \
    --maf 0.05 --max-maf 0.95 \
    --recode --out $yrivcf    
