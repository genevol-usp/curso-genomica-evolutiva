# Genetic Drift with variable population size

# Number of generations
ngens <- 2000

# Number of individuals:
N <- sample(10:1000, ngens, replace = TRUE)

# Um único gargalo populacional. Explore outros valores de gargalo, e tente também fazer gargalos seriados.
N <- c(rep(10000,490), rep(50,20), rep(10000,490))


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
    
    
    
######### 
# Nesse trecho do código, nós usamos as fórmulas vistas em aula para documentar
# como esperamos que seja a perda de diversidade genética nessa popuplação com N variável.
    
# Essa porção do código calcula como H vai mudando, sempre atualizando o N para os valores especificados lá no início.
het[i] <- het[i - 1] * (1 - (1/(N[i - 1])))
}

plot(het, type = "l", ylim = c(0, 1),
     xlab = "generations", ylab = "H", 
     main = "Heterozigosity change")

