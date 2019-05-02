Prática R
================
Kelly Nunes
02/05/2019

## Preparação para a Prática

# Apresentação ao R e RStudio

As análises de dados da nossa aula prática será realizada em R utlizando
o a interface do RStudio.

  - R: Linguagem e ambiente com ferramentas estatísticas que permite a
    realização de diversas análises.
  - R-Studio: Interface gráfica que facilita o trabalho com o R.

# Vamos explorar um pouco o R\!

  - O R como calculadora

<!-- end list -->

``` r
2+2
```

    ## [1] 4

``` r
6-7
```

    ## [1] -1

``` r
4/3
```

    ## [1] 1.333333

``` r
5*5
```

    ## [1] 25

  - O R para operações de lógica

<!-- end list -->

``` r
10>2
```

    ## [1] TRUE

``` r
(3*2)==5
```

    ## [1] FALSE

  - O R para guardar pequenas informações de texto (strings)

<!-- end list -->

``` r
"R e dados genômicos em larga escala"
```

    ## [1] "R e dados genômicos em larga escala"

  - O R guarda informações em variáveis

<!-- end list -->

``` r
a<-100 # variável
a
```

    ## [1] 100

``` r
a*8
```

    ## [1] 800

``` r
b<-a*8

a<- 20 # o R sobreescreve uma variável sem informar que ela já exite. TOME CUIDADO!!!
a
```

    ## [1] 20

``` r
b # modificou apenas o objeto a e em princípio não o b
```

    ## [1] 800

``` r
b<-a*8
b
```

    ## [1] 160

  - R e pequenos códigos pré-estabelecidos (funções)

<!-- end list -->

``` r
2+2
```

    ## [1] 4

``` r
sum(2+2)
```

    ## [1] 4

``` r
(1+2+3+4+5+6)/6
```

    ## [1] 3.5

``` r
mean(1:6)
```

    ## [1] 3.5

``` r
log(10)
```

    ## [1] 2.302585

``` r
log10(100)
```

    ## [1] 2

  - R e os pacotes (conjuto de várias funções)

<!-- end list -->

``` r
install.packages("genetics", contriburl = contrib.url("CRAN"))
```

    ## Warning: unable to access index for repository CRAN/src/contrib:
    ##   cannot open URL 'CRAN/src/contrib/PACKAGES'

    ## Warning: package 'genetics' is not available (as a binary package for R
    ## version 3.5.3)

  - R e gráficos

<!-- end list -->

``` r
dist<-runif (1000)

hist(dist)
```

