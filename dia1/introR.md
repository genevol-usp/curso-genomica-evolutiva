Introdução a R
================

Por que?
========

Por que programar?
------------------

-   Reprodutibilidade e comunicação
-   Colaboração
-   Automação
-   Permite pensar mais sobre sua análise
-   Permite análises customizadas

Por que R?
----------

-   Código aberto
-   Grátis
-   Comunidade grande
-   Milhares de pacotes
    -   modelagem estatística
    -   visualização
    -   manipulação de dados
    -   biologia!
-   Análise exploratória interativa
-   Acessível a usuário iniciantes

Desvantagens: pode ser lento e consumir muita memória

Demo: Rstudio
=============

Demo: environment e assignment
==============================

``` r
ls()

# assignment:
x <- 10

ls()

rm(x)

ls()
```

Estruturas de dados
===================

------------------------------------------------------------------------

| dimensão | homogêneo | heterogêneo |
|:--------:|:---------:|:-----------:|
|    1d    |   vetor   |    lista    |
|    2d    |   matriz  |  data frame |

**funções contrutoras:**

-   c()
-   list()
-   matrix()
-   data.frame()

Tipos
-----

-   integer
-   numeric
-   character
-   logical

Valores especiais
-----------------

-   NULL
-   NA
-   NaN
-   Inf
-   TRUE and FALSE

Demo
====

``` r
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
```

demo: subsetting
================

``` r
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

Operadores e funções
====================

Operadores
----------

``` r
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
```

Funções
-------

``` r
fun <- function(x) {
    do_something
}
```

Funções comuns incluídas no R
-----------------------------

|        |         |        |
|:------:|:-------:|:------:|
|   sum  |   str   |  rnorm |
|   log  | summary | rbinom |
|   exp  |    lm   |  runif |
|  mean  |  table  |  rbeta |
| median |   head  | rgamma |
|   var  |   tail  | sample |
|   sd   |   dim   |   rep  |
|  sqrt  |  subset |        |

Obtendo ajuda
-------------

``` r
help(mean)

?mean

?"["

??"principal component"

apropos("mean")

help(package = "dplyr")
```

Ajuda na internet internet
--------------------------

-   Google
-   [stackoverflow](http://stackoverflow.com/questions/tagged/r)

apply
-----

-   apply
-   lapply
-   sapply
-   tapply

``` r
sapply(iris[1:4], mean)
```

Estruturas de controle de fluxo
-------------------------------

-   for
-   while

``` r
for (i in N) {
    do something
}
```

-   if
-   else

``` r
x <- 10
if (x > 0) {
    y <- 1
} else {
    y <- 0
}
```

Vetorização
-----------

``` r
(1:10) ^ 2
1:10 * c(2, 3)
```

Ler e salvar dados
==================

|     LER    |    SALVAR   |
|:----------:|:-----------:|
| read.table | write.table |
|  read.csv  |  write.csv  |
|  read.csv2 |  write.csv2 |
|  readLines |  writeLines |

Gráficos
========

-   plot
-   barplot
-   boxplot
-   hist
-   lines
-   points

``` r
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
```

Pacotes
=======

[CRAN](https://cran.r-project.org/)

``` r
install.packages("PackageName")
library("PackageName")
```

[Bioconductor](https://www.bioconductor.org)

``` r
install.packages("BiocManager")
BiocManager::install("PackageName")
library("PackageName")
```

Boas práticas
-------------

-   Use ferramentas já disponíveis quando possível
    -   história mais longa
    -   audiência maior
-   Não salve seu histórico nem seu environment
    -   rode de novo a análise usando script e dados
-   Use um sistema de controle de versão (git)
