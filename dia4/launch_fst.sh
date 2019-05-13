#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=8gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-3 
#PBS -j oe
#PBS -o $PBS_JOBID.log

cd $PBS_O_WORKDIR

allpairs=(AFR_EAS AFR_EUR EAS_EUR)

pair="${allpairs[$PBS_ARRAYID-1]}"

pop1=$(echo $pair | cut -d'_' -f1)
pop2=$(echo $pair | cut -d'_' -f2)

/home/debora/vcftools/src/cpp/vcftools --vcf ./dados/SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf \
    --out ${pair}_maf --chr 2 \
    --weir-fst-pop ./dados/pop_${pop1}_1000g.txt \
    --weir-fst-pop ./dados/pop_${pop2}_1000g.txt
