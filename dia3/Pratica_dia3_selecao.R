#### Prática de Seleção Intra-específica ####

setwd("~/curso-genomica-evolutiva/dia3")

#### D Tajima ####

# Leia os arquivos gerados para o teste D de Tajima no R
AFR_TajimaD <- read.table("./dados/AFR_maf.Tajima.D", header=T)
EUR_TajimaD <- read.table("./dados/EUR_maf.Tajima.D", header=T)
EAS_TajimaD <- read.table("./dados/EAS_maf.Tajima.D", header=T)

# Familiarize-se com o formato do arquivo
head(AFR_TajimaD)

# Verifique se o SNP na posição 136608646 é um outlier em relação aos demais SNPs do cromossomo 2. 
# Para isso, siga os seguintes passos:

# 1) O teste de D de Tajima é realizando em janelas de SNPs. Identifique qual a janela que contém o SNP da posição 136608646
POS <- 136608646

POS_AFR <- max(which(AFR_TajimaD[,2]<=POS)) 
POS_EUR <- max(which(EUR_TajimaD[,2]<=POS))
POS_EAS <- max(which(EAS_TajimaD[,2]<=POS))

wind_tag <- POS_AFR # guardar esse informação

# 2) Faça gráficos com os resultados. 
# Como o dado analisado apresenta mais de 200.000 janelas, você pode plotar apenas 100 janelas adjacentes
SNP_FROM <- wind_tag - 100
SNP_TO <- wind_tag + 100

plot(x=EUR_TajimaD[SNP_FROM:SNP_TO,2], y=EUR_TajimaD[SNP_FROM:SNP_TO,4], type='l', lty=2, xlab="pos", ylab="TajD", col="green")
lines(x=EAS_TajimaD[SNP_FROM:SNP_TO,2], y=EAS_TajimaD[SNP_FROM:SNP_TO,4], type='l', col='red', lty=2)
lines(x=AFR_TajimaD[SNP_FROM:SNP_TO,2], y=AFR_TajimaD[SNP_FROM:SNP_TO,4], type='l', col='blue', lty=2)

# 3) Identifique no gráfico o SNP de interesse
points(x=EUR_TajimaD[wind_tag,2], y=EUR_TajimaD[wind_tag,4], pch=20, cex=1, col="green")
points(x=EAS_TajimaD[wind_tag,2], y=EAS_TajimaD[wind_tag,4], pch=20, cex=1, col='red')
points(x=AFR_TajimaD[wind_tag,2], y=AFR_TajimaD[wind_tag,4], pch=20, cex=1, col='blue')

# 3) Qual o valor de D de Tajima para o SNP de interesse em cada população?
AFR_TajimaD[wind_tag,4]
EAS_TajimaD[wind_tag,4]
EUR_TajimaD[wind_tag,4]

# 4) Por fim, identifique se o valor de D de Tajima para o SNP da posição 136608646 é um outlier em cada grupo populacional?

# Distribuição global do D de Tajima
TajD_DISTR <- sort(c(AFR_TajimaD[,4], EAS_TajimaD[,4], EUR_TajimaD[,4]), decreasing = FALSE)
plot(density(TajD_DISTR))
points(x=AFR_TajimaD[wind_tag,4], y=0, pch=20)
points(x=EAS_TajimaD[wind_tag,4], y=0)
points(x=EUR_TajimaD[wind_tag,4], y=0, pch=15)

# Distribuição por grupo populacional
TajD_DISTR_AFR <- sort(AFR_TajimaD[,4], decreasing = F)
plot(density(TajD_DISTR_AFR))
points(x=AFR_TajimaD[wind_tag,4], y=0, pch=15)

TajD_DISTR_EAS <- sort(EAS_TajimaD[,4], decreasing = F)
plot(density(TajD_DISTR_EAS))
points(x=EAS_TajimaD[wind_tag,4], y=0, pch=15)

TajD_DISTR_EUR <- sort(EUR_TajimaD[,4], decreasing = F)
plot(density(TajD_DISTR_EUR))
points(x=EUR_TajimaD[wind_tag,4], y=0, pch=15)

## Estimar p-valor para o SNP da posição 136608646 a partir da distribuição dos valores de D de Tajima

