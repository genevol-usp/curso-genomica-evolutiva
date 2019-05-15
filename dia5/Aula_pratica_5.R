### Aula Prática: Estruturação Populacional e estimativas de Miscigenação 

setwd("caminho para o diretório")

# Instalar os pacotes gdsfmt e SNPRelate
source("http://bioconductor.org/biocLite.R")
biocLite("gdsfmt")
biocLite("SNPRelate")

# Carregar os pacotes
library("gdsfmt")
library("SNPRelate")


# Para a prática usaremos dados públicos, que contém genótipos para SNPs autossômicos em amostras Nativo Americanas (NAM) do Painel de Diversidade do Genoma Humano (HGDP) e em quatro populações do HapMap: Yoruba - África (YRI); Utah - Europa (CEU), Mexicanos residentes em Los Angeles (MXL) e Afro-Americanos - EUA (ASW)

# Hoje exploraremos um outro formato de dados, .ped, .bim e .fam
# Esses arquivos são no formato utilizado pelo programa plink() um software que permite realizar variás análises exploratória dos dados, análises populacionais e de estudos de associação

# Explore o dataset e determine:
# 1) Qual o número de indivíduos neste dataset?
FAM<-read.table("YRI_CEU_ASW_MEX_NAM_edited.fam", sep=" ")
head(FAM)
dim(FAM)

# 2) Qual o número de SNPs?
BIN<-read.table("YRI_CEU_ASW_MEX_NAM_edited.bim", sep="\t")
head(BIN)
dim(BIN)

# 3) Qual o número de amostras em cada população?
POPINFO=read.table("Population_Sample_Info_edited.txt", header=TRUE)
table(POPINFO$Population)

##  Uma das maneiras mais simples de visualizar como a variância genética entre os indivíduos está distribuída e verificar possíveis indícios de estruturação populacional é através de uma análise de Componente Principal (PCA).

# Existem vários softwares e pacotes em R que podem ser usados para a análise de PCA.
# Na prática de hoje optamos pelo pacote "SNPRelated".

# Primeiro converta os arquivos do formato binário do plink para o formato gds
bedfile<-"YRI_CEU_ASW_MEX_NAM_edited.bed" 
famfile<-"YRI_CEU_ASW_MEX_NAM_edited.fam" 
bimfile<-"YRI_CEU_ASW_MEX_NAM_edited.bim"

snpgdsBED2GDS(bedfile, famfile, bimfile, "POPs.gds")

# Em seguida, verifique como é o arquivo gds
genofile <- snpgdsOpen("POPs.gds")
head(genofile)
head(read.gdsn(index.gdsn(genofile, "sample.id")))
head(read.gdsn(index.gdsn(genofile, "snp.id")))

# Por fim, vamos realizar a análise de PCA e discutir os resultados
pca <- snpgdsPCA(genofile)
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
population<-POPINFO$Population

tab <- data.frame(sample.id = pca$sample.id,
                  pop = factor(population)[match(pca$sample.id, sample.id)],
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)
head(tab)

# Vamos ver os resultados em um gráfico
plot(tab$EV2, tab$EV1, col=as.integer(tab$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA using all SNPs")
legend("topleft", legend=levels(tab$pop), pch="o", col=1:(nlevels(tab$pop)))

# Quanto cada PC explica da variância?
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))

lbls <- paste("PC", 1:4, "\n", format(pc.percent[1:4], digits=2), "%", sep="")
pairs(pca$eigenvect[,1:4], col=tab$pop, labels=lbls)


## Quantos SNPs são necessários para verificar a estrutura populacional?

# Usando a relação de LD entre os marcadores, vamos excluir SNPS do nosso dataset.

snpset_02 <- snpgdsLDpruning(genofile, ld.threshold=0.2)

# Agora, vamos repetir a análise de PCA, usando apenas esse subconjunto de SNPs. Há diferença entre a análise usando o conjunto total ou um subconjunto do  SNPs?
snpset.id_1 <- unlist(snpset_02)

