## Roteiro


No diretório `./data`, temos um arquivo VCF com os genótipos do chr22 para todos
os indivíduos do projeto 1000 Genomas fase 3.

Vamos extrair a informação para os indivíduos da população YRI apenas.

Primeiro, vamos executar script `get_yri_sampleids.R` para extrair as IDs dos
indivíduos YRI do 1000 Genomas e salvar em um arquivo no diretório `./data`.

Então, vamos usar o script `run_vcftools.sh` para filtrar os dados apenas para
os indivíduos e tipo de variação genética de interesse.
