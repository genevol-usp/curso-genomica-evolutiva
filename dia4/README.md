Métodos para Detecção de Seleção Natural Intraespecíficos
==========================================================

## Descrição do Dataset

Os dados que usaremos na aula prática de hoje são oriundos do Projeto
1000 Genomas fase III e podem ser acessado a partir dos seguintes links:

<ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/>

<http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/README_vcf_info_annotation.20141104>

## Pré-processamento dos dados

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

```
vcftools --vcf SNPs_Chr2_filter_AFR_maf.recode.vcf --chr 2 --TajimaD 1000  --out AFR & 
vcftools --vcf SNPs_Chr2_filter_EAS_maf.recode.vcf --chr 2 --TajimaD 1000  --out EAS &
vcftools --vcf SNPs_Chr2_filter_EUR_maf.recode.vcf --chr 2 --TajimaD 1000  --out EUR &
```

2.  Através do vcftools, estime o indice FST entre os pares de
    populações (\~20 min cada)

<!-- end list -->

``` r
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out AFR_EAS --chr 5 --weir-fst-pop pop_AFR_1000g.txt --weir-fst-pop pop_EAS_1000g.txt &
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out AFR_EUR --chr 5 --weir-fst-pop pop_AFR_1000g.txt --weir-fst-pop pop_EUR_1000g.txt &
/home/debora/vcftools/src/cpp/vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR_maf.recode.vcf --out AFR_EUR --chr 5 --weir-fst-pop pop_AFR_1000g.txt --weir-fst-pop pop_EUR_1000g.txt &
```

# Gene Candidato

Um dos exemplos de seleção natural mais emblemáticos em humanos são as mutações na região promotora do gene LCT. O gene LCT codifica para a enzima lactase e indivíduos portadores de mutações na região promotora, continuam a expressar o gene LCT na vida adulta. Isso lhes confere uma vantagem adaptativa ao apresentar uma fonte energética/nutricional adicional. 

Dentre os SNPs da região promotora, o -13910C>T (rs4988235; posição 136608646 - hg19) ocorre em alta frequencia nas populações Europeias. Diversos estudos encontraram assinaturas genéticas que sugerem que a variante -13910T aumentou de frequencia por um processo de seleção positiva. Partindo desse exemplo clássico, usaremos a abordagem de SNP candidato para aplicar e compreender a interpretação de alguns testes de seleção natural.

# Testes de seleção
## D de Tajima

Primeiro, analise os resultados obtidos para o teste de D de Tajima e responda as
questões abaixo. Você pode usar como base o script [Pratica_dia3_selecao.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia3/Pratica_dia3_selecao.R), porém tenha
certeza que consegue compreender os comandos que estão sendo executados.

1. Quais os valores observados de D de Tajima para o SNP rs4988235 em cada grupo de
populações: Africano, Europeu e Leste Asiático? O que cada um desses
valores indicam?

2. Teste se os valores de D de Tajima observados para o SNP rs4988235 são significativos em cada população? Como é possível interpretar esses resultados?

## FST

Em seguida, vamos analisar os resultados obtidos com as análises de FST.

3. Uma questão de ordem técnica para pode compreender melhor os resultados, a estimativa de FST por Weir e Cockerham, por vezes podem gerar valores negativos e Na o que isso significa? Como isso pode interferir nos resultados?

4. Os valores de FST observados entre os pares de populações para o SNP rs4988235 caem dentro de quais quantils de distribuição? Eles podem ser considerados outliers?

5. A partir dos valores de FST observados entre os pares de populações e as estimativas de significância o que podemos dizer sobre a diferenciação do SNP rs4988235?

6. Discuta como esses resultados justificam analisar os dados através do teste de PBS?

## PBS

7. O que a análise de PBS revela? Qual a diferença entre a análise de PBS e FST?

## Análise para conjunto de SNPs adjacentes

Um dos grandes desafios na análise de dados em larga escala é a proporção de falsos positivos detectados. Uma abordagem adotada para diminuir esse ruído é a análise conjunta de marcadores adjacentes (média em uma janela de N SNPs). A ideia é que devido o LD entre os marcadores o sinal de seleção em um determinado SNP, será compartilhado pelos SNPs adjacentes. Deste modo, um sinal verdadeiro também será reproduzido na análise por janelas, enquanto um resultado espúrio não.

Vamos repetir a análise de PBS agora usando uma janela de SNPs. Você pode alterar o tamanho dessas janelas e através de gráficos observar as mudanças nos padrões.

8. Com base nos três testes aplicados e na análise por janela, discuta como interpretar os sinais observados para o SNP rs4988235?

## Homozigose haplótipo extendido (eHH)


# Testes de seleção e escalas temporais
10. Diferentes metodologias e estratégias são adotadas para a detecção de sinais seletivos. Deste modo, cada classe de métodos consegue detectar assinaturas seletivas em diferentes escalas de tempo. Discuta sobre as classes de métodos que utilizamos na prática de hoje e o que eles revelam sobre a escala de tempo do processo de seleção natural na persistência de expressãodo do LCT durante a vida adulta.

# Seleção natural x Demografia

11. Por vezes, a seleção natural e a história demografica das populações podem gerar um mesmo padrão de assinatura genética. Quais estratégias podemos adotar para distinguir um sinal seletivo de um demográfico?
