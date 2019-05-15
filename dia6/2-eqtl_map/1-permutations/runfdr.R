suppressMessages(library(tidyverse))
library(qvalue)

args <- commandArgs(TRUE)
opt_input <- args[1]
opt_fdr <- as.numeric(args[2])
opt_output <- args[3]

datin <- 
    suppressMessages(read_delim(opt_input, col_names = FALSE, delim = " ", progress = FALSE))

datna <- filter(datin, is.na(X18))

dat <- datin %>%
    filter(!is.na(X18)) %>%
    mutate(qval = qvalue(X19)$qvalue)

set0 <- filter(dat, qval <= opt_fdr) 
set1 <- filter(dat, qval > opt_fdr) 
pthreshold <- (sort(set1$X19)[1] - sort(-1.0 * set0$X19)[1]) / 2

pval0 <- qbeta(pthreshold, dat$X14, dat$X15, ncp = 0, lower.tail = TRUE, log.p = FALSE)
test0 <- qf(pval0, 1, dat$X13, ncp = 0, lower.tail = FALSE, log.p = FALSE)
corr0 <- sqrt(test0 / (dat$X13 + test0))
test1 <- dat$X12 * corr0 * corr0 / (1 - corr0 * corr0)
pval1 <- pf(test1, 1, dat$X12, ncp = 0, lower.tail = FALSE, log.p = FALSE)
dat$nthresholds <- pval1

dat %>%
    filter(qval <= opt_fdr) %>%
    write_delim(paste0(opt_output, ".significant.txt"), delim = " ", col_names = FALSE)

select(dat, X1, nthresholds) %>%
    bind_rows(select(datna, X1, nthresholds = X18)) %>%
    write_delim(paste0(opt_output, ".thresholds.txt"), delim = " ", col_names = FALSE)
