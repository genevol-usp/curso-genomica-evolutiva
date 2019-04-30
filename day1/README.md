## Roteiro


No diretório `./data`, temos um arquivo VCF com os genótipos do chr22 para todos
os indivíduos do projeto 1000 Genomas fase 3.

Vamos extrair a informação para os indivíduos da população YRI apenas.

Primeiro, vamos executar script `get_yri_sampleids.R` para extrair as IDs dos
indivíduos YRI do 1000 Genomas e salvar em um arquivo no diretório `./data`.

Então, vamos usar o script `run_hwe.sh` para filtrar os dados apenas para
os indivíduos e tipo de variação genética de interesse, e então calcular HWE.

Os seguintes arquivos de resultado serão salvos em `./data`:

- VCF com indivíduos YRI, variantes bialélicas, com MAF > 5%
- Arquivo de frequências alélicas
- Arquivo com resultados da computação de HWE


## Roteiro atualizado

- Iniciar com intro de vcf
- Usar vcf tools para descrever HW de modo geral no cromossomo 21 (fazer isso entre nós, preparar roteiro), usando hardy
- fazer no Rstudio no servidor.
- identificar região com desvio (requer transferÊncia para local, para usar R).
- extrair trecho do braço curto que ilustra desvio
- Vitor bolar exemplos que encaminhem o processo de gerar os plots de HW

- leitura do artigo Bruce e Jan

$ X^2 $ and $\delta$ 

