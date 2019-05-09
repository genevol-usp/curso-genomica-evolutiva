Seleção Natural
================
Kelly Nunes
5/9/2019

## Métodos para Detecção de Seleção Natural

# Descrição do Dataset

Os dados que usaremos na aula prática de hoje são oriundos do Projeto
1000 Genomas fase III e podem ser acessado a partir dos seguintes links:

<ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/>

<http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/README_vcf_info_annotation.20141104>

# Pré-processamento dos dados

  - Para otimizar nosso tempo, analisaremos um conjunto de dados
    pré-processados para o cromossomo 2 correspondente a indivíduos
    amostrados das populações AFR (504 indivíduos), EUR (503 indivíduos)
    e EAS (504 indivíduos). Por hora, não é preciso repetir esses
    filtros, mas fica aqui o registro dos comando utilizados:

  - No vcftools, remover os INDELs e singletons (\~1h)

<!-- end list -->

``` r
vcftools --gzvcf ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --remove-indels --min-alleles 2 --max-alleles 2 --maf 0.001 --max-maf 0.999 --recode --out SNPs_Chr2_filter
```

  - No vcftools, selecionar as amostras de indivíduos das populações
    AFR, EAS e EUR (\~ 30min) e filtrar para maf 0.05

<!-- end list -->

``` r
vcftools --vcf SNPs_Chr2_filter.recode.vcf --keep pop_AFR_EAS_EUR_1000g.txt --recode --out SNPs_Ch2_filter_AFR_EAS_EUR
```

``` r
vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR.recode.vcf --min-alleles 2 --max-alleles 2 --maf 0.05 --max-maf 0.95 --recode --out SNPs_Chr2_filter_AFR_EAS_EUR_maf
```

  - No vcftools, selecionar as amostras de indivíduos para cada
    população

<!-- end list -->

``` r
vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --keep pop_AFR_1000g.txt --recode --out SNPs_Chr2_filter_AFR_maf
```

``` r
vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --keep pop_EAS_1000g.txt --recode --out SNPs_Chr2_filter_EAS_maf
```

``` r
vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --keep pop_EUR_1000g.txt --recode --out SNPs_Chr2_filter_EUR_maf
```

# Vamos para a prática

Para iniciar a aula de hoje iremos utilizar ferramentas do vcftools para
estimar o D de Tajima e em seguida o FST. Se você não estiver
familiarizado com o vcftools, pode utilizar os seguintes comandos:

## No vcftools

1.  Através do vcftools, realize o teste de D de Tajima para cada
    população (\~2 min cada)

<!-- end list -->

``` r
vcftools --vcf SNPs_Chr2_filter_AFR_maf.recode.vcf --chr 2 --TajimaD 1000  --out AFR# 1000 is a arbitrary number
```

``` r
vcftools --vcf SNPs_Chr2_filter_EAS_maf.recode.vcf --chr 2 --TajimaD 1000  --out EAS # 1000 é um número arbitrário e corresponde ao tamanho da janela para a estimativa do teste.
```

``` r
vcftools --vcf SNPs_Chr2_filter_EUR_maf.vcf --chr 2 --TajimaD 1000  --out EUR# 1000 é um número arbitrário e corresponde ao tamanho da janela para a estimativa do teste.
```

2.  Através do vcftools, estime o indice FST entre os pares de
    populações

<!-- end list -->

``` r
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out AFR_EAS --chr 5 --weir-fst-pop pop_AFR_1000g.txt --weir-fst-pop pop_EAS_1000g.txt
```

``` r
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out AFR_EUR --chr 5 --weir-fst-pop pop_AFR_1000g.txt --weir-fst-pop pop_EUR_1000g.txt
```

``` r
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out EAS_EUR --chr 5 --weir-fst-pop pop_EAS_1000g.txt --weir-fst-pop pop_EUR_1000g.txt
```

## No R

Suponha que estamos interessados em estudar o SNP da posição 136608646.
Vamos averiguar se esse SNP apresenta sinais de seleção através dos
testes que acabamos de realizar no vcftools.

## D de Tajima

Analise os resultados obtidos para o teste de D de Tajima e responda as
questões abaixo. Você pode usar como base o script XXXXXXX, porém tenha
certeza que consegue compreender os comandos que estão sendo executados.

1.  Verifique se o SNP na posição 136608646 é um outlier em relação aos
    demais SNPs do cromossomo 2.

1.1. Quais os valores observados de D de Tajima para cada grupo de
populações: Africano, Europeu e Leste Asiático? O que cada um desses
valores indicam?

1.2 Esses valores são significativos em relação a média genômica
populacional? Como é possível interpretar a partir desses resultados?

## FST
