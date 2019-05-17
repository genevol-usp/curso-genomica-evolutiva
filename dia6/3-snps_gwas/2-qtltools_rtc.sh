#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-22
#PBS -j oe
#PBS -o log/$PBS_JOBID.log

cd $PBS_O_WORKDIR

mkdir -p ./log

chr=$PBS_ARRAYID
region=$(awk -v i="$chr" 'FNR == i' ./regions.txt)

pc=50
samples=../2-eqtl_map/0-genotypes/sampleids.txt
vcf=../2-eqtl_map/0-genotypes/ALL.chrs.eur.biallelic.maf.vcf.gz
cov=../2-eqtl_map/0-genotypes/covariates_genos.txt
bed=../2-eqtl_map/0-phenotypes/phenotypes_$pc.bed.gz
cond=../2-eqtl_map/2-conditionalpass/conditional_${pc}_all.txt.gz
hotspots=./hotspots_hg38_corrected.bed
catalog=./catalog/climate_snps_chr$chr.tsv
out=./rtc_results_chr$chr.txt

QTLtools rtc --vcf $vcf --bed $bed --include-samples $samples --region $region \
    --cov $cov --hotspot $hotspots --gwas-cis $catalog $cond --normal \
    --conditional --out $out --log log/rtc_chr$chr.log
