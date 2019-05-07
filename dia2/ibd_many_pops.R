# Pop size
N <- 30

# Number of generations
ngens <- 200

# Number of populations
npops <- 20

# Create a matrix to store results.
# Each row will be a generation and each column, a population.

P <- matrix(nrow = ngens, ncol = npops) 

for(i in 1:npops) {
  
  pop <- seq(1:(2*N))

  P[1, i] <- sum((table(pop)/(2*N))^2)
  
  for(j in 2:ngens) {
    pop <- sample(pop, replace = TRUE)
    P[j, i]  <- sum((table(pop)/(2*N))^2)
  }
}

# Population trajectories
plot(NA, type = "n", xlim = c(1, ngens), ylim = c(0, 1), 
     xlab = "generations", ylab = "ibd prob")

for (i in 1:npops)
  lines(P[, i], col = rainbow(npops)[i])

# plot the mean ibd across generations (rows)
lines(rowMeans(P), lwd=3)

##### Theoretical line for timecourse of IBD

# Ft = 1 - ( 1 - 1/2N)^t

for(t in 1: ngens)
ibd.theoretical[t] <- 1 - ( 1- 1/(2*N))^t
lines(ibd.theoretical, lty=3, lwd=4)


