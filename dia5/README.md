Estruturação populacional e estimativas de miscigenação
================

## Objetivo

A aula prática de hoje tem como objetivo explorar diferentes métodos que
utilizam dados genéticos em larga para a detecção de estrutura
populacional e inferências de ancestralidade.

Para esse primeiro contato, escolhemos dois métodos que utilizam
abordagens distintas:

  - PCA: Esse método não-paramétrico, usa a técnica de análise
    multivariada para verificar como a variancia genética está
    distribuída entre os indivíduos da amostra, o que permite
    identificar a existencia ou não de estrutura populacional

  - ADMIXTURE: Esse software desenvolvidos por Alexander et al (ref),
    usa o método de MLE para inferir a probabilidade dos genótipos
    observados em um indivíduos serem atribuído a uma dada ancestralida
    com base na frequencia alelica populacional. Esse método usa como
    base o modelo de Hardy-Weinberg e o LD entre os loci.

## Descrição do dataset

Como dataset, usaremos dados públicos, que contém genótipos para SNPs
autossômicos em amostras Nativo Americanas (NAM) do Painel de
Diversidade do Genoma Humano (HGDP) e em quatro populações do HapMap:
Yoruba - África (YRI); Utah - Europa (CEU), Mexicanos residentes em Los
Angeles (MXL) e Afro-Americanos - EUA (ASW).

Hoje exploraremos um outro formato de dados: .bed, .bim e .fam. Esses
arquivos estão no formato binário utilizado pelo programa
plink(<https://www.cog-genomics.org/plink2>), um software que permite
realizar variás análises exploratória dos dados, análises populacionais
e de estudos de associação.

## Vamos para a prática.

O script () contém as análises básicas que podem ser realizadas em R. Se
optar por utiliza-lo, tenha certeza que compreende os comandos que estão
sendo realizados.

1.  Primeiro, explore o dataset e determine: (i) Qual o número de
    indivíduos há nesse dataset? (ii) Qual o número de SNPs? (iii) Qual
    o número de indivíduos por população?

2.  Uma maneira simples de visualizar como a variância genética entre os
    indivíduos está distribuída e verificar possíveis indícios de
    estruturação populacional é através de uma Análise de Componente
    Principal (PCA). Primeiro, use R para realizar um PCA para todo o
    dataset da aula de hoje e responda: (i) O que os PCs 1 e 2 estão
    representando? (ii) Quanto cada PC explica da variância total nos
    dados? (iii) O que os PCs 1 e 2 revelam sobre a ancestralidade?

3.  Repita a análise de PCA, agora variando o número de SNPs analisados
    (mas mantendo o mesmo número de indivíduos). Para reduzir o número
    de marcadores usados, primeiro filtre o dataset usando como critério
    o desequilíbrio de ligação, de modo a excluir marcadors que estejam
    muito correlacionados entre si (usaremos como critério um r2 maior
    do que ou igual a 0.2). Em seguida sorteie: a) 40.000 SNPs, b)
    10.000 SNPs, c) 1.000 SNPs, d) 500 SNPs, e) 100 SNPs e d) 50 SNPs.
    Realize a análise de PCA para cada um desses subconjuntos de SNPs,
    construa os gráficos e responda: (i) Como o número de marcadores
    interfere na detecção de estruturação populacional? (ii) No nosso
    dataset qual o número mínimo de marcadores necessários para detecção
    de estruturação populacional?

4.  Com base na análise de PCA, estime a proporção de ancestralidade
    Africana e Europeia para os indivíduos Afro-Americanos (ASW) do
    nosso dataset e discuta como a análise de PCA pode ser informativa
    sobre os componentes e proporções de ancestralidade dos indivíduos
    miscigenados.

5.  Estime as proporções de ancestralidade para a população Mexicana
    (MXL) pela análise de PCA usando a função snpgdsAdmixProp do pacote
    SNPRelate do R. Em seguida repita a análise, agora com o programa
    ADMIXTURE usando o seguinte comando no servidor:

<!-- end list -->

``` r
admixture  prunedData_Parentais.bed 3  --supervised -j4
```

Vale a pena lembrar que o programa ADMIXTURE implementa essencialmente o
mesmo tipo de análise que o STRUCTURE, discutido no texto que lemos.

Para o conjunto de indivíduos dessa população, qual a ancestralidade
média originada em cada componente parental? Compare os achados do
ADMIXTURE e o PCA. Esses valores diferem estatisticamente?

6.  Construa um grafico para cada compoente de ancestralidade (AFR, EUR
    e NAM) e compare as estimativas individuais inferidas pelo método de
    ADMIXTURE e PCA. O que podemos concluir?
