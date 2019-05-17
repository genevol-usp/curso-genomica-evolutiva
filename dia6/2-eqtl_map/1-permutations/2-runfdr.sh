#!/bin/bash

pc=20
out=/scratch/bio5789/permutations/permutations_$pc
cat ${out}_{1..64}.txt | gzip -c > $out.txt.gz
rm ${out}_{1..64}.txt

Rscript runfdr.R $out.txt.gz 0.05 $out