# distribuição global
p_value_out_AFR <- sum(TajD_DISTR>=AFR_TajimaD[wind_tag,4])/length(TajD_DISTR)
p_value_out_AFR
p_value_out_EAS <- sum(TajD_DISTR>=EAS_TajimaD[wind_tag,4])/length(TajD_DISTR)
p_value_out_EAS
p_value_out_EUR <- sum(TajD_DISTR>=EUR_TajimaD[wind_tag,4])/length(TajD_DISTR)
p_value_out_EUR

# distribuição por grupo populacional
p_value_out_AFR2 <- sum(TajD_DISTR_AFR>=AFR_TajimaD[wind_tag,4])/length(TajD_DISTR_AFR)
p_value_out_AFR2
p_value_out_EAS2 <- sum(TajD_DISTR_EAS>=EAS_TajimaD[wind_tag,4])/length(TajD_DISTR_EAS)
p_value_out_EAS2
p_value_out_EUR2 <- sum(TajD_DISTR_EUR>=EUR_TajimaD[wind_tag,4])/length(TajD_DISTR_EUR)
p_value_out_EUR2

#### FST ####

## vcftools (~30min)

# Leia os arquivos com as estimativas de FST (AFR_EUR.weir.fst, AFR_EAS.weir.fst e EAS_EUR.weir.fst)

names_header <- c("CHROM","POS","WEIR_AND_COCKERHAM_FST","NUM","DEN")

FST_AFR_EAS <- read.table("./dados/AFR_EAS_maf.weir.fst", header=F, skip=1, col.names=names_header)
FST_AFR_EUR <- read.table("./dados/AFR_EUR_maf.weir.fst", header=F, skip=1, col.names=names_header)
FST_EAS_EUR <- read.table("./dados/EAS_EUR_maf.weir.fst", header=F, skip=1, col.names=names_header)

# Elimine as posições duplicadas
FST_AFR_EAS_filter <- FST_AFR_EAS[!duplicated(FST_AFR_EAS$POS),]
FST_AFR_EUR_filter <- FST_AFR_EUR[!duplicated(FST_AFR_EUR$POS),]
FST_EAS_EUR_filter <- FST_EAS_EUR[!duplicated(FST_EAS_EUR$POS),]

# Familiarize-se com o formato do arquivo
head(FST_AFR_EAS_filter)
tail(FST_AFR_EAS_filter)

## A estimativa de FST por Weir e Cockerham, por vezes podem gerar valores negativos e Na o que isso significa?

# Excluir as posições cujo resultado do FST foi igual a Na
FST_AfrEas_data <- FST_AFR_EAS_filter[-which(is.na(FST_AFR_EAS_filter[,3])),]
FST_AfrEur_data <- FST_AFR_EUR_filter[-which(is.na(FST_AFR_EUR_filter[,3])),]
FST_EasEur_data <- FST_EAS_EUR_filter[-which(is.na(FST_EAS_EUR_filter[,3])),]


# Parear datasets
overlap_AfrEas_AfrEur <- FST_AfrEas_data[FST_AfrEas_data$POS %in% FST_AfrEur_data$POS,] 
overlap_AfrEasEur_EasEur <- overlap_AfrEas_AfrEur[overlap_AfrEas_AfrEur$POS %in% FST_EasEur_data$POS,]

FST_AfrEas_data_clean <- FST_AfrEas_data[FST_AfrEas_data$POS %in% overlap_AfrEasEur_EasEur$POS,]
FST_AfrEur_data_clean <- FST_AfrEur_data[FST_AfrEur_data$POS %in% overlap_AfrEasEur_EasEur$POS,]
FST_EasEur_data_clean <- FST_EasEur_data[FST_EasEur_data$POS %in% overlap_AfrEasEur_EasEur$POS,]


# Converter as posições com estimativas de FST < 0 para = 0
FST_AfrEas_data_clean[which(FST_AfrEas_data_clean[,3]<0),3] <- 0
FST_AfrEur_data_clean[which(FST_AfrEur_data_clean[,3]<0),3] <- 0
FST_EasEur_data_clean[which(FST_EasEur_data_clean[,3]<0),3] <- 0

## Agora que os dados estão filtrados e pareados, podemos inciar as análises

# Verifique se o SNP na posição 136608646 é um outlier em relação aos demais SNPs do cromossomo 2. Para isso, siga os seguintes passos:
POS <- 136608646

