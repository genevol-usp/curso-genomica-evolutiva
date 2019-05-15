library(tidyverse)

pcs <- seq(0, 100, 10)

egenes_df <-
    sprintf("./results/permutations_%d.significant.txt", pcs) %>%
    setNames(pcs) %>%
    map_df(~read_delim(., col_names = FALSE, delim = " "), .id = "pc") %>%
    count(pc, sort = TRUE)

