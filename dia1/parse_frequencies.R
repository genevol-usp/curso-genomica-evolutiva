library(tidyverse)

freq <- read_tsv("./results/chr21.yri.frq", skip = 1,
                 col_names = c("chr", "pos", "n_alleles", "n_chr", "f_ref_allele", "f_alt")) %>%
    select(pos, f_ref_allele) %>%
    mutate(f_ref_allele = sub("^[A-Z]+:", "", f_ref_allele),
           f_ref_allele = as.numeric(f_ref_allele))

freqs_df <- read_tsv("./results/chr21.yri.hwe") %>%
    select(pos = POS, obs = 3) %>%
    separate(obs, c("ref_ref", "ref_alt", "alt_alt"), sep = "/", convert = TRUE) %>%
    mutate(n = pmap_int(list(ref_ref, ref_alt, alt_alt), sum)) %>%
    mutate_at(vars(ref_ref:alt_alt), ~./n) %>%
    left_join(freq, by = "pos") %>%
    select(pos, f_ref_allele, ref_ref:alt_alt) %>% 
    mutate_at(vars(f_ref_allele:alt_alt), ~round(., 3))

write_tsv(freqs_df, "./results/chr21.yri.frequencies.tsv")
