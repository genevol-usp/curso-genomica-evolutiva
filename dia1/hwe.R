library(tidyverse)

vcf <- read_tsv("./data/chr21.yri.filtered.vcf.gz", comment = "##")

vcfl <- vcf %>%
    rowid_to_column("i") %>%
    select(-`#CHROM`, -(ID:FORMAT)) %>%
    gather(subject, genotype, -i, -POS)

N <- n_distinct(vcfl$subject)

geno_counts <- vcfl %>%
    mutate(g = recode(genotype, "0|0" = "oHOM1", "0|1" = "oHET", "1|0" = "oHET", "1|1" = "oHOM2")) %>%
    count(i, POS, g) %>%
    complete(g, nesting(i, POS), fill = list(n = 0L)) %>%
    spread(g, n) 

obs_exp <- geno_counts %>%
    mutate(f0 = pmap_dbl(list(oHOM1, oHET), ~(.x*2L + .y)/(N*2)),
	   f1 = 1 - f0,
	   eHOM1 = f0^2 * N,
	   eHET = 2*f0*f1 * N,
	   eHOM2 = f1^2 * N) %>%
    select(POS, oHOM1, oHET, oHOM2, eHOM1, eHET, eHOM2)

chisq_df <- obs_exp %>%
    mutate(X = ((oHOM1 - eHOM1)^2 / eHOM1) + ((oHET - eHET)^2 / eHET) + ((oHOM2 - eHOM2)^2 / eHOM2),
	   p = pchisq(X, df = 1, lower.tail = FALSE))

