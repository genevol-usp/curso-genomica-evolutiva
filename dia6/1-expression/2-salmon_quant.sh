#!/bin/bash

#PBS -l nodes=1:ppn=4
#PBS -l mem=8gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-87
#PBS -j oe
#PBS -o /scratch/bio5789/log/salmon_quant_${PBS_ARRAYID}.log

cd $PBS_O_WORKDIR

sampleid=$(awk -v i="$PBS_ARRAYID" 'FNR == i { print $1 }' ./sampleids.tsv)
enaid=$(awk -v i="$PBS_ARRAYID" 'FNR == i { print $2 }' ./sampleids.tsv)

index=/scratch/bio5789/transcripts_index
fastq1=/scratch/bio5789/fastq/${enaid}_1.fastq.gz
fastq2=/scratch/bio5789/fastq/${enaid}_2.fastq.gz
out=/scratch/bio5789/quantifications/$sampleid

salmon quant -i $index -l IU -1 $fastq1 -2 $fastq2 --validateMappings \
    -p $PBS_NUM_PPN --seqBias --gcBias --posBias -o $out 
