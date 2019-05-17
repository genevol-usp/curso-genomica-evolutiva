## download recombination hotspots data
#wget http://jungle.unige.ch/QTLtools_examples/hotspots_b37_hg19.bed
#
## convert genomic coordinates between different assemblies
#wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
#gunzip hg19ToHg38.over.chain.gz
#
##liftOver hotspots_b37_hg19.bed hg19ToHg38.over.chain hotspots_hg38.bed unmapped_to_hg38
#Rscript fix_hotspots.R
#
## make table with SNP positions from VCF
#bcftools view -H ../2-eqtl_map/0-genotypes/ALL.chrs.eur.biallelic.maf.vcf.gz |\
#    awk '{ print $1"\t"$2"\t"$3 }' > snp_positions.tsv
#
#Rscript write_regions.R