FST_AfrEas_data_clean[FST_AfrEas_data_clean$POS==POS,]
FST_AfrEur_data_clean[FST_AfrEur_data_clean$POS==POS,]
FST_EasEur_data_clean[FST_EasEur_data_clean$POS==POS,]

# 1) Construa a distribuícão dos valores de FST por quantil
FST_AfrEas_distr <- sort(FST_AfrEas_data_clean[,3])
FST_AfrEur_distr <- sort(FST_AfrEur_data_clean[,3])
FST_EasEur_distr <- sort(FST_EasEur_data_clean[,3])

FST_AfrEas_distrQT <- quantile(FST_AfrEas_distr, c(0.01, 0.05, 0.1, .25, .50,  .75, .90, 0.95, .99))
FST_AfrEas_distrQT

FST_AfrEur_distrQT <- quantile(FST_AfrEur_distr, c(0.01, 0.05, 0.1, .25, .50,  .75, .90, 0.95, .99))
FST_AfrEur_distrQT

FST_EasEur_distrQT <- quantile(FST_EasEur_distr, c(0.01, 0.05, 0.1, .25, .50,  .75, .90, 0.95, .99))
FST_EasEur_distrQT

# 2) Construa um gráfico para essa região delimitada de 10000 pares de bases adjacentes ao SNP da posição 136608646.

# Delimite a região de interesse para 10000 pares de bases adjacentes

SNPfrom_BP <- POS - 10000
SNPto_BP <- POS + 10000

# Identique quantos SNPs tem nessa região delimitada
SNPfrom_id_AfrEas <- max(which(FST_AfrEas_data_clean[,2]<=SNPfrom_BP))
SNPto_id_Afr_Eas <- min(which(FST_AfrEas_data_clean[,2]>=SNPto_BP))
length(FST_AfrEas_data_clean[SNPfrom_BP:SNPto_BP, 2])

SNPfrom_id_AfrEur <- max(which(FST_AfrEur_data_clean[,2]<=SNPfrom_BP))
SNPto_id_Afr_Eur <- min(which(FST_AfrEur_data_clean[,2]>=SNPto_BP))
length(FST_AfrEur_data_clean[SNPfrom_BP:SNPto_BP, 2])

SNPfrom_id_EasEur <- max(which(FST_EasEur_data_clean[,2]<=SNPfrom_BP))
SNPto_id_EasEur <- min(which(FST_EasEur_data_clean[,2]>=SNPto_BP))
length(FST_AfrEas_data_clean[SNPfrom_BP:SNPto_BP, 2])

# Selecione a partir do data.frame FST_AfrEur_data a região de interesse

FSTdata_SNP_AfrEas <- FST_AfrEas_data_clean[SNPfrom_id_AfrEas:SNPto_id_Afr_Eas, ]
head(FSTdata_SNP_AfrEas)

FSTdata_SNP_AfrEur <- FST_AfrEur_data_clean[SNPfrom_id_AfrEur:SNPto_id_Afr_Eur, ]

FSTdata_SNP_EasEur <- FST_EasEur_data_clean[SNPfrom_id_EasEur:SNPto_id_EasEur, ]

# Construa um gráfico 

## AfrEas
plot(ylim=c(0,1), x=FSTdata_SNP_AfrEas[,2], y=FSTdata_SNP_AfrEas[,3], xlab='pos', ylab='FST AFR EAS', pch=20, cex=0.2)

# Identifique o SNP da posição 136608646
points(x=FSTdata_SNP_AfrEas[which(FSTdata_SNP_AfrEas[,2]==POS),2],  y=FSTdata_SNP_AfrEas[which(FSTdata_SNP_AfrEas[,2]==POS),3], col='blue')

# Coloque no gráfico uma linha indicando o quartil .95
abline(h=FST_AfrEas_distrQT[[8]], lty=2)

## AfrEur
plot(ylim=c(0,1), x=FSTdata_SNP_AfrEur[,2], y=FSTdata_SNP_AfrEur[,3], xlab='pos', ylab='FST AFR EUR', pch=20, cex=0.2)

points(x=FSTdata_SNP_AfrEur[which(FSTdata_SNP_AfrEur[,2]==POS),2],  y=FSTdata_SNP_AfrEur[which(FSTdata_SNP_AfrEur[,2]==POS),3], col='blue')

