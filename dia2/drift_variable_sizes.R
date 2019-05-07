# Genetic Drift with variable population size

# Number of generations
ngens <- 2000

# Number of individuals:
N <- sample(10:1000, ngens, replace = TRUE)

# Population of individuals '0' or '1':
pop <- rep(0:1, each = N[1]/2)

# Vector with the frequencies of allele 0 through the 'ngens' generations 
freqs <- numeric(ngens)

# 1st element of vector will be the allele frequency in parent generation 'pop':
freqs[1] <- mean(pop == 0)

# vector of heterozigosities through the 'ngens' generations
het <- numeric(ngens)
het[1] <- mean(pop == 0)

for(i in 2:ngens) {
    
    # the next generation is a random sample of the parental population:
    pop <- sample(pop, size = N[i], replace = TRUE)
    
    # allele frequency in the ith generation:
    freqs[i] <- mean(pop == 0)
    
    # heterozigosity in the ith generation
    het[i] <- het[i - 1] * (1 - (1/(N[i - 1])))
}

plot(freqs, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "frequency", 
     main = "allele frequency change")

plot(het, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "H", 
     main = "Heterozigosity change")

# Ne
ne <- (sum(N^-1) / length(N)) ^-1

# Theoretical H change
H_t <- het[1] * (1 - (1/ne))^(1:ngens)

# add theoretical line to the plot of H
lines(H_t, col = "red", lty = 2)
