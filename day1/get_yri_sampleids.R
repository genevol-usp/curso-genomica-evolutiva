library(tidyverse)

samples_phase3 <- 
    "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel" %>%
    read_tsv(skip = 1, col_names = FALSE) %>%
    select(subject = X1, pop = X2)

yri <- samples_phase3 %>%
    filter(pop == "YRI")

writeLines(yri$subject, "./data/yri_sample_ids.txt")
