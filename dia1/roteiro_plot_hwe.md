Roteiro para gráfico HWE
================

Importar os dados de contagens genotípicas para o R. Lembre que essas contagens foram geradas pelo comando `vcftools --hardy` e parseadas pelo script `parse_genocounts.R`.

``` r
genos <- read.table("./results/chr21.yri.genotypecounts.tsv", header = TRUE)
```

Criar colunas no data.frame `genos` que se referem às frequências do genótipos e dos alelos, a partir das contagens observadas dos genotótipos.

``` r
# total of individuals
total_ind <- genos$ref_ref + genos$ref_alt + genos$alt_alt

# REF allele frequencies
genos$f_ref <- (genos$ref_ref + genos$ref_alt/2) / total_ind
genos$f_alt <- 1 - genos$f_ref

#genotype frequencies
genos$f_ref_ref <- genos$ref_ref / total_ind
genos$f_ref_alt <- genos$ref_alt / total_ind
genos$f_alt_alt <- genos$alt_alt / total_ind
```

Fazer gráfico das frequências do alelo REF x frequência do genótipo REF-REF

``` r
plot(genos$f_ref, genos$f_ref_ref, col = "green", cex = .25, 
     xlab = "frequência do alelo ref", ylab = "frequência do genótipo")
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-3-1.png)

Então adicionamos os pontos para frequências do genótipo ALT-ALT. Adicionamos pontos a um gráfico já existente com a função `points`.

``` r
points(genos$f_ref, genos$f_alt_alt, col = "pink", cex = .25)
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-5-1.png)

E então os pontos para as frequências do genótipo REF-ALT

``` r
points(genos$f_ref, genos$f_ref_alt, col = "lightblue", cex = .25)
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-7-1.png)

Finalmente, vamos adicionar as linhas teóricas, ou seja, correspondendo às frequências genotípicas esperadas por HWE.

Primeiro vamos usar a função `seq` para criar um vetor de frequências para um alelo hipotético. Essas frequências vão variar de 0 a 1 em passos de 0.01.

``` r
f <- seq(0, 1, 0.01)
```

Adicionamos linhas com a função `lines`. Para os homozigotos REF:

``` r
lines(f, f^2, col = "darkgreen")
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-10-1.png)

Para os homozigotos ALT:

``` r
lines(f, (1-f)^2, col = "red")
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-12-1.png)

Para os heterozigotos:

``` r
lines(f, 2 * f * (1-f), col = "blue")
```

![](roteiro_plot_hwe_files/figure-markdown_github/unnamed-chunk-14-1.png)

Desafio:
========

O gráfico acima mostra o padrão de desvios de HWE ao longo de todo o cromossomo 21. Lembre que durante a aula, quando olhamos para o p-valor do teste de HWE ao longo desse cromossomo, vimos um padrão diferente para o braço curto e o braço longo do cromossomo.

1.  Crie 2 versões do data.frame `genos` acima, uma para o braço curto e outra para o braço longo.
2.  Replique o gráfico acima para cada braço do cromossomo.
3.  Salve os gráficos com o comando `png`:

``` r
png("nome_do_arquivo.png", width = 12, height = 8, units = "cm", res = 300)
CODIGO DO GRAFICO AQUI
dev.off()
```

Como o padrão observado aqui para cada braço do cromossomo se relaciona ao [gráfico de p-valores visto antes](https://github.com/genevol-usp/curso-genomica-evolutiva/tree/master/dia1#há-desvios-de-hw-no-cromossomo-21)?
