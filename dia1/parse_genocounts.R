hw <- read.table("./results/chr21.yri.hwe", header = TRUE, stringsAsFactors = FALSE)[ ,2:3]

genos <- strsplit(hw[[2]], "/")

ref_ref <- as.integer(sapply(genos, "[", 1))
ref_alt <- as.integer(sapply(genos, "[", 2))
alt_alt <- as.integer(sapply(genos, "[", 3))

counts_df <- data.frame(pos = hw$POS,
                        ref_ref = ref_ref,
                        ref_alt = ref_alt,
                        alt_alt = alt_alt)

write.table(counts_df, 
            "./results/chr21.yri.genotypecounts.tsv", 
            sep = "\t", quote = FALSE, row.names = FALSE)
