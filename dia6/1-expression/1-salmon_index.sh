#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=12gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -j oe
#PBS -o salmon_index.log

cd $PBS_O_WORKDIR

indexout=/scratch/bio5789/transcripts_index

salmon index -t ./gencode.v25.transcripts.fa.gz -i $indexout --type quasi -k 31 
