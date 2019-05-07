# Genetic Drift

# Number of individuals:
N <- 10

# Number of generations
ngens <- 20

# Population of individuals 
pop <- seq(1:(2*N))

#vector with the ibd in ngens generations 
ibd <- numeric(ngens)

# 1st element of vector will be the IBD prob in parent generation:
ibd[1] <- sum((table(pop)/(2*N))^2)

# Now we have to calculate the allele frequencies in the next generations.
# Let's use a 'for loop' to calculate the frequency in each generation and
# save the result as an element of vector 'ibd':
for(i in 2:ngens) {
  
  # the next generation is a random sample of the parental population:
  pop <- sample(pop, replace = TRUE)
  
  # ibd in the ith generation:
  ibd[i] <- sum((table(pop)/(2*N))^2)
}

# Plot
plot(ibd, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "F_ibd")
