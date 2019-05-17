#!/bin/bash

out=/scratch/bio5789/genotypes/ALL.chrs.yri.biallelic.maf.vcf.gz

bcftools concat -o $out -O z /scratch/bio5789/genotypes/ALL.chr{1..22}.yri.biallelic.maf.vcf.gz 
tabix -p vcf $out
