#!/bin/bash

# dados de entrada e saída
chr=chr$1
yrivcf=./results/${chr}.yri.filtered
out=./results/yri$chr

# fazer análise de HWE
vcftools --vcf $yrivcf.recode.vcf --out $out --hardy

# obter as frequências alélicas
vcftools --vcf $yrivcf.recode.vcf --out $out --freq

# calcular estastítica pi por janela de 50kb
vcftools --vcf $yrivcf.recode.vcf --window-pi 50000 --out $out 
