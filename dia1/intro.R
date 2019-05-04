# Demo: environment e assignment

ls()

# assignment:
x <- 10

ls()

rm(x)

ls()

# Demo estrutura de dados
# 1D

## homogeneous: atomic vector
vec <- 10
vec
class(vec)

vec <- 1:10
vec
class(vec)
typeof(vec)

vec <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
vec
typeof(vec)

vec <- c("a", "c", "t", "g")
vec
typeof(vec)

## factor
fac <- factor(c("a", "c", "t", "g"))
fac
typeof(fac)
class(fac)

## heterogeneous: lists
lis <- list(a = 1:10, 
          b = c("a", "t", "c", "g"), 
          c = data.frame(var1 = 1:3, var2 = c("a", "b", "c")))

lis

# 2D

## matrix

mat <- matrix(c("a", "b", 1, 2), nrow = 2)
mat

## data frame

dat <- data.frame(letter = c("a", "b", "c"), number = 1:3)
dat

# attributes

length(vec)
length(lis)
dim(mat)
dim(dat)

names(vec)
names(vec) <- c("nt1", "nt2", "nt3", "nt4")
vec

# demo: subsetting

vec
vec[1]
vec[c(1, 4)]
vec[-1]
vec[c(TRUE, FALSE, TRUE, FALSE)]
vec[vec > "c"]

vec["nt3"]

lis

lis[1]
lis["a"]
lis[[1]]

lis[[1]][[1]]

lis$a

dat

dat$letter

dat
dat[2, 1:2]
dat[[2]]
```

# Operadores e funções

## Operadores

```{r eval=FALSE}
x + y
x - y 
x * y
x / y
x ^ y
x == y
x != y  
x > y
x < y
x >= y
x <= y
x | y
x & y
x %in% y

?Syntax  

## Obtendo ajuda

help(mean)

?mean

?"["

??"principal component"

apropos("mean")

help(package = "dplyr")

## apply

sapply(iris[1:4], mean)

## Vetorização

(1:10) ^ 2
1:10 * c(2, 3)


# Gráficos

plot(iris$Sepal.Length, iris$Petal.Length)

# Add lines and legend
model <- lm(Petal.Length~Sepal.Length, data = iris)

plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 19, 
     xlab = "Sepal Length", ylab = "Petal Length")
lines(iris$Sepal.Length, fitted(model), col = "blue")
legend(7, 4, unique(iris$Species), col = 1:length(iris$Species), pch = 19)

# Save plot
png("./irisplot.png", height = 10, width = 15, units = "cm", res = 150)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species, pch = 19, 
     xlab = "Sepal Length", ylab = "Petal Length")
lines(iris$Sepal.Length, fitted(model), col = "blue")
legend(7, 4, unique(iris$Species), col = 1:length(iris$Species), pch = 19)
dev.off()

