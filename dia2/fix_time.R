# How long til fixation of a mutant at 1/2N

dat <- seq(1:100)
t <- 1

while ( var(dat) != 0) {
  dat <- sample(dat, replace=TRUE)
  t = t+1
  }
print(t)



# Agore repetindo 100 vezes e armazenando
fix <- numeric()

for(i in 1:100) {
  
  dat <- seq(1:100)
  t <- 1
  
  while ( var(dat) != 0) {
    dat <- sample(dat, replace=TRUE)
    t = t+1
  }
  fix[i] <- t
}

hist(fix); abline(v=mean(fix), lwd=4); abline(v=2*length(dat), col="red", lwd=3)
