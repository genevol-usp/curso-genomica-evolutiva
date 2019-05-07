# Genetic Drift

# Number of generations
ngens <- 2000

# Number of individuals:
N <- 1000

# Population of individuals '0' or '1':
pop <- rep(0:1, each = N/2)

#vector with the frequencies of allele 0 in 2000 generations 
freqs <- numeric(ngens)

# 1st element of vector 'p' will be the allele frequency in parent generation:
freqs[1] <- mean(pop == 0)

# Now we have to calculate the allele frequencies in the next generations.
# Let's use a 'for loop' to calculate the frequency in each generation and
# save the result as an element of vector 'p':
for(i in 2:ngens) {
    
    # the next generation is a random sample of the parental population:
    pop <- sample(pop, replace = TRUE)
    
    # allele frequency in the ith generation:
    freqs[i] <- mean(pop == 0)
}

# Plot
plot(freqs, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "frequency", 
     main = "allele frequency change")