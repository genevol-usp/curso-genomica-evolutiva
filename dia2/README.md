Deriva Genética
==========================================

O objetivo dessa prática é usar simulações para ilustrar conceitos básicos de deriva genética. 

## O conceito básico de deriva e um simulador básico

Vimos na aula que a deriva genética pode ser definida do ponto de vista biológico: oscilações em
frequências alélicas resultantes do tamanho finito das populações.

Podemos também escrever algumas expressões matemáticas que descrevem a
trajetória temporal da diversidade genética. Essas fórmulas mostram que a queda
de diversidade genética por deriva é inversamente proporcional ao tamanho da
população.

Vimos em aula expressões para o aumento da probabilidade de identidade por descedência e declínio de heterozigose:

F_t = 1 - (1 - 1/2N)^t
H_t = H0 (1 - 1/2N)^t

Uma outra forma de estudar a deriva envolve fazer simulações desse processo no
computador. Simulações recriam o processo biológico, porém com as regras
completamente controladas pelo pesquisador.

Exercício 1. Baseado no que você entende sobre deriva genética, proponha, em palavras, um algoritmo que seja capaz se simular o processo. Repare que há diferentes simulações que são possíveis, de modo que é importante você explicitar que pressupostos está usando. Essa primeira etapa deve ser feita em "palavras", aquilo que os programadores chamam de pseudcódigo.

## Simulando o aumento de IBD com o tempo: uma única população

Lembre que a quantidade cuja trajetória temporal queremos descrever é a probabilidade de identidade por descedência. Em relação a uma "população de referência", isso equivale a perguntar qual a probabilidade de amostrar duas cópias gênicas que descendem de uma mesma cópia gênica na geração original?

Para explorar a trajetória temporal do IBD, examine o código em no arquivo [ibd_single_pop.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/ibd_single_pop.R). Execute cada passo desse código, buscando entender o que ele está fazendo, até que esteja confortável com essa representação da deriva genética. Altere o valor de N e veja o efeito sobre a trajetória temporal de IBD.

## Simulando o aumento de IBD com o tempo: várias populações

Já criamos um arquivo um arquivo que realiza essa simulação múltipolas vezes, e também inclui a média para esse conjunto. Esse material está no arquivo [ibd_many_pops.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/ibd_many_pops.R)

Em genética de populações, uma estratégia importante para avaliar se as simulações estão programadas de modo correto envolve comparar os resultados simulados com aqueles esperados pela teoria. Usando a fórmula para o aumento da probabilidade de identidade por descendência ao longo do tempo, inclua uma linha que indique a trajetória esperada, dado o valor de N. Compare com o valor simulado. A teoria parece estar funcionando? 

## Simulando deriva para um lócus bialélico

- Faça gráficos do processo de deriva.
- Faça gráficos de como a diversidade genética, medida por "H", varia ao longo do tempo. Lembre que o ideal é você estimar a trajetória média de H para várias simulações.
- Compare a trajetória de H com aquela esperada pela teoria.
- Faça gráficos sobre a trajetória da variância das frequências alélicas (ou seja, a dispersão das simulações ao redor da média). 
- Até aqui, fizemos simulações com populações de tamanho constante. Introduza uma variação no tamanho populacional, simulando um gargalo. Usando as fórmulas para o tamanho efetivo populacional, veja se a perda de diversidade observada se encaixa com aquela esperada de acordo com o tamanho efetivo.

E aqui vai um teste de fórmula ![](CodeCogsEqn.gif), uma bem simples.
