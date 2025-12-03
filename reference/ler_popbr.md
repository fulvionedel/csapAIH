# Ler arquivos de população do DATASUS

Lê os arquivos com estimativas e contagens da população dos municípios
brasileiros por sexo e faixa etária disponibilizados pelo DATASUS e
entrega um banco de dados com as variáveis originais mais a faixa etária
quinquenal.

## Usage

``` r
ler_popbr(x)
```

## Arguments

- x:

  Nome do arquivo armazenado no computador, ou ano da estimativa ou
  contagem populacional a ser capturada no site FTP DATASUS. Se o alvo é
  um arquivo no computador, o nome com a extensão (dbf) deve vir entre
  aspas. Apenas arquivos em formato DBF são lidos. Se o alvo é um
  arquivo do servidor FTP do DATASUS, deve-se digitar o ano (sem aspas)
  desejado, de 1980 a 2024.

## Details

Nos arquivos de 2013 a 2024 o código IBGE do município está registrado
com todos os sete dígitos, enquanto nos arquivos de 1980 a 2012, como em
outros SIS com dados disponibilizados pelo DATASUS, são registrados
apenas os seis primeiros dígitos do código. `ler_popbr` devolve uma
variável (`munic_res`) de caracteres com os seis primeiros dígitos.

Os bancos de dados de origem têm uma estrutura até 2012, com a variável
"situação" (urbano/rural) para alguns anos e a faixa etária detalhada
(variável "fxetaria") em um campo de quatro dígitos com faixas anuais
até os 20 anos e então quinquenais até 80 e mais anos de idade, enquanto
os arquivos a partir de 2013 não têm a variável "situação" e a variável
"fxetaria" é um campo com três dígitos com a idade em anos completos até
os 79 anos e então 80 e mais anos de idade.

A função será descontinuada em favor de
[`popbr`](https://fulvionedel.github.io/csapAIH/reference/popbr.md), que
permite a captura de períodos maiores de um ano e oferece opções para o
`data frame` resultante.

As informações atualizadas podem ser tabuladas em
http://tabnet.datasus.gov.br/cgi/deftohtm.exe?ibge/cnv/popsvs2024br.def

## References

http://tabnet.datasus.gov.br/cgi/IBGE/SEI_MS-0034745983-Nota_Tecnica_final.pdf

## Examples

``` r
if (FALSE) { # \dontrun{
# Um arquivo no computador:
popBR2010 <- ler_popbr("data-raw/POPBR10.DBF")
head(popBR2010)
xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)

popBR2024 <- ler_popbr("data-raw/POPBR24.DBF")
head(popBR2024)
xtabs(populacao ~ fxetar5 + sexo, data = popBR2024)
} # }

# Um arquivo no diretório FTP do DATASUS
popBR2010 <- ler_popbr(2010)
head(popBR2010)
#>   munic_res situacao  ano sexo fxetar5 fxetaria populacao
#> 1    110001   urbana 2010 masc     0-4     0000       100
#> 2    110001   urbana 2010 masc     0-4     0101        92
#> 3    110001   urbana 2010 masc     0-4     0202        95
#> 4    110001   urbana 2010 masc     0-4     0303       131
#> 5    110001   urbana 2010 masc     0-4     0404       107
#> 6    110001   urbana 2010 masc     5-9     0505       125
xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)
#>         sexo
#> fxetar5     masc     fem
#>   0-4    7016987 6779172
#>   5-9    7624144 7345231
#>   10-14  8725413 8441348
#>   15-19  8558868 8432002
#>   20-24  8630227 8614963
#>   25-29  8460995 8643418
#>   30-34  7717657 8026855
#>   35-39  6766665 7121916
#>   40-44  6320570 6688797
#>   45-49  5692013 6141338
#>   50-54  4834995 5305407
#>   55-59  3902344 4373875
#>   60-64  3041034 3468085
#>   65-69  2224065 2616745
#>   70-74  1667373 2074264
#>   75-79  1090518 1472930
#>   80 e + 1133122 1802463

popBR2013 <- ler_popbr(2013)
head(popBR2013)
#>   munic_res  ano sexo fxetar5 fxetaria populacao
#> 1    110001 2013 masc     0-4      000       201
#> 2    110001 2013 masc     0-4      001       204
#> 3    110001 2013 masc     0-4      002       202
#> 4    110001 2013 masc     0-4      003       198
#> 5    110001 2013 masc     0-4      004       197
#> 6    110001 2013 masc     5-9      005       195
xtabs(populacao ~ fxetar5 + sexo, data = popBR2013)
#>         sexo
#> fxetar5     masc     fem
#>   0-4    7463884 7121178
#>   5-9    7805624 7454699
#>   10-14  8426065 8138707
#>   15-19  8644694 8561467
#>   20-24  8412732 8488814
#>   25-29  8524675 8724932
#>   30-34  8310811 8648899
#>   35-39  7282908 7660500
#>   40-44  6497525 6928918
#>   45-49  6021673 6540506
#>   50-54  5313955 5850019
#>   55-59  4391704 4896250
#>   60-64  3437752 3903087
#>   65-69  2536782 2951155
#>   70-74  1804579 2228456
#>   75-79  1248516 1687030
#>   80 e + 1268870 2049336

popBR2024 <- ler_popbr(2024)
head(popBR2024)
#>   munic_res  ano sexo fxetar5 fxetaria populacao
#> 1    110001 2024 masc     0-4      000       158
#> 2    110001 2024 masc     0-4      001       159
#> 3    110001 2024 masc     0-4      002       161
#> 4    110001 2024 masc     0-4      003       163
#> 5    110001 2024 masc     0-4      004       168
#> 6    110001 2024 masc     5-9      005       176
xtabs(populacao ~ fxetar5 + sexo, data = popBR2024)
#>         sexo
#> fxetar5     masc     fem
#>   0-4    6661380 6356612
#>   5-9    7439000 7092027
#>   10-14  7429136 7076552
#>   15-19  7651069 7320566
#>   20-24  8044783 7821129
#>   25-29  8193616 8219079
#>   30-34  7992515 8181015
#>   35-39  8115656 8419414
#>   40-44  8073611 8525842
#>   45-49  7171760 7693627
#>   50-54  6215140 6798626
#>   55-59  5603775 6318206
#>   60-64  4833395 5622638
#>   65-69  3806961 4582309
#>   70-74  2768674 3500843
#>   75-79  1840490 2463099
#>   80 e + 1821325 2929880
```
