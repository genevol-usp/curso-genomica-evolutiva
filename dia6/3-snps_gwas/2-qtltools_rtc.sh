#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=12gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-22
#PBS -j oe
#PBS -o /scratch/bio5789/log/$PBS_JOBID.log

cd $PBS_O_WORKDIR

chr=$PBS_ARRAYID
region=$(awk -v i="$chr" 'FNR == i' ./regions.txt)

pc=20
samples=../2-eqtl_map/0-genotypes/sampleids.txt
vcf=/scratch/bio5789/genotypes/ALL.chrs.yri.biallelic.maf.vcf.gz
cov=../2-eqtl_map/0-genotypes/covariates_genos.txt
bed=../2-eqtl_map/0-phenotypes/phenotypes_$pc.bed.gz
cond=/scratch/bio5789/conditionalpass/conditional_${pc}_all.txt.gz
hotspots=./hotspots_hg38_corrected.bed
catalog=./gwas_catalog_filtered.txt
out=/scratch/bio5789/rtc/rtc_results_chr$chr.txt
log=/scratch/bio5789/log/rtc_chr$chr.log

QTLtools rtc --vcf $vcf --bed $bed --include-samples $samples --region $region \
    --cov $cov --hotspot $hotspots --gwas-cis $catalog $cond --normal \
    --conditional --out $out --log $log 
