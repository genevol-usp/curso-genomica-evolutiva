#!/bin/bash

#PBS -l nodes=1:ppn=1
#PBS -l mem=12gb
#PBS -l walltime=24:00:00
#PBS -q short
#PBS -j oe
#PBS -o salmon_index.log

cd $PBS_O_WORKDIR

salmon index -t ./gencode.v25.transcripts.fa -i transcripts_index --type quasi -k 31 
