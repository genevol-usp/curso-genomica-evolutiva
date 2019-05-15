#!/bin/bash

vcf=./ALL.chrs.eur.biallelic.maf.vcf.gz
out=./genos
log=./pca.log

QTLtools pca --vcf $vcf --distance 6000 --center --scale --out $out --log $log
