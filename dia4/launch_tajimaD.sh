#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-3 
#PBS -j oe
#PBS -o $PBS_JOBID.log

cd $PBS_O_WORKDIR

populations=(AFR EUR EAS)

pop="${populations[$PBS_ARRAYID-1]}"

vcftools --vcf ./dados/SNPs_Chr2_${pop}_maf.recode.vcf --chr 2 --TajimaD 1000 --out $pop
