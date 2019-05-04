# Cronograma BIO 5789 -- Genômica Evolutiva


## Dia 1

**Leitura prévia:**

"Hardy-Weinberg Theorem". Hastings, A. (2001) Hardy-Weinberg theorem.In Encyclopedia of Life Sciences. MacMillan Publishing. (No drive da disciplina)

**Teórica**

1. Apresentação do curso, motivação para análises genômicas
2. Descrição básica de variabilidade populacional (frequências alélicas e genotípicas, heterozigose).
3. Modelo básico de populações: Hardy-Weinberg
4. Relação de Hardy-Weinberg com processos de seleção, migração, endogamia [exercícios em sala](dia1/hwp5789.pdf)

**Prática Parte 1.**

1. Exploração de diferentes formatos de dados genômicos: fastq, BAM, vcf.
2. Manipulação de dados usand vcftools, geração de base de dados para cromossomo 22 YRI, como exemplo.

**Prática Parte 2.**

1. Introdução ao uso do R
2. Uso do R para testar desvios de HW em dados do cromossomo 22 YRI

Leitura pós aula: [Graffelman & Weir](https://link.springer.com/article/10.1007/s00439-017-1786-7) (para discussão na aula seguinte, no drive da disciplina) 

## Dia 2

**Leitura prévia:** Hedrick (2013), "Genetic Drift" _In_ ["The Princeton Guide to Evolution", Ed. Losos, J.](https://press.princeton.edu/titles/10100.html) (No drive da disciplina)
**Leitura prévia:** Ramachandran (2010), "Genetics and genomics of human population structure" _In_ M.R. Speicher et al. (eds.), Vogel and Motulsky’s Human Genetics: Problems and Approaches, 589 DOI 10.1007/978-3-540-37654-5_20, © Springer-Verlag Berlin Heidelberg.  (No drive da disciplina)

1. Conceitos básicos de deriva genética
2. Derivando algumas expressões básicas: declínio de H com o tempo, probabilidade de fixação.
3. Prática de deriva genética
  - simulação de deriva: um algoritmo básico em pseudocódigo
  - simulação de deriva: um programa em R
  - deriva com tamanho constante
  - deriva gargalos populacionais
  - equivalência entre demografia complexa e tamanho efetivo
 
 4. Introdução à teoria da coalescência (incluir pi, S e D)
 5. Simulação coalescente simples em R
 
 **Leitura pós-aula:** Prugnolle (2005) como pequeno exemplo.

## Dia 3

**Leitura prévia:** Texto de Holsinger "Theory of Selection in Populations"

1. Conceitos básicos de seleção e parametrização.
2. Simulação de seleção em R
3. Simulação de seleção e deriva em R usando o pacote LearnPopGen

4. Testes de seleção intra-específicos (teórica)
5. Prática

**Leitura pós-aula:** Vitti como revisão (opcional de consulta)
**Leitura pós-aula:** da Africa ou EPAS1

## Dia 4
Leitura prévia: Petrov
Leitura prévia: Genoma de Primatas 

Manhã: inter-específico
Tarde: continuação das práticas

## Dia 5

**Leitura prévia:** Restante do Ramashandran

Demografia
Estrutura populacional

Prática:
1. Admixture -> brincar com valores de K, alterar tamanho dos parentais, 
2. PCA -> desafio: explorar o efeito de número de SNPs (explorar sorteio!)

**Leitura opcional:** Artigo Alexander

## Dia 6

**Leitura prévia:** Hunt Fraser 

1. Associação: de GWAS até traços de interesse evolutivo, expressão tb
2. Análise por chunks?
3. Retomar PCA
4. Ver se há eQTL associado com variante de adaptação.
5. Mapeamento de eQTLs
6. Expressão e seleção

