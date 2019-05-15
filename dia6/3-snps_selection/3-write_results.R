devtools::load_all("/home/vitor/Libraries/hlaseqlib")
library(tidyverse)

annots <- "../2-eqtl_map/0-phenotypes/gencode.v25.annotation.gtf" %>%
    get_gencode_coords() %>%
    select(gene_name, gene_id)

catalog <- sprintf("./catalog/climate_snps_chr%d.tsv", 1:22) %>%
    map_df(~read_tsv(., col_names = c("var_id", "variable")))

rtc <- sprintf("./rtc_results_chr%d.txt", 1:22) %>%
    map_df(read_qtltools_rtc) %>%
    filter(rtc > .95) %>%
    select(gene, qtl_rank, qtl_var, climate_var = gwas_var, r_squared, rtc)

qtls_rtc <- left_join(rtc, catalog, by = c("climate_var" = "var_id")) %>%
    left_join(annots, by = c("gene" = "gene_id")) %>%
    select(gene, gene_name, everything())

write_tsv(qtls_rtc, "./results.tsv")
