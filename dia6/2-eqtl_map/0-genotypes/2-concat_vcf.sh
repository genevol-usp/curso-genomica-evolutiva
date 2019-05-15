#!/bin/bash

out=ALL.chrs.eur.biallelic.maf.vcf.gz

bcftools concat -o $out -O z ALL.chr{1..22}.eur.biallelic.maf.vcf.gz  
tabix -p vcf $out

rm ALL.chr{1..22}.eur.biallelic.maf.vcf.gz
