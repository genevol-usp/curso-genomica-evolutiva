#!/bin/bash

# dados de entrada e saída
chr=chr$1
yrivcf=./results/${chr}.yri.filtered.recode.vcf
out=./results/$chr.yri

# fazer análise de HWE
vcftools --vcf $yrivcf --out $out --hardy

# obter as frequências alélicas
vcftools --vcf $yrivcf --out $out --freq

# calcular estastítica pi por janela de 50kb
vcftools --vcf $yrivcf --window-pi 50000 --out $out 
