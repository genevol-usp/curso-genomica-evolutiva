Introdução a R
================
Vitor Aguiar
May 6, 2019

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
-   Acessível a usuário iniciantes e avançados

Desvantagens: pode ser lento e consumir muita memória

demo: Rstudio
=============

Demo: environment and assignment
================================

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

| dimensão |   homogêneo   | heterogêneo |
|:--------:|:-------------:|:-----------:|
|    1d    | atomic vector |     List    |
|    2d    |     matrix    |  data frame |

**funções contrutoras:**

-   c()
-   vector()
-   list()
-   matrix()
-   data.frame()
-   array()
-   factor()

Tipos
-----

-   integer
-   numeric
-   character
-   logical
-   complex
-   raw

Valores especiais
-----------------

-   NULL
-   NA
-   NaN
-   Inf
-   TRUE and FALSE

demo
====

``` r
# 1D

## homogeneous: atomic vector
v <- 10
v
class(v)

v <- 1:100
v
class(v)

typeof(v)

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
v
is.integer(v)
typeof(v)

v <- c("a", "c", "t", "g")
v
typeof(v)

## factor
f <- factor(c("a", "b", "b", "a", "b", "a", "b", "a"))
f
typeof(f)
class(f)

## heterogeneous: lists

l <- list(a = 1:10, 
          b = c("a", "t", "c", "g"), 
          c = data.frame(var1 = 1:3, var2 = c("a", "b", "c")))

l
typeof(l)

# 2D

## matrix

m <- matrix(c("a", "b", 1, 2), nrow = 2)
m
typeof(m)

## data frame

df <- data.frame(letter = c("a", "b", "c"), number = 1:3)
df
typeof(df)

list(letter = c("a", "b", "c"), number = 1:3)
as.data.frame(list(letter = c("a", "b", "c"), number = 1:3))

# attributes

length(v)
length(l)
dim(m)
dim(df)
dim(a)

names(v)
names(v) <- c("nt1", "nt2", "nt3", "nt4")
v
names(v)

rownames(m) <- c("ind1", "ind2")
colnames(m) <- c("letter", "number")
#or:
dimnames(m) <- list(c("ind1", "ind2"), c("letter", "number"))

# str()
str(v)
str(df)

summary(df)
```

demo: subsetting
================

``` r
v
v[1]
v[c(1, 4)]
v[-1]
v[c(TRUE, FALSE, TRUE, FALSE)]
v[v > "c"]

names(v) <- c("nt1", "nt2", "nt3", "nt4")
v["nt3"]

l

l[1]
l["a"]
class(l[1])
l[[1]]
class(l[[1]])

l[[3]][[1]]

l$a

df

df$letter

m
m[1, 1]
m[2, 1:2]
m[, 1]
m[-1, ]

df
df[2, 1:2]
df[[2]]
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
x %% y
x %/% y
x %*% y
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
fun <- function(x) do_something
```

Funções comuns incluídas no R
-----------------------------

|          |           |          |
|:--------:|:---------:|:--------:|
|   sum()  |   str()   |  rnorm() |
|   log()  | summary() | rbinom() |
|   exp()  |    lm()   |  runif() |
|  mean()  |  table()  |  rbeta() |
| median() |   head()  | rgamma() |
|   var()  |   tail()  | sample() |
|   sd()   |   dim()   |   rep()  |
|  sqrt()  |  subset() |          |

Obtendo ajuda
-------------

``` r
help(mean)

?mean

?"["

??"principal component"

apropos("mean")

help(package="dplyr")
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
-   mapply

``` r
sapply(iris[1:4], mean)
```

Estruturas de controle de fluxo
-------------------------------

-   for
-   while

``` r
for (iterator in times) do something
```

-   if
-   else

``` r
x <- 10
if (x > 0) y <- 1 else y <- 0
y
```

-   next
-   stop

Vetorização
-----------

``` r
(1:10) ^ 2
1:10 * c(2, 3)
```

Ler e salvar dados
==================

|     READ     |     WRITE     |
|:------------:|:-------------:|
| read.table() | write.table() |
|  read.csv()  |  write.csv()  |
|  read.csv2() |  write.csv2() |
|  readLines() |  writeLines() |

Graficos
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
legend(7, 3, unique(iris$Species), col = 1:length(iris$Species), pch = 19)
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
