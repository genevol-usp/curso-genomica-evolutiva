Simulando o processo de deriva genética
==========================================


A deriva genética pode ser definida do ponto de vista biológico: oscilações em frequências aléliccas resultantes do tamanho finito das populações.

Podemos também escrever algumas expressões matemáticas que descrevem a trajetória temporal da diversidade genética. Essas fórmulas mostram que a queda de diversidade genética por deriva é inversamente proporcional ao tamanho da população.

Uma outra forma de estudar a deriva envolve fazer simulações desse processo no computador. Simulações recriam o processo biológico, porém com as regras completamente controladas pelo pesquisador.

1. Baseado no que você entende sobre deriva genética, proponha, em palavras, uma algoritmo que seria capaz se simular o processo. Repare que há diferentes simulações que são possíveis, de modo que é importante você explicitar que pressupostos está fazendo. Essa primeira etapa deve ser feita em "palavras", aquilo que os programadores chama de pseudcódigo.

2. Depois de discutirmos algumas estratégias de pseudcódigo, vamos passar a programá-los, usando R. Ao fazer as simulações de deriva, peço que explorem os seguintes aspectos.

- Faça gráficos do processo de deriva.
- Faça gráficos de como a diversidade genética, medida por "H", varia ao longo do tempo. Lembre que o ideal é você estimar a tarjetória média de H para várias simulações.
- Compare a trajetória de H com aquela esperada pela teoria.
- Faça gráficos sobre a trajetória da variância das frequências alélicas (ou seja, a dispersão das simulações ao redor da média). 
- Até aqui, fizemos simulações com populações de tamanho constante. Introduza uma variação no tamanho populacional, simulando um gargalo. Usando as fórmulas para o tamanho efetivo populacional, veja se a perda de diversidade observada se encaixa com aquela esperada de acordo com o tamanho efetivo.

E aqui vai um teste de fórmula ![](https://github.com/genevol-usp/curso-genomica-evolutiva/blob/master/dia2/CodeCogsEqn.gif), uma bem simples.
