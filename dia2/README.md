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

**Para começar** Baseado no que você entende sobre deriva genética, proponha, em palavras, possíveis algoritmos que sejam capazes se simular o processo. Repare que há diferentes simulações que são possíveis, de modo que é importante você explicitar que pressupostos está usando. Essa primeira etapa deve ser feita em "palavras", aquilo que os programadores chamam de pseudcódigo.

## Simulando o aumento de IBD com o tempo: uma única população

Vamos simular a mudança, ao longo do tempo,  da probabilidade de identidade por descedência (às vezes chamada de F_ibd, do "identical by descent"). Assumindo que há uma "população de referência", isso equivale a perguntar qual a probabilidade de amostrar duas cópias gênicas que descendem de uma mesma cópia gênica na geração original?

Para explorar a trajetória temporal do F_ibd, examine o código em no arquivo [ibd_single_pop.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/ibd_single_pop.R). Execute cada passo desse código, buscando entender o que ele está fazendo, até que esteja confortável com essa representação da deriva genética.

**Questão 1.** Altere o valor de N e veja o efeito sobre a trajetória temporal de IBD. Ela varia muito entre réplicas? 

## Simulando o aumento de IBD com o tempo: várias populações

Já criamos um arquivo  que realiza essa simulação múltiplas vezes, e também calcula a média para esse conjunto. Esse material está no arquivo [ibd_many_pops.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/ibd_many_pops.R). Use esse simulador e novamente explore o efeio de diferentes valores de N.

**Questão 2.** Em genética de populações, uma estratégia importante para avaliar se as simulações estão programadas de modo correto envolve comparar os resultados simulados com aqueles esperados pela teoria. Usando a fórmula para o aumento da probabilidade de identidade por descendência ao longo do tempo, inclua no gráfico uma linha que indique a trajetória esperada, dado o valor de N. Compare com o valor simulado. A teoria parece estar funcionando? Em média, quanto tempo demora para haver uma "alta probabilidade" de todas cópias gênicas serem descendentes de uma única ancestral?

## Tempo de fixação para uma mutação

Vamos agora estudar o tempo de fixação de uma mutação de modo mais detalhado. O conceito de IBD é fundamental, pois nos ilustra que, invevitavelmente, com o passar do tempo todas as mostras serão descendentes de um único ancestral que exisitiu no passado. Quanto tempo demora, em média, para que uma mutação percorra o trajeto entre estar presente em uma única cópia até se fixar? A teoria de genética de populações tem algumas demonstrações desse resultado, mostrando que é 4N Mas as simulações também podem demonstrá-lo.

**Questão 3.** Use o script [fix_time.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/fix_time.R), que simula o processo de deriva, e veja se a expectativa teórica é observada. Para isso, compare o tempo médio até a fixação de uma das cópias gênicas presentes na população original com a expectativa teórica, 4N (lembrando que o N aqui refere-se ao número de indivíduos diplóides; tome cuidado para ver se isso correspodne ao uso de N feito nas simulações!). A teoria parece estar funcionando?

## Deriva genética para um lócus bialélico

A forma mais habitual de se ilustrar o processo de deriva envolve a trajetória temporal para um lócus bialélico. São os gráficos comumente usados em livro texto, e presentes no capítulo de Hedrick, que vocês leram. Use o código presente no arquivo [drift_single_pop.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/drift_single_pop.R) para entender como se gera tal gráfico, e cerfitique-se que compreender como cada estapa está sendo feito.

**Questão 4.** Usando o arquivo [drift_multiple_pops.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/drift_multiple_pops.R) gere  gráficos que ilustram o processo de deriva, variando o valor de N e as frequências iniciais, e veja o efeito sobre as trajetórias temporais e probabilidades de fixação. Repetindo as simulações um grande número de vezes, certifique-se que de fato a probablidade de fixação é dada pela frequência inicial do alelo.

**Questão 5.** Nós incluímos no código também um cálculo de como a taxa de heterozigose (H) muda ao longo do tempo, tanto para populações individuais, como para a média do conjunto de populações. Sua tarefa é investigar se o declínio de H ao longo do tempo se dá de acordo com a expectativa teórica. Para fazer isso, relembre a equação a ser usada (citada no Hedrick) e inclua-a no gráfico para a trajetória simulada de H. 

## Deriva genética numa população com tamanho variável: o efeito gargalo

Até aqui, fizemos simulações com populações de tamanho constante. Podemos aprender muito sobre a dinâmica evolutiva simulando populações que mudam de tamanho. Criamos um script que faz isso, chamado de [drift_variable_sizes.R](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/drift_variable_sizes.R).

Nesse código geramos  gráficos que mostram mudanças de frequências alélicas, assim como as trajetórias temporais do valor de H, calculadas usando as fórmulas que vimos em sala. 

**Questão 6.** Explore o efeito do garagalo sobre as mudanças de frequências alélicas, altere sua magnitude gargalo. Há um efeito claro das mudanças de N? A volta para um N grande "recupera" a variabilidade perdida?

Vamos agora ver em detalhe os efeitos do gargalo sobre a diversidade genética medida pelo H. Na última porção do código, nós  mostramos como H muda ao longo do tempo, em função do valor de N (simplesmente usamos a fórmula para mudança de H, mas atualizamos o N para cada geração). 

**Questão 7.** Sua tarefa é pegar essa população "complicada" (com gargalos, mudanças de N) e calcular o tamanho efetivo dela. A seguir compare a perda de diversidade genética na população "complicada" real com aquela com N dado pelo tamanho efetivo. Você acha razoável dizer que a dinâmica dessas duas populações é equivalente?
