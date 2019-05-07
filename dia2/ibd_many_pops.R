# Pop size
N <- 30

# Number of generations
ngens <- 200

# Number of populations
npops <- 20

# Create a matrix to store results.
# Each row will be a generation and each column, a population.

IBD <- matrix(nrow = ngens, ncol = npops) 

for(i in 1:npops) {
  
  pop <- seq(1:(2*N))

  IBD[1, i] <- sum((table(pop)/(2*N))^2)
  
  for(j in 2:ngens) {
    pop <- sample(pop, replace = TRUE)
    IBD[j, i]  <- sum((table(pop)/(2*N))^2)
  }
}

# Population trajectories
plot(NA, type = "n", xlim = c(1, ngens), ylim = c(0, 1), 
     xlab = "generations", ylab = "ibd prob")

for (i in 1:npops)
  lines(IBD[, i], col = rainbow(npops)[i])

# plot the mean ibd across generations (rows)
lines(rowMeans(IBD), lwd = 3)

##### Theoretical line for timecourse of IBD

# Ft = 1 - ( 1 - 1/2N)^t

ibd.th <- numeric(ngens)
for(t in 1:ngens)
ibd.th[t] <- 1 - ( 1- 1/(2*N))^t
lines(ibd.th, lty=3, lwd=3)