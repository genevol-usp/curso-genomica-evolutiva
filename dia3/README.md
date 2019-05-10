Roteiro para discussões sobre seleção natural
=============================================


## Modelo determinístico de seleção natural

No texto “Theory of selection in populations”, Kent Holsinger revisa o conceito básico de seleção natural e apresenta uma fórmula que prevê como a frequência de um alelo (dada por p) numa geração difere daquela da geração anterior, supondo que a seleção esteja ocorrendo.

Usando a fórmula (1) apresentada no texto e a linguagem de programação como R, mostre como uma mutação vantajosa aumenta de frequência ao longo do tempo (decida o número de gerações necessário para ilustrar o processo do modo mais claro). Vamos supor que o coeficiente de seleção associado à mutação seja de 0.05 (ou seja, s=0.05). Com esse valor é possível calcular o valor adaptativo de cada genótipo. Suponha que a frequência inicial da mutação é de 1% e faça seus cálculos para dois cenários, dados abaixo em (a) e (b).

(a) A mutação é vantajosa e recessiva (a vantagem só se faz presente quando duas cópias da mutação estão presentes, ou seja WAA > WAa e WAA>Waa)

(b) A mutação é vantajosa e dominante (indivíduos heterozigotos para a mutação têm o mesmo valor adaptativo, ou seja WAA=WAa, e ambos são maiores que Waa)

## Modelo de seleção que incorpora deriva

Para contrastar o modelo determinístico de seleção natural com um que contempla tanto os efeitos de deriva e seleção, use um simulador escrito em R, disponível no seguinte site:

https://phytools.shinyapps.io/drift-selection/

Você pode usar o simulador clicando no link acima, mas pode ser mais eficiente baixa-lo no servidor ou na sua máquina local. Há 2 opções para fazer isso:

1. Clone o repositório na sua home do servidor, ou no seu computador próprio, com o comando: 

`git clone git@github.com:liamrevell/PopGen.apps.git`

Assim você terá uma pasta PopGen.apps. Abra o Rstudio, entre nessa pasta e abra o arquivo app.R dentro de drift.selection. Clique no botão "Run App" no Rstudio.

2. Ou apenas copie e cole o arquivo app.R dentro da pasta drift.selection no repositório do simulador:

https://github.com/liamrevell/PopGen.apps

Então, abra esse arquivo no Rstudio e clique no botão "Run App".

Faça simulações para valores adaptativos de WAA=1.00; WAa=0.95; Waa=0,90, com frequência inicial do alelo em 0.05. Varie o tamanho da população e discuta o efeito sobre as trajetórias e as probabilidades de fixação da mutação vantajosa. O que acontece se você reduz a frequência inicial do alelo vantajoso para 0,01? De modo geral, a partir de quais combinações de tamanho populacional e intensidade de seleção os afeitos estocásticos (introduzidos pela deriva) passam a dominar?

## Probabilidade de fixação sob seleção e deriva genética