pca2 <- snpgdsPCA(genofile, snp.id=snpset.id_1)
tab2 <- data.frame(sample.id = pca2$sample.id,
                   pop = factor(population)[match(pca2$sample.id, sample.id)],
                   EV1 = pca2$eigenvect[,1],    # the first eigenvector
                   EV2 = pca2$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab2$EV2, tab2$EV1, col=as.integer(tab$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA using a subset of SNPs")
legend("bottomright", legend=levels(tab$pop), pch="o", col=1:(nlevels(tab$pop)))

# Qual o conjunto minimo de SNPs necessários para verificar estruturação populacional nesse dataset?
N_40000<-snpset.id_1 # 40.000 marcadores
N_10000<-sample(snpset.id_1, 10000) # 10.000 marcadores
N_1000<-sample(snpset.id_1, 1000) # 1.000 marcadores
N_500<-sample(snpset.id_1, 500) # 500 marcadores
N_100<-sample(snpset.id_1, 100) # 100 marcadores
N_50<-sample(snpset.id_1, 50) # 50 marcadores


# Visualize os resultados nos gráficos
par(mfrow=c(3,2))

## ~40000 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_40000)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 40.000 SNPs")

## ~10000 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_10000)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 10.000 SNPs")

## ~1000 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_1000)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 1000 SNPs")

## 500 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_500)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 500 SNPs")

## 100 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_100)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 100 SNPs")

## 50 SNPs
pca3<- snpgdsPCA(genofile, snp.id= N_50)
tab3 <- data.frame(sample.id = pca3$sample.id,
                   pop = factor(population)[match(pca3$sample.id, sample.id)],
                   EV1 = pca3$eigenvect[,1],    # the first eigenvector
                   EV2 = pca3$eigenvect[,2],    # the second eigenvector
                   stringsAsFactors = FALSE)


plot(tab3$EV2, tab3$EV1, col=as.integer(tab3$pop), xlab="eigenvector 2", ylab="eigenvector 1", main="PCA conjunto de 50 SNPs")



dev.off()

## Como a análise de PCA pode ser informativa sobre a proporção de ancestralidade de indivíduos miscigenados?

# 1) Vamos estimar a proporção de ancestralidade nos indivíduos da população Afro-Americana.

YRI_pc_medio<-mean(pca2$eigenvect[population=="YRI",1])
CEU_pc_medio<-mean(pca2$eigenvect[population=="CEU",1])

ASW_admix=(pca2$eigenvect[population=="ASW",1]-CEU_pc_medio)/(YRI_pc_medio-CEU_pc_medio)

# Visualizar a ancestralidade estimada a partir do PCA em gráfico de barras
tab2<-cbind(ASW_admix,1-ASW_admix)
ordem_AFR_anc<-order(ASW_admix)
temp<-t(as.matrix(tab2[ordem_AFR_anc,]))


barplot(temp, col=c("blue","green"),xlab="Individual ", ylab="Ancestry", border=NA,axisnames=FALSE,main="Ancestry of ASW",ylim=c(0,1))
legend("bottomright", c("African","European"), lwd=4, col=c("blue","green"), bg="white",cex=0.85)


## Por fim, vamos estimar a ancestralidade para uma população com 3 componentes ancestrais, a partir da função snpgdsAdmixProp
# 1) Indicar os grupos parentais
groups <- list(CEU = sample.id[population == "CEU"],
               YRI = sample.id[population == "YRI"],
               NAM = sample.id[population == "NAM"])

# 2) Estimar a ancestralidade a partir do PCA.
prop <- snpgdsAdmixProp(pca2, groups=groups,bound=TRUE)

##  Visualizar em um gráfico de barras
MXL_ancestry<-data.frame(prop[population=="MXL",])
myorder=order(MXL_ancestry$CEU)
temp=t(as.matrix(MXL_ancestry[myorder,]))


barplot(temp, col=c("blue","red","green"),xlab="Individual ", ylab="Ancestry", border=NA,axisnames=FALSE,
        main="Estimated Ancestry of MXL from PCA",ylim=c(0,1))
legend("bottomright", c("European","African","Native American"),lwd=4, col=c("blue","red","green"),bg="white",cex=0.85)


#snpgdsClose(genofile)

#### Comparar com as estimativas do admixture!

# Estime a ancestralidade no admixtrue

tbl<-read.table("prunedData_Parentais.3.Q")
MXL_only<-tbl[432:517,]
ordem2<-order(MXL_only$V1)
temp2<-t(as.matrix(MXL_only[ordem2,]))


barplot(temp2, col=c("blue","red","green"),xlab="Individual ", ylab="Ancestry", border=NA,axisnames=FALSE,
        main="Estimated Ancestry of MXL from Admixture",ylim=c(0,1))

legend("bottomright", c("European","African","Native American"),lwd=4, col=c("blue","red","green"),bg="white",cex=0.85)


## Comparar as estimativas
par(mfrow=c(3,1))

plot(MXL_ancestry$CEU, MXL_only$V1, main= "Comparação Inferência do Componente EUR", ylab="ADMIXTURE", xlab="PCA")
abline(0,1, col="red")

plot(MXL_ancestry$NAM, MXL_only$V3, main= "Comparação Inferência do Componente  NAM", ylab="ADMIXTURE", xlab="PCA")
abline(0,1, col="red")

plot(MXL_ancestry$YRI, MXL_only$V2, main= "Comparação Inferência do Componente  AFR", ylab="ADMIXTURE", xlab="PCA")
abline(0,1, col="red")


dev.off()
