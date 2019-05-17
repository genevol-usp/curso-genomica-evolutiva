#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=1gb
#PBS -l walltime=24:00:00
#PBS -t 1-64
#PBS -q short 
#PBS -j oe 
#PBS -o /scratch/bio5789/log/$PBS_JOBID.log

cd $PBS_O_WORKDIR

pc=20
chunk=$PBS_ARRAYID
samples=../0-genotypes/sampleids.txt
vcf=/scratch/bio5789/genotypes/ALL.chrs.yri.biallelic.maf.vcf.gz
cov=../0-genotypes/covariates_genos.txt
bed=../0-phenotypes/phenotypes_$pc.bed.gz
out=/scratch/bio5789/permutations/permutations_$pc

QTLtools cis --vcf $vcf --bed $bed --cov $cov --include-samples $samples \
    --normal --chunk $chunk 64 --permute 1000 --out ${out}_$chunk.txt
