library(tidyverse)

annotations <- "./gencode.v25.annotation.gtf" %>%
    read_tsv(comment = "##", col_names = FALSE, col_types = "c-cii-c-c")

transc_filter <- annotations %>%
    filter(X3 == "transcript",
	   X1 %in% paste0("chr", 1:22)) %>%
    select(chr = X1, X9) %>%
    rowid_to_column("i") %>%
    mutate(X9 = str_split(X9, "; ")) %>%
    unnest() %>%
    filter(grepl("^gene_id|^transcript_id|^transcript_type", X9)) %>%
    separate(X9, c("tag", "id"), sep = " ") %>%
    mutate(id = gsub("\"", "", id)) %>%
    filter(chr %in% paste0("chr", 1:22)) %>%
    spread(tag, id) %>%
    select(-i) %>%
    filter(transcript_type == "protein_coding" | 
           grepl("^(IG|TR)_[CDJV]_gene", transcript_type)) %>%
    select(gene_id, transcript_id)

gene_annots <- annotations %>%
    filter(X3 == "gene",
	   X1 %in% paste0("chr", 1:22)) %>%
    select(chr = X1, start = X4, end = X5, strd = X7, X9) %>%
    rowid_to_column("i") %>%
    mutate(X9 = str_split(X9, "; ")) %>%
    unnest() %>%
    filter(grepl("^gene_id", X9)) %>%
    separate(X9, c("tag", "id"), sep = " ") %>%
    mutate(chr = sub("^chr", "", chr),
	   chr = as.integer(chr),
	   id = gsub("\"", "", id)) %>%
    spread(tag, id) %>%
    select(-i)

sampleids <- read_tsv("../../1-expression/sampleids.tsv", col_names = FALSE) %>%
    pull(X1)

quant <- file.path("/scratch/bio5789/quantifications", sampleids, "quant.sf") %>%
    setNames(sampleids) %>%
    map_df(. %>% read_tsv() %>% 
	   mutate(Name = sub("^([^\\|]+).+$", "\\1", Name)) %>%
	   inner_join(transc_filter, by = c("Name" = "transcript_id")) %>%
	   select(transc_id = Name, gene_id, tpm = TPM),
	   .id = "subject")
	   
gene_quant <- quant %>%
    group_by(subject, gene_id) %>%
    summarise(tpm = sum(tpm)) %>%
    ungroup() 

gene_bed <- gene_quant %>%
    group_by(gene_id) %>%
    filter(mean(tpm >  0) >= 0.50) %>%
    ungroup() %>%
    spread(subject, tpm) %>%
    left_join(gene_annots, by = "gene_id") %>%
    mutate(gid = gene_id) %>%
    select(`#chr` = chr, start, end, id = gene_id, gid, strd, 
	   starts_with("HG"), starts_with("NA")) %>%
    arrange(`#chr`, start)

write_tsv(gene_bed, "phenotypes.bed")
system("bgzip phenotypes.bed && tabix -p bed phenotypes.bed.gz")