abline(h=FST_AfrEur_distrQT[[8]], lty=2)

## EasEur
plot(ylim=c(0,1), x=FSTdata_SNP_EasEur[,2], y=FSTdata_SNP_EasEur[,3], xlab='pos', ylab='FST EAS EUR', pch=20, cex=0.2)

points(x=FSTdata_SNP_EasEur[which(FSTdata_SNP_EasEur[,2]==POS),2],  y=FSTdata_SNP_EasEur[which(FSTdata_SNP_EasEur[,2]==POS),3], col='blue')

abline(h=FST_AfrEur_distrQT[[8]], lty=2)


# O SNP da posição 136608646 pode ser considerado um SNP outlier em todas as populações? Qual a intepretação para esse resultado?
# Estimar p-valor para o SNP da posição 136608646 a partir da distribuição dos valores de FST

p_value_out_FST_AfrEas <- sum(FST_AfrEas_data_clean$WEIR_AND_COCKERHAM_FST>=FST_AfrEas_data_clean[FST_AfrEas_data_clean$POS==136608646,3])/nrow(FST_AfrEas_data_clean)
p_value_out_FST_AfrEas

p_value_out_FST_AfrEur <- sum(FST_AfrEur_data_clean$WEIR_AND_COCKERHAM_FST>=FST_AfrEur_data_clean[FST_AfrEur_data_clean$POS==136608646,3])/nrow(FST_AfrEur_data_clean)
p_value_out_FST_AfrEur

p_value_out_FST_EasEur <- sum(FST_EasEur_data_clean$WEIR_AND_COCKERHAM_FST>=FST_EasEur_data_clean[FST_EasEur_data_clean$POS==136608646,3])/nrow(FST_EasEur_data_clean)
p_value_out_FST_EasEur


#### PBS ####

# 1) Realize o teste de PBS, usando EUR como população candidata a seleção
PBS_EUR <- ((-log(1-FST_AfrEur_data_clean$WEIR_AND_COCKERHAM_FST))+(-log(1-FST_EasEur_data_clean$WEIR_AND_COCKERHAM_FST))-(-log(1-FST_AfrEas_data_clean$WEIR_AND_COCKERHAM_FST)))/2

PBS_EUR[which(PBS_EUR<0)] <- 0 # converter valores negativos para 0

## Crie uma tabela com as informações de posição, valores de FST entre os pares de população e os valores estimados de PBS.
fst_pbs<-as.data.frame(cbind(FST_EasEur_data_clean$POS, FST_AfrEas_data_clean$WEIR_AND_COCKERHAM_FST, FST_AfrEur_data_clean$WEIR_AND_COCKERHAM_FST, FST_EasEur_data_clean$WEIR_AND_COCKERHAM_FST, PBS_EUR), stringsAsFactors=FALSE)
head(fst_pbs)

# 2) Construa um gráfico para essa região delimitada de 10000 pares de bases adjacentes ao SNP da posição 136608646.

# Delimite a região de interesse para 10000 pares de bases adjacentes

SNP_FROM <- POS - 10000
SNP_TO <- POS + 10000

SNPfrom_PBS <- max(which(fst_pbs[,1]<=SNP_FROM))
SNPto_PBS <- min(which(fst_pbs[,1]>=SNP_TO))
length(fst_pbs[SNPfrom_PBS:SNPto_PBS, 1])

# Selecionar a região de interesse
subset_fst_PBS <- fst_pbs[SNPfrom_PBS:SNPto_PBS, ]
head(subset_fst_PBS)

# Construa um gráfico
plot(ylim=c(0,1), x=subset_fst_PBS[,1], y=subset_fst_PBS[,5], xlab='pos', ylab='PBS', pch=20, cex=0.2)

# Identifique o SNP da posição 136608646
points(x=subset_fst_PBS[which(subset_fst_PBS[,1]==POS),1],  y=subset_fst_PBS[which(subset_fst_PBS[,1]==POS),5], col='blue')

# Coloque no gráfico uma linha de corte indicando o quartil .95

PBS_distrQT <- quantile(PBS_EUR, c(0.01, 0.05, 0.1, .25, .50,  .75, .90, 0.95, .99))
PBS_distrQT # estimar os quantils

