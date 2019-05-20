#!/bin/bash

# dados de entrada e saída
chr=chr$1
yrivcf=./results/${chr}.yri.filtered.recode.vcf
out=./results/${chr}.yri

# calcular estastítica pi por janela de 50kb
vcftools --vcf $yrivcf --site-pi --out $out 
