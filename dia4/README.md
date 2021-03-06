Métodos para Detecção de Seleção Natural Intraespecíficos
==========================================================

Quiz:
https://forms.gle/afgazwsFPJnM1S5D6



## Objetivo

Nosso objetivo hoje é ter um contato direto com métodos que buscam identificar regiões do genoma que sofreram seleção natural. Usaremos dados genômicos reais e duas classes de testes: um baseado em diferenciação populacional e outro baseado na análise de haplótipos (mais especificamente o método de Homozigose Haplótipo Extendido, o EHH).

## Descrição dos Datasets

Os dados que usaremos na aula prática de hoje são oriundos de dois datasets públicos:

1) Dados de ressequenciamento do genoma completo por NGS (WG-NGS) do [Projeto 1000 Genomas fase III](http://www.internationalgenome.org/data#download) que podem ser acessados através do link: ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ .Esse dataset será utilizado para as análises com os testes de D de Tajima, Fst e PBS.

2) Dados de genotipagem para ~600K SNPS (Axiom Human Origins - Affymetrix) do Painel de Diversidade Genética Humna [HGDP-CEPH - dataset 11](http://www.cephb.fr/en/hgdp_panel.php). Esse segundo dataset será utilizado para as análises de Homozigose Haplótipo Extendido.


## Pré-processamento dos dados

  - Para otimizar nosso tempo, analisaremos um conjunto de dados
    pré-processados para o cromossomo 2 correspondente a indivíduos
    amostrados das populações AFR (504 indivíduos), EUR (503 indivíduos)
    e EAS (504 indivíduos) do 1000 Genomas (correspondendo a, respectivamente,
    um conjunto de indivúdos europeus, asiáticos e africanos). Por hora, não é preciso repetir esses
    filtros, mas fica aqui o registro dos comando utilizados, junto com informação sobre o tempo de processamento necessário:

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
vcftools --vcf SNPs_Chr2_filter_AFR_EAS_EUR.recode.vcf --min-alleles 2 --max-alleles 2 --maf 0.05 --max-maf 0.95 --recode --out SNPs_Chr2_AFR_EUR_EAS_maf
```

  - No vcftools, selecionar as amostras de indivíduos para cada
    população

<!-- end list -->

``` r
vcftools --vcf SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --keep pop_AFR_1000g.txt --recode --out SNPs_Chr2_AFR_maf
```

``` r
vcftools --vcf SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --keep pop_EAS_1000g.txt --recode --out SNPs_Chr2_EAS_maf
```

``` r
vcftools --vcf SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --keep pop_EUR_1000g.txt --recode --outSNPs_Chr2_EUR_maf
```

# Vamos para a prática

Inicialmente iremos utilizar ferramentas do vcftools para
estimar o D de Tajima e em seguida o Fst. Se você não estiver
familiarizado com o vcftools, pode utilizar os seguintes comandos:

## No vcftools

1.  Através do vcftools, realize o teste de D de Tajima para cada
    população (\~2 min cada), estimando essa estatística para janelas de 1000 bases ao longo do genoma.

<!-- end list -->

```
vcftools --vcf ./dados/SNPs_Chr2_AFR_maf.recode.vcf --chr 2 --TajimaD 1000  --out AFR & 
vcftools --vcf ./dados/SNPs_Chr2_EAS_maf.recode.vcf --chr 2 --TajimaD 1000  --out EAS &
vcftools --vcf ./dados/SNPs_Chr2_EUR_maf.recode.vcf --chr 2 --TajimaD 1000  --out EUR &
```

2.  Através do vcftools, estime o indice Fst entre os pares de
    populações (\~20 min cada)

<!-- end list -->

``` r
/home/debora/vcftools/src/cpp/vcftools --vcf ./dados/SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --out AFR_EAS_maf --chr 2 --weir-fst-pop ./dados/pop_AFR_1000g.txt --weir-fst-pop ./dados/pop_EAS_1000g.txt &
/home/debora/vcftools/src/cpp/vcftools --vcf ./dados/SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --out AFR_EUR_maf --chr 2 --weir-fst-pop ./dados/pop_AFR_1000g.txt --weir-fst-pop ./dados/pop_EUR_1000g.txt &
/home/debora/vcftools/src/cpp/vcftools --vcf ./dados/SNPs_Chr2_AFR_EUR_EAS_maf.recode.vcf --out EAS_EUR_maf --chr 2 --weir-fst-pop ./dados/pop_EAS_1000g.txt --weir-fst-pop ./dados/pop_EUR_1000g.txt &
```

Se surgirem dúvidas a respeito de como o vcftools estima os testes acima ou sobre algum argumento excecutado na linha de comando, não deixe de consultar o [manual do programa](https://vcftools.github.io/examples.html). Garante que você entende os argumentos que estão sendo usados no comando.


# Investigando um "Gene Candidato"

Nos referimos a estudos de um "gene candidato" quando investigamos se há evidências de seleção natural nele, com base em algum resultado prévio, sugerindo que ele é um possível alvo de seleção (seja por sua função ou algum achado em outra população ou com outro tipo de teste).

Um dos exemplos de seleção natural mais emblemáticos em humanos são as mutações na região promotora do gene  (_LCT_). O gene _LCT_ codifica para a enzima lactase e no caso de indivíduos portadores de alguns tipos específicos de mutação  na região promotora,  a expressão do gene _LCT_ persiste vida adulta. Há tempos se hipotetizou que a capacidade de continuar consumindo leite na idade adulta representaria uma vantagem evolutiva aos portadores das mutações regulatórias, algo que lhes confereria uma vantagem adaptativa por poder utilizar uma fonte energética/nutricional adicional (o leite). 

Dentre os SNPs da região promotora, o -13910C>T (rs4988235; posição 136608646 - hg19) ocorre em alta frequencia em algumas populações, em especial no Norte da Europa. Diversos estudos encontraram assinaturas genéticas que sugerem que a variante -13910T aumentou de frequência por um processo de seleção positiva (Bersaglieri et al. 2004; Coelho et al., 2005; Itan et al., 2009 - os artigos estão no drive da disciplina). Partindo desse exemplo clássico, usaremos a abordagem de SNP candidato para aplicar e compreender a interpretação de alguns testes de seleção natural.

# Testes de seleção
## D de Tajima

Primeiro, analise os resultados obtidos para o teste de D de Tajima e responda as
questões abaixo. Você pode usar como base o script [Aula_pratica.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia4/Aula_pratica.R). Tenha
certeza que  compreende os comandos que estão sendo executados.

1. Quais os valores observados de D de Tajima para a janela contendo o SNP rs4988235 em cada grupo de
populações  (Africano, Europeu e Leste Asiático)? O que cada um desses
valores indica em termos de seleção natural e distribuição das frequencias alélicas? A seleção é a única explicação possível para o valor de D de Tajima encontrado?

2. Verifique se os valores de D de Tajima observados para o SNP rs4988235 são significativos em cada população. Como é possível interpretar esses resultados?

3. Altere os tamanhos de janela da estimativa de D de Tajima aumentando e diminuindo o tamanho inicial em uma ordem de grandeza. Em seguida interprete e discuta os resultados: (i) Há alterações nos resultados? (ii) Houve mudanças no sinal da estimativa de D para a região do SNP de interesse? (iii) Qual a causa de um resultado NaN?

## Diferenciação genética como evidência de seleção (métodos baseados em Fst)

Agora, vamos analisar os resultados obtidos com as análises de Fst.

4. A estimativa de Fst pela métrica de Weir e Cockerham por vezes pode gerar valores negativos e "NA". O que isso significa? Como isso pode interferir nos resultados?

5. Os valores de Fst observados entre os pares de populações para o SNP rs4988235 caem dentro de quais quantis de distribuição de valores de Fst para o cromossomo estudado? Eles podem ser considerados _outliers_?

6. A partir dos valores de Fst observados entre os pares de populações e as estimativas de significância, o que podemos dizer sobre a diferenciação do SNP rs4988235 entre populações? 

7. Discuta como esses resultados justificam realizar outro tipo de análise, baseada no PBS (population branch statistic), usada no estudo sobre adaptação a altitude em Tibetanos.

## PBS

8. O que a análise de PBS revela? Qual a diferença entre a análise de PBS e Fst?

### Análise para conjunto de SNPs adjacentes

Um dos grandes desafios na análise de dados em larga escala é a proporção de falsos positivos detectados. Uma abordagem adotada para diminuir esse ruído é a análise conjunta de marcadores adjacentes (por exemplo, o Fst médio em uma janela de N SNPs). A ideia é que devido ao desequilíbrio de ligação (LD) entre os sítios, o sinal de seleção em um determinado SNP será compartilhado pelos SNPs adjacentes. Desse modo, um sinal verdadeiro também será reproduzido na análise por janelas, enquanto um resultado espúrio não.

Vamos repetir a análise de PBS agora usando uma janela de SNPs. Você pode alterar o tamanho dessas janelas e através de gráficos observar as mudanças nos padrões.

9. Com base nos três testes aplicados e na análise por janela, discuta como interpretar os sinais observados para o SNP rs4988235/região do SNP?


## Teste de seleção por Homozigose de Haplótipo Estendido (EHH)

10. As análises e EEH, iHS e xpEHH serão realizadas com o pacote rehh do R (Gautier, Klassmann, Vitalis et al. 2017). Para otimizar o nosso tempo, os dados foram pré-processados e formatados para atender adequadamente os requisitos das análises. Frente ao que vimos na aula teórica e na leitura prévia (Vitti et al., 2013), quais requisitos/informações sobre os dados são essenciais para a realização das análises de homozigose haplótipo extendido (EHH, iHS e xpEHH)? Como é possível gerar e/ou obter essas informações?

11. Descreva qual o padrão observado a partir dos gráficos gerados na análise de EHH para a região do rs4988235 em cada grupo populacional (AFR, EUR, EAS). O que esse padrão revela? Como essa informação é representada nos gráficos de bifurcação?

12. Explore os resultados de xpEHH para as regiões adjacentes ao SNP rs4988235. Se achar necessário, altere o número de SNPs para melhor visualizar a região nos três pares populacionais. Em seguida, interprete e discuta os resultados: (i) O que significam valores positivos e negativos para xpEHH? (ii) Qual a relação dos valores de xpEHH e as diferenças de EHH entre pares de populações? (iii) De modo geral, os pesquisadores assumem que um valor de xpEHH >2 pode ser considerado um sinal de seleção para uma região candidata. Como vocês sugerem que esse limiar foi definido?

# Questões para discussão

## O que vem depois de um scan sobre seleção?

O estudo que vocês leram sobre os exomas de Tibetanos (Yi e colaboradores, 2010) identificou um gene candidato a seleção natural, o _EPAS1_. Mas achar uma evidência de seleção é o fim da estória, ou o começo? Pedimos que vocês discutam que tipos de "novos estudos" são estimulados a partir desses achados, quais questões eles podem enfocar, e como eles se estruturam a partir dos achados prévios. Vocês podem citar tanto estudos que de fato foram feitos (caso os conheçam) como simplesmente compartilhar ideias sobre questões que parecem interessantes (na medida do possível, nós comentaremos o quanto elas foram abordadas pela comunidade científica). 

## Como estudar adaptação inter-específica?

Imagine que há uma espécie de roedor que é capaz de viver em elevadas altitudes, algo que nenhuma outra espécie do seu gênero consegue. Nada se sabe sobre quais genes estão por trás desse fenótipo. Como você propõe que seja feito um estudo para investigar os efeitos da seleção natural sobre a adaptação à vida em altitude? Que dados você gostaria de gerar, e quais análises iria realizar, para entender essa adaptação?

## Planejando um estudo de adaptação intra-específico.

Um tema recorrente na aula de hoje foi a complicação introduzida pela necessidade de avaliar se os padrões de variação vistos nos dados (seja na forma de Fst, variabilidade, D de Tajima, EHH) é consequência da ação da seleção ou da história demográfica. Considerando tudo que foi lido e discutido, imagine que cabe a você está prepararando um projeto para estudar adaptação de populações indígenas brasileiras. Qual dado genético você usaria? Que abordagem analítica (ou abordagens) usaria para separar os efeitos de demografia e seleção?
