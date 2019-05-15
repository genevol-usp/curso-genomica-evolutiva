#!/bin/bash

for PC in $(seq 0 10 100)
do
    out=./results/permutations_$PC
    cat ${out}_{1..64}.txt | gzip -c > $out.txt.gz
    rm ${out}_{1..64}.txt

    Rscript runfdr.R $out.txt.gz 0.05 $out
    echo "PC$PC done!"
done
