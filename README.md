# Curso de Genômica Evolutiva (BIO5789)

<img src="logo.jpg" alt="drawing" width="200"/>

#### Instituto de Biociências, Universidade de São Paulo.


<br/><br/>


# Cronograma 

## Dia 1: Dados Genômicos, diversidade genética e modelo de Hardy-Weinberg

**Leitura prévia:** Hastings, "Hardy-Weinberg theorem" (No drive da disciplina)

**Teórica**

1. Apresentação do curso, motivação para análises genômicas
2. Descrição básica de variabilidade populacional (frequências alélicas e genotípicas, heterozigose).
3. Modelo básico de populações: Hardy-Weinberg
4. Relação de Hardy-Weinberg com processos de seleção, migração, endogamia [exercícios em sala](dia1/hwp5789.pdf)

**Prática Parte 1.**

1. Exploração de diferentes formatos de dados genômicos: fastq, BAM, vcf.
2. Manipulação de dados usand vcftools, geração de base de dados para cromossomo 21 YRI, como exemplo.

**Prática Parte 2.**

1. Introdução ao uso do R
2. Uso do R para testar desvios de HW em dados do cromossomo 21 YRI

Leitura pós aula: [Graffelman & Weir](https://link.springer.com/article/10.1007/s00439-017-1786-7) (para discussão na aula seguinte, no drive da disciplina) 

## Dia 2: Deriva genética, tamanho efetivo populacional e teoria de coalescência

**Leituras prévias (no drive da disciplina):** 

- Hedrick (2013), "Genetic Drift".
- Ramachandran et al (2010), "Genetics and genomics of human population structure"

1. Conceitos básicos de deriva genética
2. Derivando algumas expressões básicas: declínio de H com o tempo, aumento de IBD, probabilidade de fixação, tempo de fixação. 
3. Práticas de deriva genética (scripts e roteiro por [aqui](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/README.md))
  - simulação de deriva: um algoritmo básico em pseudocódigo
  - simulação de deriva: um programa em R
  - deriva com tamanho constante
  - deriva gargalos populacionais
  - equivalência entre demografia complexa e tamanho efetivo
 
 4. Introdução à teoria da coalescência (pi, S e D)
 
**Leitura pós-aula:** Prugnolle (2005), um pequeno exemplo sobre os efeitos de deriva (no drive da disciplina).

## Dia 3: Modelo básico de seleção natural

**Leitura prévia:** Holsinger, "Theory of Selection in Populations" (No drive da disciplina).

1. Conceitos básicos de seleção e parametrização.
2. Simulação de seleção em R
3. Simulação de seleção e deriva em R usando o pacote LearnPopGen
4. Testes de seleção intra-específicos (teórica)
5. Prática de seleção: métodos intra-específicos.

**Leitura pós-aula:** 

- Vitti JJ, Grossman SR, Sabeti PC, "Detecting Natural Selection in Genomic Data". (no drive da disciplina)


## Dia 4: Detecção de seleção natural

**Leitura prévia:**

- Petrov, "Searching the genome for adaptations". (No drive da disciplina)

- Outro estudo de caso

Manhã: Teoria sobre métodos inter-específicos de detecção de seleção

Tarde: continuação das práticas de seleção natural.

## Dia 5: Estrutura populacional e reconstrução demográfica a partir de dados genômicos

**Leitura prévia:** Ramachandran (restante do capítulo)

1. Inferência de demografia a partir de dados genômicos
2. Análise de estrutura populacional
3. Ancestralidade genética e miscigenação populacional

Prática:
1. Uso do programa Admixture
2. Uso de PCA (com exploração do efeito da densidade de marcadores)

**Leitura opcional:** Artigo [Alexander et al. (2009)](https://www.ncbi.nlm.nih.gov/pubmed/19648217), descrevendo o Admixture.

## Dia 6: Mapeanto genes que influenciam traços quantitativos

**Leitura prévia:** 

- Fraser, "Gene expression drives local adaptation in humans". (No drive da disciplina)

1. Associação: de GWAS até traços de interesse evolutivo, incluindo expressão.
2. PCA e efeitos confundidores.
3. Mapeamento de eQTLs
4. Expressão e seleção