###########################
### Revisão básica de R ###
###########################

## Preparação para a Prática 

#Apresentação ao R e RStudio

# As análises de dados da nossa aula prática será realizada em R utlizando o a interface do RStudio.

#R: Linguagem e ambiente com ferramentas estatísticas que permite a realização de diversas análises.
#R-Studio: Interface gráfica que facilita o trabalho com o R. 


#Vamos explorar um pouco o R!

# O R como calculadora
2+2
6-7
4/3
5*5

# O R para operações de lógica
10>2
(3*2)==5


# O R para guardar pequenas informações de texto (strings)
"R e dados genômicos em larga escala"


# O R guarda informações em variáveis
a<-100 # variável
a

a*8
b<-a*8

a<- 20 # o R sobreescreve uma variável sem informar que ela já exite. TOME CUIDADO!!!
a

b # modificou apenas o objeto a e em princípio não o b

b<-a*8
b


# R e pequenos códigos pré-estabelecidos (funções)
2+2
sum(2+2)

(1+2+3+4+5+6)/6
mean(1:6)

log(10)
log10(100)


# R e os pacotes (conjuto de várias funções)
install.packages("genetics")

# R e gráficos
dist<-runif (1000)

hist(dist)



# Prática. Organização e análise de dados

# 1. Crie um novo diretório para guardar os exercícios. Em seguida mude seu diretorio de trabalho em R para lá.
getwd()
setwd("Caminho_para_o_diretorio")


# 2. Crie o seguinte data frame e estime a média, mediana, sd, da coluna idade.
#seq  id idade genero
#   1 A01    20      f
#   2 A02    22      m
#   3 A03    25      f
#   4 A04    26      m
#   5 A05    29      m

dataset<-data.frame(seq=1:5, id=c("A01", "A02", "A03", "A04", "A05"), 
                    idade=c(20,22,25,26,29), 
                    genero=c("f", "m", "f", "m", "m"))
dataset
mean(dataset$idade)
str(dataset)
mean(as.numeric(dataset$idade))
median(as.numeric(dataset$idade))
sd(as.numeric(dataset$idade))

# 3. Leia o arquivo "example_table.txt" no R
tab<-read.table("./example_table.txt", header=F, stringsAsFactors = FALSE) # ler o arquivo em forma de tabela

head(tab) # mostra na tela as primeiras linhas
tail(tab) # mostra na tela as linhas finais

# 4. Quantas linhas e colunas o arquivo "example_table.txt" possui?
nrow(tab)
ncol(tab)

# 5. Renomeie as colunas do arquivo "example_table.txt" para ID, L1, L2, L3, L4, Genero, Idade e Etnia respectivamente

colnames(tab)<- c("ID", "L1", "L2", "L3", "L4", "Genero", "Idade", "Etnia") # nomear as colunas

head(tab)


# 6. Qual a média, mediana, maior e menor idade dos indivíduos dessa tabela?
mean(tab$Idade)
mean(tab$Idade, na.rm=T)

median(table$Idade, na.rm=T)

min(table$Idade, na.rm=T)

max(table$Idade, na.rm=T)

# Outra opção
summary(table$Idade)


#7. Estimar frequencias alélicas e genotípicas do locus L1
GenoCount<- summary(table$L1) # contando o número de observações para cada genotipo
GenoCount
NumbObs<-sum(!is.na(table$L1)) # contando o total de observações, sem os NA
NumbObs
GenoFreq<- as.vector (GenoCount/NumbObs) # estimando a frequencia genotípica
GenoFreq

FreqC<-(2*GenoFreq[1] + GenoFreq[2])/2 # frequencia alélica = alelo C
FreqC

FreqT<- (GenoFreq [2] + 2*GenoFreq[3])/2 # frequencia alélica = alelo G
FreqT

# 8. Repita a atividade 7 usando o pacote "genetics"

# Se o pacote "genetics" não estiver instalado, você pode baixa-lo com o seguinte comando:
# install.packages("genetics")

# Carregue o pacote
library("genetics")

Geno<- genotype (table$L1, sep="") # a função genotype dá direto as freq alelicas e genotipicas
summary(Geno) # visualizar a análise

# 9. Calcule a frequencia alélica e genotipica para cada grupo etnico.
# Estratificando pela variável etnia
head(table)
levels(table$Etnia) # ver quantas etnias constam na tabela

## Caucasian
table_etnia_caucasian<- table[table$Etnia=="Caucasian",]
table_etnia_caucasian

GenoCount_etnia_caucasian<- summary(table_etnia_caucasian$L1)
GenoCount_etnia_caucasian

NumbObs_etnia_caucasian<-sum(!is.na(table_etnia_caucasian$L1))
NumbObs_etnia_caucasian

GenoFreq_etnia_caucasian<- as.vector (GenoCount_etnia_caucasian/NumbObs_etnia_caucasian) # estimando a frequencia genotípica
GenoFreq_etnia_caucasian

FreqC_etnia_caucasian<-(2*GenoFreq_etnia_caucasian[1] + GenoFreq_etnia_caucasian[2])/2 # frequencia alélica = alelo A
FreqC_etnia_caucasian

FreqT_etnia_caucasian<- (GenoFreq_etnia_caucasian [2] + 2*GenoFreq_etnia_caucasian[3])/2 # frequencia alélica = alelo G
FreqT_etnia_caucasian

# 10. Repita a atividade 9 usando o pacote "genetics"
## Ou usando o pacote "genetics"

Geno_etnia_caucasian<- genotype(table_etnia_caucasian$L1, sep="")
Geno_etnia_caucasian
summary(Geno_etnia_caucasian)

# 11. Salve o arquivo gerado
write.table(Geno_etnia_caucasian, "example_table_caucasian.txt", sep="\t", col.names=F,row.names=F, quote=F)


#12. Contrua um gráfico para cada um dos itens: idade, genero, etnia, L1
plot(table$Idade) # gráfico de dispersão se os dados forem numéricos
plot(table$Genero)
plot(table$Etnia) # gráfico de distribuíção de frequencia se os dados forem caracters
plot(table$L1)



# 13. Altera a cor dos gráficos
plot(table$Idade, col= "red", main= "Gráfico de dispersão das idades", xlab="Indivíduos", ylab= "Idade")


# 14. Construa um gráfico mostrando se há variação de idade entre os grupos étnicos
plot(table$Etnia, table$Idade, main="Variação das idades entres os diferentes grupos étnicos", xlab="Grupos étnicos", ylab="Idade")