abline(h=PBS_distrQT[[8]], lty=2) # plotar a linha


## Com base nos três testes aplicados nesse exercício o que podemos concluir?


## As análises com base em um único SNP podem apresentam resultados espúrios.
## Uma maneira para evita-los é através da análise de um conjunto de SNPs adjacentes (janelas)
## Vamos aplicar essa abordagem aos nossos dados.


# Primeiro estimar o valor médio de FST por janela


## Slide Window function

slideFunct <- function(data, window, step){
        total <- length(data)
        spots <- seq(from = 1, to = (total - window + 1), by = step)
        result <- vector(length = length(spots))
        for(i in 1:length(spots)){
                result[i] <- mean(data[spots[i]:(spots[i] + window - 1)])
        }
        return(result)
}

### Ao invés de usar a média dos valores de FST, vamos fazer o FST razões das médias

head(FST_AfrEas_data_clean)

## Estimar a média em uma janela de 20 SNP para o numerador do FST (NUM)
num_AFR_EAS <- slideFunct(FST_AfrEas_data_clean$NUM, 20,15)
num_AFR_EUR <- slideFunct(FST_AfrEur_data_clean$NUM, 20,15)
num_EAS_EUR <- slideFunct(FST_EasEur_data_clean$NUM, 20,15)


## Estimar a média em uma janela de 20 SNP para o denominador do FST (NUM)
dem_AFR_EAS <- slideFunct(FST_AfrEas_data_clean$DEN,20,15)
dem_AFR_EUR <- slideFunct(FST_AfrEur_data_clean$DEN,20,15)
dem_EAS_EUR <- slideFunct(FST_EasEur_data_clean$DEN,20,15)


## Estimar o FST razões das médias (FST ratio of average)

fst_ratio_average_AFR_EAS <- num_AFR_EAS/dem_AFR_EAS
fst_ratio_average_AFR_EUR <- num_AFR_EUR/dem_AFR_EUR
fst_ratio_average_EAS_EUR <- num_EAS_EUR/dem_EAS_EUR

# Estimar o PBS por janela 
PBS_EUR <- ((-log(1-fst_ratio_average_AFR_EUR))+(-log(1-fst_ratio_average_EAS_EUR))-(-log(1-fst_ratio_average_AFR_EAS)))/2
PBS_EUR[which(PBS_EUR<0)] <- 0

## Identificar a posição inicial de cada janela
slidePos <- function(data, window, step){
        total <- length(data)
        spots <- seq(from = 1, to = (total - window + 1), by = step)
        result <- vector(length = length(spots))
        for(i in 1:length(spots)){
                result[i] <- data[spots[i]]
        }
        return(result)
}

pos_wind_AfrEas <- slidePos(FST_AfrEas_data_clean$POS, 20,15)
pos_wind_AfrEur <- slidePos(FST_AfrEur_data_clean$POS, 20,15)
pos_wind_EasEur <- slidePos(FST_EasEur_data_clean$POS, 20,15)

## Criar uma tabela para guardar a informação sobre posição, FST entre os pares de populações e PBS)
wind_pbs <- as.data.frame(cbind(pos_wind_AfrEas, fst_ratio_average_AFR_EAS, fst_ratio_average_AFR_EUR, fst_ratio_average_EAS_EUR, PBS_EUR), stringsAsFactors=FALSE)
head(wind_pbs)

# Recuperar a janela que contém o SNP de interesse
Row_WIND_PBS <- max(which(wind_pbs[,1]<=POS)) 
POS_WIND_PBS <-wind_pbs[Row_WIND_PBS,1]

# Plotar o gráfico
plot(ylim=c(0,1), x=wind_pbs[,1], y=wind_pbs[,5], xlab='pos', ylab='PBS windows', pch=20, cex=0.2)
points(x=wind_pbs[which(wind_pbs[,1]==POS_WIND_PBS),1],  y=wind_pbs[which(wind_pbs[,1]==POS_WIND_PBS),5], col='red')

# Distribuir os valores de PBS em quantils
windPBS_distrQT <- quantile(wind_pbs$PBS_EUR, c(0.01, 0.05, 0.1, .25, .50,  .75, .90, 0.95, .99))
windPBS_distrQT

# Plotar a linha de corte para o quantil
abline(h=windPBS_distrQT[[8]], lty=2)
