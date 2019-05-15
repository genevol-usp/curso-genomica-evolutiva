#!/bin/bash

#PBS -l nodes=1:ppn=4
#PBS -l mem=8gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -t 1-358
#PBS -j oe
#PBS -o salmon_quant_${PBS_ARRAYID}.log

cd $PBS_O_WORKDIR

sampleid=$(awk -v i="$PBS_ARRAYID" 'FNR == i { print $1 }' ./sampleids.tsv)
enaid=$(awk -v i="$PBS_ARRAYID" 'FNR == i { print $2 }' ./sampleids.tsv)

salmon quant -i transcripts_index \
    -l IU -1 ./fastq/${enaid}_1.fastq.gz -2 ./fastq/${enaid}_2.fastq.gz \
    --validateMappings -p $PBS_NUM_PPN --seqBias --gcBias --posBias \
    -o $sampleid