![](Review_R_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

# Prática. Organização e análise de dados

1.  Crie um novo diretório para guardar os exercícios. Em seguida mude
    seu diretorio de trabalho em R para lá.

<!-- end list -->

``` r
getwd()
```

    ## [1] "/Users/Kelly/Documents/Class/Genomica_Evolutiva/2019/Pre_Curso"

``` r
setwd("/Users/Caminho_para_o_diretorio_criado")
```

2.  Crie o seguinte data frame e estime a média, mediana, sd, da coluna
    idade.

<!-- end list -->

``` r
#seq  id idade genero
#   1 A01    20      f
#   2 A02    22      m
#   3 A03    25      f
#   4 A04    26      m
#   5 A05    29      m
```

``` r
dataset<-data.frame(cbind(seq=1:5, id=c("A01", "A02", "A03", "A04", "A05"), idade=c(20,22,25,26,29), genero=c("f", "m", "f", "m", "m")))
dataset
```

    ##   seq  id idade genero
    ## 1   1 A01    20      f
    ## 2   2 A02    22      m
    ## 3   3 A03    25      f
    ## 4   4 A04    26      m
    ## 5   5 A05    29      m

``` r
mean(dataset$idade)
```

    ## Warning in mean.default(dataset$idade): argument is not numeric or logical:
    ## returning NA

    ## [1] NA

``` r
str(dataset)
```

    ## 'data.frame':    5 obs. of  4 variables:
    ##  $ seq   : Factor w/ 5 levels "1","2","3","4",..: 1 2 3 4 5
    ##  $ id    : Factor w/ 5 levels "A01","A02","A03",..: 1 2 3 4 5
    ##  $ idade : Factor w/ 5 levels "20","22","25",..: 1 2 3 4 5
    ##  $ genero: Factor w/ 2 levels "f","m": 1 2 1 2 2

``` r
mean(as.numeric(dataset$idade))
```

    ## [1] 3

``` r
median(as.numeric(dataset$idade))
```

    ## [1] 3

``` r
sd(as.numeric(dataset$idade))
```

    ## [1] 1.581139

3.  Leia o arquivo “example\_table.txt” no R

<!-- end list -->

``` r
table<-read.table("./example_table.txt", header=F) # ler o arquivo em forma de tabela

head(table) # mostra na tela as primeiras linhas
```

    ##     V1 V2 V3 V4 V5     V6 V7        V8
    ## 1 FA01 CC GG CC AA Female 27 Caucasian
    ## 2 FA02 CT GA TC GA   Male 36 Caucasian
    ## 3 FA03 CT GA TC GA Female 24 Caucasian
    ## 4 FA04 CT GA TC GA Female 40 Caucasian
    ## 5 FA05 CC GG CC AA Female 32 Caucasian
    ## 6 FA06 CT GA TC GA Female 24  Hispanic

``` r
tail(table) # mostra na tela as linhas finais
```

    ##      V1   V2   V3   V4   V5     V6 V7        V8
    ## 15 FA15 <NA> <NA> <NA> <NA>   <NA> NA      <NA>
    ## 16 FA16   TT   GA   TC   GA Female 24 Caucasian
    ## 17 FA17   CT   GA   TC   GA   <NA> NA      <NA>
    ## 18 FA18   CT   GA   TC   GA   <NA> NA      <NA>
    ## 19 FA19   CT   GG   CC   AA   Male 34 Caucasian
    ## 20 FA20   CC   GA   TC   GA Female 31 Caucasian

4.  Quantas linhas e colunas o arquivo “example\_table.txt” possui?

<!-- end list -->

``` r
nrow(table)
```

    ## [1] 20

``` r
ncol(table)
```

    ## [1] 8

5.  Renomeie as colunas do arquivo “example\_table.txt” para ID, L1, L2,
    L3, Genero, Idade e Etnia respectivamente

<!-- end list -->

``` r
colnames(table)<- c("ID", "L1", "L2", "L3", "L4", "Genero", "Idade", "Etnia") # nomear as colunas

head(table)
```

    ##     ID L1 L2 L3 L4 Genero Idade     Etnia
    ## 1 FA01 CC GG CC AA Female    27 Caucasian
    ## 2 FA02 CT GA TC GA   Male    36 Caucasian
    ## 3 FA03 CT GA TC GA Female    24 Caucasian
    ## 4 FA04 CT GA TC GA Female    40 Caucasian
    ## 5 FA05 CC GG CC AA Female    32 Caucasian
    ## 6 FA06 CT GA TC GA Female    24  Hispanic

6.  Qual a média, mediana, maior e menor idade dos indivíduos dessa
    tabela?

<!-- end list -->

``` r
mean(table$Idade)
```

    ## [1] NA

``` r
mean(table$Idade, na.rm=T)
```

    ## [1] 28.66667

``` r
median(table$Idade, na.rm=T)
```

    ## [1] 28

``` r
min(table$Idade, na.rm=T)
```

    ## [1] 20

``` r
max(table$Idade, na.rm=T)
```

    ## [1] 40

``` r
# Outra opção
summary(table$Idade)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##   20.00   24.00   28.00   28.67   31.50   40.00       5

7.  Estimar frequencias alélicas e genotípicas do locus L1

<!-- end list -->

``` r
GenoCount<- summary(table$L1) # contando o número de observações para cada genotipo
GenoCount
```

    ##   CC   CT   TT NA's 
    ##    5   12    2    1

``` r
NumbObs<-sum(!is.na(table$L1)) # contando o total de observações, sem os NA
NumbObs
```

    ## [1] 19

``` r
GenoFreq<- as.vector (GenoCount/NumbObs) # estimando a frequencia genotípica
GenoFreq
```

    ## [1] 0.26315789 0.63157895 0.10526316 0.05263158

``` r
FreqC<-(2*GenoFreq[1] + GenoFreq[2])/2 # frequencia alélica = alelo C
FreqC
```

    ## [1] 0.5789474

``` r
FreqT<- (GenoFreq [2] + 2*GenoFreq[3])/2 # frequencia alélica = alelo G
FreqT
```

    ## [1] 0.4210526

8.  Repita a atividade 7 usando o pacote “genetics”

<!-- end list -->

``` r
library("genetics", lib.loc="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
```

    ## Loading required package: combinat

    ## 
    ## Attaching package: 'combinat'

    ## The following object is masked from 'package:utils':
    ## 
    ##     combn

    ## Loading required package: gdata

    ## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.

    ## 

    ## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.

    ## 
    ## Attaching package: 'gdata'

    ## The following object is masked from 'package:stats':
    ## 
    ##     nobs

    ## The following object is masked from 'package:utils':
    ## 
    ##     object.size

    ## The following object is masked from 'package:base':
    ## 
    ##     startsWith

    ## Loading required package: gtools

    ## Loading required package: MASS

    ## Loading required package: mvtnorm

    ## 

    ## NOTE: THIS PACKAGE IS NOW OBSOLETE.

    ## 

    ##   The R-Genetics project has developed an set of enhanced genetics

    ##   packages to replace 'genetics'. Please visit the project homepage

    ##   at http://rgenetics.org for informtion.

    ## 

    ## 
    ## Attaching package: 'genetics'

    ## The following objects are masked from 'package:base':
    ## 
    ##     %in%, as.factor, order

``` r
Geno<- genotype (table$L1, sep="") # a função genotype dá direto as freq alelicas e genotipicas
summary(Geno) # visualizar a análise
```

    ## 
    ## Number of samples typed: 19 (95%)
    ## 
    ## Allele Frequency: (2 alleles)
    ##    Count Proportion
    ## C     22       0.58
    ## T     16       0.42
    ## NA     2         NA
    ## 
    ## 
    ## Genotype Frequency:
    ##     Count Proportion
    ## C/C     5       0.26
    ## C/T    12       0.63
    ## T/T     2       0.11
    ## NA      1         NA
    ## 
    ## Heterozygosity (Hu)  = 0.5007112
    ## Poly. Inf. Content   = 0.3686896

9.  Calcule a frequencia alélica e genotipica para cada grupo etnico.

<!-- end list -->

``` r
# Estratificando pela variável etnia
head(table)
```

    ##     ID L1 L2 L3 L4 Genero Idade     Etnia
    ## 1 FA01 CC GG CC AA Female    27 Caucasian
    ## 2 FA02 CT GA TC GA   Male    36 Caucasian
    ## 3 FA03 CT GA TC GA Female    24 Caucasian
    ## 4 FA04 CT GA TC GA Female    40 Caucasian
    ## 5 FA05 CC GG CC AA Female    32 Caucasian
    ## 6 FA06 CT GA TC GA Female    24  Hispanic

``` r
levels(table$Etnia) # ver quantas etnias constam na tabela
```

    ## [1] "African_Am" "Caucasian"  "Hispanic"

``` r
## Caucasian
table_etnia_caucasian<- table[table$Etnia=="Caucasian",]
table_etnia_caucasian
```

    ##        ID   L1   L2   L3   L4 Genero Idade     Etnia
    ## 1    FA01   CC   GG   CC   AA Female    27 Caucasian
    ## 2    FA02   CT   GA   TC   GA   Male    36 Caucasian
    ## 3    FA03   CT   GA   TC   GA Female    24 Caucasian
    ## 4    FA04   CT   GA   TC   GA Female    40 Caucasian
    ## 5    FA05   CC   GG   CC   AA Female    32 Caucasian
    ## 7    FA07   TT   AA   TT   GG Female    30 Caucasian
    ## NA   <NA> <NA> <NA> <NA> <NA>   <NA>    NA      <NA>
    ## 9    FA09   CT   GA   TC   GA Female    28 Caucasian
    ## NA.1 <NA> <NA> <NA> <NA> <NA>   <NA>    NA      <NA>
    ## 12   FA12   CT   GA   TC   GA Female    30 Caucasian
    ## 13   FA13   CT   GA   TC   GA Female    20 Caucasian
    ## NA.2 <NA> <NA> <NA> <NA> <NA>   <NA>    NA      <NA>
    ## 16   FA16   TT   GA   TC   GA Female    24 Caucasian
    ## NA.3 <NA> <NA> <NA> <NA> <NA>   <NA>    NA      <NA>
    ## NA.4 <NA> <NA> <NA> <NA> <NA>   <NA>    NA      <NA>
    ## 19   FA19   CT   GG   CC   AA   Male    34 Caucasian
    ## 20   FA20   CC   GA   TC   GA Female    31 Caucasian

``` r
GenoCount_etnia_caucasian<- summary(table_etnia_caucasian$L1)
GenoCount_etnia_caucasian
```

    ##   CC   CT   TT NA's 
    ##    3    7    2    5

``` r
NumbObs_etnia_caucasian<-sum(!is.na(table_etnia_caucasian$L1))
NumbObs_etnia_caucasian
```

    ## [1] 12

``` r
GenoFreq_etnia_caucasian<- as.vector (GenoCount_etnia_caucasian/NumbObs_etnia_caucasian) # estimando a frequencia genotípica
GenoFreq_etnia_caucasian
```

    ## [1] 0.2500000 0.5833333 0.1666667 0.4166667

``` r
FreqC_etnia_caucasian<-(2*GenoFreq_etnia_caucasian[1] + GenoFreq_etnia_caucasian[2])/2 # frequencia alélica = alelo A
FreqC_etnia_caucasian
```

    ## [1] 0.5416667

``` r
FreqT_etnia_caucasian<- (GenoFreq_etnia_caucasian [2] + 2*GenoFreq_etnia_caucasian[3])/2 # frequencia alélica = alelo G
FreqT_etnia_caucasian
```

    ## [1] 0.4583333

10. Repita a atividade 9 usando o pacote “genetics” \#\# Ou usando o
    pacote “genetics”

<!-- end list -->

``` r
Geno_etnia_caucasian<- genotype(table_etnia_caucasian$L1, sep="")
Geno_etnia_caucasian
```

    ##  [1] "C/C" "C/T" "C/T" "C/T" "C/C" "T/T" NA    "C/T" NA    "C/T" "C/T"
    ## [12] NA    "T/T" NA    NA    "C/T" "C/C"
    ## Alleles: C T

``` r
summary(Geno_etnia_caucasian)
```

    ## 
    ## Number of samples typed: 12 (70.6%)
    ## 
    ## Allele Frequency: (2 alleles)
    ##    Count Proportion
    ## C     13       0.54
    ## T     11       0.46
    ## NA    10         NA
    ## 
    ## 
    ## Genotype Frequency:
    ##     Count Proportion
    ## C/C     3       0.25
    ## C/T     7       0.58
    ## T/T     2       0.17
    ## NA      5         NA
    ## 
    ## Heterozygosity (Hu)  = 0.5181159
    ## Poly. Inf. Content   = 0.3732579

11. Salve o arquivo gerado

<!-- end list -->

``` r
write.table(Geno_etnia_caucasian, "example_table_caucasian.txt", sep="\t", col.names=F,row.names=F, quote=F)
```

12. Contrua um gráfico para cada um dos itens: idade, genero, etnia, L1

<!-- end list -->

``` r
plot(table$Idade) # gráfico de dispersão se os dados forem numéricos
```

![](Review_R_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

``` r
plot(table$Genero)
```

![](Review_R_files/figure-gfm/unnamed-chunk-20-2.png)<!-- -->

``` r
plot(table$Etnia) # gráfico de distribuíção de frequencia se os dados forem caracters
```

![](Review_R_files/figure-gfm/unnamed-chunk-20-3.png)<!-- -->

``` r
plot(table$L1)
```

![](Review_R_files/figure-gfm/unnamed-chunk-20-4.png)<!-- -->

13. Altera a cor dos gráficos

<!-- end list -->

``` r
plot(table$Idade, col= "red", main= "Gráfico de dispersão das idades", xlab="Indivíduos", ylab= "Idade")
```

![](Review_R_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

14. Construa um gráfico mostrando se há variação de idade entre os
    grupos étnicos

<!-- end list -->

``` r
plot(table$Etnia, table$Idade, main="Variação das idades entres os diferentes grupos étnicos", xlab="Grupos étnicos", ylab="Idade")
```

![](Review_R_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->
