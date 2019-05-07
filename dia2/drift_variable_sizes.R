# vector of pop sizes
sizes <- sample(1:100, 100)

ngens <- 100

p <- numeric()
p[1] <- 0.5

for(i in 2:ngens) {
    p[i] <- p[i - 1] * (1 - (1/(sizes[i - 1])))
}

plot(p, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "frequency", 
     main = "allele frequency change")

ne <- (sum(sizes^-1) / length(sizes)) ^-1
H_t <- p[1] * (1 - (1/ne))^(1:ngens)

lines(H_t, col = "red", lty = 2)
