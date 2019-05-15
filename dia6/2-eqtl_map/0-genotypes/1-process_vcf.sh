#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-22
#PBS -j oe
#PBS -o $HOME/curso-genomica-evolutiva/dia6/2-eqtl_map/genotypes/log/$PBS_JOBID.log

cd $PBS_O_WORKDIR

chr=$PBS_ARRAYID

samples=./sampleids.txt 
vcfdir=/raid/genevol/kgp_vcf/phase3_20130502_grch38positions
vcfin=$vcfdir/ALL.chr${chr}_GRCh38.genotypes.20170504.vcf.gz
vcfout=./ALL.chr${chr}.eur.biallelic.maf.vcf.gz
dups=duplicates_chr$chr.txt

bcftools view --samples-file $samples $vcfin |\
    bcftools view --genotype ^miss -m2 -M2 --min-af 0.05:minor \
    -o temp.$chr.vcf.gz -O z -

zcat temp.$chr.vcf.gz |\
    grep -v "^#" |\
    awk '{print $3}' |\
    uniq -c |\
    awk '$1>=2{print $2}' > $dups

bcftools view --exclude "%ID=@$dups" -o $vcfout -O z temp.$chr.vcf.gz

rm temp.$chr.vcf.gz $dups
