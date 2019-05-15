library(tidyverse)

# Rs id merge table
rsmerge <- read_tsv("./RsMergeArch.bcp.gz", col_names = FALSE) %>%
    select(rsHigh = X1, build_id = X3, rsCurrent = X7) %>%
    filter(build_id <= 149) %>%
    mutate_at(vars(rsHigh, rsCurrent), function(x) paste0("rs", x)) %>%
    select(rsHigh, rsCurrent)

# header of climate SNPs table
header <- readLines("./climate.4/clim_headers.txt")

col_names <- grep("^\\d", header, value = TRUE) %>%
    trimws() %>%
    gsub("^\\d+\\s+|\\(|\\)", "", .) %>%
    gsub("\\s", "_", .)

col_names[8:18] <- paste0("bf_", col_names[8:18])
col_names[19:29] <- paste0("trank_", col_names[19:29])

# climate SNPs table
climate <- 
    "./climate.4/bf_environ.new_environ_all.txtallpops2.popfreqs.all.ave.clim.tpval.3" %>%
    read_tsv(col_names = col_names)

climate_tranks <- climate %>%
    select(chr = chromosome, rs_number, starts_with("trank")) %>%
    gather(variable, trank, -chr, -rs_number) %>%
    mutate(variable = sub("^trank_", "", variable)) %>%
    group_by(variable) %>%
    #filter(trank <= quantile(trank, 0.005)) %>%
    top_n(-5, trank) %>%
    ungroup()

snp_catalog <- climate_tranks %>%
    group_by(chr, rs_number) %>%
    summarise(variable = paste(variable, collapse = "|")) %>%
    ungroup() %>%
    left_join(rsmerge, by = c("rs_number" = "rsHigh")) %>%
    mutate(rs_number = ifelse(is.na(rsCurrent), rs_number, rsCurrent)) %>%
    select(chr, rs_number, variable)

write_tsv(snp_catalog, "snp_climate.tsv", col_names = TRUE)
#
#dir.create("catalog")
#
#snp_catalog %>%
#    left_join(snp_pos, by = c("chr", "rs_number")) %>%
#    filter(!is.na(pos)) %>%
#    mutate(start = pos - 1L, 
#	   out = sprintf("./catalog/climate_snps_chr%d.tsv", chr)) %>%
#    group_split(chr) %>%
#    walk(~write_tsv(select(., rs_number, variable), unique(.$out), col_names = FALSE))
