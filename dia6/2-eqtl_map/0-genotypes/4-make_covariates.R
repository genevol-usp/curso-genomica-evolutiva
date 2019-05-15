library(tidyverse)

pcs <- read_delim("./genos.pca", n_max = 3, delim = " ") %>%
    mutate(SampleID  = sub("^.+(PC\\d+)$", "\\1", SampleID)) %>%
    rename(id = SampleID)

write_tsv(pcs, "./covariates_genos.txt")