Os padrões gerais vistos no exercício anterior foram investigados de modo analítico por J.B.S. Haldane (1982-1964) Motoo Kimura (1924-1994). Eles descobriram que a probabilidade de fixação de uma mutação vantajosa depende da intensidade de seleção que a favorece e também de sua frequência inicial. No caso especial em que a frequência inicial da mutação é 1/2N (o que equivale a dizer que ela está presente em uma só cópia, pois é “recém surgida”, a fórmula é:

![](fix_prob.png)

que para valores de s relativamente baixos e N elevado se aproxima de 2s.

De posse desse resultado, considere uma mutação presente em uma única cópia, que ocorre numa população de tamanho N=1000. Contraste as probabilidades de fixação de mutações de dois tipos:

- uma mutação neutra;

- uma mutação que confira uma vantagem de 1% (ou seja s=0,01).

Essa diferença faz sentido para você? Como a probabilidade de fixação no caso de seleção constrasta com o que vimos no modelo determinístico (em que não há deriva)?

Agora imagine que essa mesma mutação vantajosa tivesse surgido numa população de tamanho N=50. Sua previsão para a diferença na probabilidade de fixação entre a mutação neutra e a vantajosa mudaria?

## Usando simulações para testar a teoria

Os resultados anteriores, referentes à probabilidade de fixação, podem ser testados usando simulações. Aliás, é uma prática comum em estudos de genética de populações comparar resultados teóricos com os simulados. Essa abordagem é poderosa, pois caso a teoria seja nova, obter os mesmos resultados que aqueles aqueles da simulação mostra que a teoria está funcionando. Por outro lado se o simulador é novo e a teoria já estabelecida, obter o mesmo resultado indica que o simulador foi programado corretamente.

Utilize o simulador indicado no exercício anterior para ver se a predição teórica é de fato observada (ou seja, a de que a probabilidade de fixação de uma mutação vantajosa é aproximadamente 2s). Lembre de ajustar a frequência inicial do alelo para 1/2N, que corresponde à condição de haver apenas uma cópia do alelo presente na população. Para facilitar o exercício, simule casos em que s=0,05, em que a seleção segue um modelo aditivo e com um tamanho populacional de N=100. Para cada réplica incluam um numero elevado de populações (por exemplo, 100) e registre o número que se fixou. Compare com o valor teórico esperado.

## Tempo até fixação

Outro importante resultado teórico referente à trajetória de mutações diz respeito ao tempo médio que demora para uma mutação surgir e se fixar. Para uma mutação neutra o tempo médio até a fixação é 4N gerações. Já para mutações sob seleção, o tempo médio é dado por:

![](fix_time.png),

onde o ln refere-se ao logaritmo na base natural.

Utilizando essas expressões, compare o tempo médio até a fixação de uma mutação neutra que surge numa população de N=1000 indivíduos com o tempo até a fixação para uma mutação que confere vantagem de 1% (ou seja, s=0,01), também numa população de N=1000. A diferença nesses tempos dá alguma ideia sobre como podemos buscar identificar regiões do genoma que estiveram sob os efeitos de seleção natural?



Segunda parte da aula
===============================

## Métodos para Detecção de Seleção Natural Intraespecíficos

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

## Gene Candidato

Um dos exemplos de seleção natural mais emblemáticos em humanos são as mutações na região promotora do gene LCT. O gene LCT codifica para a enzima lactase e indivíduos portadores de mutações na região promotora, continuam a expressar o gene LCT na vida adulta. Isso lhes confere uma vantagem adaptativa ao apresentar uma fonte energética/nutricional adicional. 

Dentre os SNPs da região promotora, o -13910C>T (rs4988235; posição 136608646 - hg19) ocorre predomiantemente em populações Europeias. A partir desse exemplo clássico, usaremos a abordagem de SNP candidato para aplicar e compreender a interpretação de alguns testes de seleção natural.


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

4. Os valores de FST observados entre os pareas de populações para o SNP rs4988235 caem dentro de quais quantils de distribuição? Eles podem ser considerados outliers?

5. A partir dos valores de FST observados entre os pares de populações e as estimativas de significância o que podemos dizer sobre a diferenciação do SNP rs4988235?

6. Discuta como esses resultados justificam analisar os dados através do teste de PBS?

## PBS

7. O que a análise de PBS revela? Qual a diferença entre a análise de PBS e FST?

## Análise para conjunto de SNPs adjacentes

Um dos grandes desafios na análise de dados em larga escala é a proporção de falsos positivos detectados. Uma abordagem adotada para diminuir esse ruído é a análise conjunta de marcadores adjacentes (média em uma janela de N SNPs). A ideia é que devido o LD entre os marcadores o sinal de seleção em um determinado SNP, será compartilhado pelos SNPs adjacentes. Deste modo, um sinal verdadeiro também será reproduzido na análise por janelas, enquanto um resultado espúrio não.

Vamos repetir a análise de PBS agora usando uma janela de SNPs. Você pode alterar o tamanho dessas janelas e observar as mudanças nos padrões através dos gráficos.

8. Com base nos três testes aplicados e na análise por janela, discuta como interpretar os sinais observados para o SNP rs4988235?
