library(tidyverse)

snp_pos <- read_tsv("./snp_positions.tsv", col_names = FALSE) %>%
    select(-X3) %>%
    group_by(X1) %>%
    filter(X2 == min(X2) | X2 == max(X2)) %>%
    mutate(i = seq_len(n())) %>%
    ungroup() %>%
    spread(i, X2) %>%
    unite(coord, `1`:`2`, sep = "-") %>%
    unite(region, X1:coord, sep = ":")

writeLines(snp_pos$region, "./regions.txt")
