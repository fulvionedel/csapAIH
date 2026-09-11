# Estimativas populacionais para os municípios brasileiros.

Lê os arquivos com estimativas e contagens da população dos municípios
brasileiros por sexo e faixa etária disponibilizados pelo DATASUS.

## Usage

``` r
popbr(ano, uf = NULL, pormun = TRUE, municipio = NULL, idade = FALSE)
```

## Arguments

- ano:

  Ano ou vetor com os anos a serem lidos. Pode ser um arquivo armazenado
  no computador, ou ano(s) da estimativa ou contagem populacional a ser
  (em) capturado(s) no site FTP DATASUS. Se o alvo é um arquivo no
  computador, o nome com a extensão (dbf) deve vir entre aspas. Se o
  alvo é um arquivo do servidor FTP do DATASUS, deve-se usar o argumento
  `ano`, com o ano (sem aspas) desejado, de 1980 a 2025. Apenas arquivos
  em formato DBF são lidos.

- uf:

  Unidade(s) da Federação de interesse para seleção. O padrão é `NULL`,
  que seleciona todas.

- pormun:

  Se for selecionada uma (ou mais) UF, deve-se detalhar a população por
  município ou apresentar a população de toda UF? Argumento lógico,
  padrão é `FALSE`.

- municipio:

  Município(s) de interesse para seleção. O padrão é `NULL`, que
  seleciona todos.

- idade:

  Argumento lógico. Se TRUE, a idade detalhada é incluída como uma das
  variáveis. O padrão é FALSE.

## Examples

``` r
# Arquivos no diretório FTP do DATASUS
popbr(2025) |> head()
#> # A tibble: 6 × 5
#>   munic_res ano   sexo  fxetar5 populacao
#>   <chr>     <fct> <fct> <fct>       <int>
#> 1 110001    2025  masc  0-4           774
#> 2 110001    2025  masc  5-9           869
#> 3 110001    2025  masc  10-14         884
#> 4 110001    2025  masc  15-19         881
#> 5 110001    2025  masc  20-24         886
#> 6 110001    2025  masc  25-29         819
popbr(2025, idade = TRUE) |> head()
#>   munic_res  ano sexo fxetar5 fxetaria populacao
#> 1    110001 2025 masc     0-4      000       148
#> 2    110002 2025 masc     0-4      000       732
#> 3    110003 2025 masc     0-4      000        31
#> 4    110004 2025 masc     0-4      000       640
#> 5    110005 2025 masc     0-4      000       112
#> 6    110006 2025 masc     0-4      000        86
anos <- popbr(2017:2019)
xtabs(populacao ~ fxetar5 + sexo + ano, anos) |> ftable(col.vars = c("ano", "sexo"))
#>         ano     2017            2018            2019        
#>         sexo    masc     fem    masc     fem    masc     fem
#> fxetar5                                                     
#> 0-4          7498483 7148689 7492920 7143597 7458700 7111933
#> 5-9          7464194 7117371 7433861 7084208 7429405 7077260
#> 10-14        7914826 7561632 7799222 7447052 7696334 7348051
#> 15-19        8468595 8241877 8350778 8091938 8225283 7936624
#> 20-24        8420617 8428840 8404960 8384816 8400832 8347000
#> 25-29        8209257 8352359 8162951 8295079 8150148 8272246
#> 30-34        8394253 8663729 8334848 8588455 8255517 8493968
#> 35-39        8047502 8450130 8154840 8550108 8227095 8608339
#> 40-44        6959431 7389449 7140283 7576354 7347141 7792313
#> 45-49        6264462 6766366 6341828 6839156 6429381 6922507
#> 50-54        5749790 6348409 5824734 6426200 5888136 6487200
#> 55-59        4939435 5549971 5067999 5703333 5193015 5850910
#> 60-64        3962951 4550391 4098554 4712567 4234251 4874532
#> 65-69        2995964 3530408 3110989 3681482 3228543 3834603
#> 70-74        2098178 2581799 2199247 2707514 2303522 2840115
#> 75-79        1413441 1890520 1451821 1938389 1498484 1996507
#> 80 e +       1466442 2371796 1525720 2463235 1585447 2554757
popbr(c(2017, 2019))  |> str()
#> tibble [378,760 × 5] (S3: tbl_df/tbl/data.frame)
#>  $ munic_res: chr [1:378760] "110001" "110001" "110001" "110001" ...
#>  $ ano      : Factor w/ 2 levels "2017","2019": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sexo     : Factor w/ 2 levels "masc","fem": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ fxetar5  : Factor w/ 17 levels "0-4","5-9","10-14",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ populacao: int [1:378760] 931 952 1066 1113 1049 1002 944 892 831 824 ...
popbr(2022, "RS") |> head()
#> Joining with `by = join_by(CO_UF)`
#> # A tibble: 6 × 8
#>   munic_res ano   sexo  fxetar5 CO_UF UF_SIGLA REGIAO populacao
#>   <chr>     <fct> <fct> <fct>   <chr> <fct>    <fct>      <int>
#> 1 430003    2022  masc  0-4     43    RS       S            152
#> 2 430003    2022  masc  5-9     43    RS       S            144
#> 3 430003    2022  masc  10-14   43    RS       S            149
#> 4 430003    2022  masc  15-19   43    RS       S            137
#> 5 430003    2022  masc  20-24   43    RS       S            158
#> 6 430003    2022  masc  25-29   43    RS       S            145
popbr(2022, "RS", pormun = FALSE) |> head()
#> Joining with `by = join_by(CO_UF)`
#> # A tibble: 6 × 5
#>   UF_SIGLA ano   sexo  fxetar5 populacao
#>   <fct>    <fct> <fct> <fct>       <int>
#> 1 RS       2022  masc  0-4        332992
#> 2 RS       2022  masc  5-9        358783
#> 3 RS       2022  masc  10-14      340469
#> 4 RS       2022  masc  15-19      375186
#> 5 RS       2022  masc  20-24      409168
#> 6 RS       2022  masc  25-29      412695
popsul22 <- popbr(2022, c("PR", "SC", "RS"))
#> Joining with `by = join_by(CO_UF)`
xtabs(populacao ~ fxetar5 + sexo + UF_SIGLA, popsul22) |> ftable(col.vars = c("UF_SIGLA", "sexo"))
#>         UF_SIGLA     PR            RS            SC       
#>         sexo       masc    fem   masc    fem   masc    fem
#> fxetar5                                                   
#> 0-4              382144 364607 332992 318295 259043 246515
#> 5-9              408026 389679 358783 343872 264354 248916
#> 10-14            395202 379796 340469 325980 251680 236370
#> 15-19            419620 404710 375186 357608 254346 243043
#> 20-24            449224 438120 409168 397927 295535 286986
#> 25-29            455590 453892 412695 412060 327437 321532
#> 30-34            441122 445219 406216 410625 330721 324968
#> 35-39            435098 446045 420736 430153 329467 324421
#> 40-44            425228 447495 402997 422419 301337 304588
#> 45-49            380129 405845 353824 374396 256578 264575
#> 50-54            361564 393835 339255 369302 234435 248156
#> 55-59            328820 370786 340865 381822 219674 238277
#> 60-64            273658 316123 308006 352757 184400 204852
#> 65-69            212866 252593 247763 293148 138732 160231
#> 70-74            153716 188750 179978 228076  97231 118287
#> 75-79             99560 128957 113351 159458  60002  78453
#> 80 e +            94896 143777 106179 194145  52868  88807
popbr(2013, municipio = "430520") |> head()
#> # A tibble: 6 × 5
#>   munic_res ano   sexo  fxetar5 populacao
#>   <chr>     <fct> <fct> <fct>       <int>
#> 1 430520    2013  masc  0-4           405
#> 2 430520    2013  masc  5-9           431
#> 3 430520    2013  masc  10-14         478
#> 4 430520    2013  masc  15-19         520
#> 5 430520    2013  masc  20-24         534
#> 6 430520    2013  masc  25-29         532
popcap <- popbr(2013, municipio = c("431490", "420540"))
xtabs(populacao ~ fxetar5 + sexo + munic_res, popcap) |> ftable(col.vars = c("munic_res", "sexo"))
#>         munic_res 420540       431490      
#>         sexo        masc   fem   masc   fem
#> fxetar5                                    
#> 0-4                13191 12535  42357 40742
#> 5-9                12829 12426  44339 42336
#> 10-14              13955 13696  49130 47451
#> 15-19              17024 17105  52181 52188
#> 20-24              20745 20770  55518 57495
#> 25-29              23462 23161  61093 64512
#> 30-34              21936 22369  59813 65177
#> 35-39              18040 18873  50340 55543
#> 40-44              15411 16841  43702 50216
#> 45-49              14684 16882  43701 53085
#> 50-54              13607 16043  43193 54387
#> 55-59              11316 13659  38122 49545
#> 60-64               8852 10761  30515 41612
#> 65-69               6238  7617  22013 32110
#> 70-74               4079  5299  15234 24510
#> 75-79               2698  4042  10900 19897
#> 80 e +              2566  5318  11288 27395

# A estrutura do arquivo fonte até 2012 no DATASUS é outra,
# com outra categorização da "idade detalhada":
popbr(2012, idade = TRUE)  |> str()
#> 'data.frame':    367290 obs. of  7 variables:
#>  $ munic_res: chr  "110001" "110001" "110001" "110001" ...
#>  $ situacao : Factor w/ 1 level "urbana": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ ano      : Factor w/ 1 level "2012": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sexo     : Factor w/ 2 levels "masc","fem": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ fxetar5  : Factor w/ 17 levels "0-4","5-9","10-14",..: 1 1 1 1 1 2 2 2 2 2 ...
#>  $ fxetaria : Factor w/ 33 levels "0000","0101",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ populacao: int  187 186 187 190 193 198 204 211 219 226 ...
#>  - attr(*, "data_types")= chr [1:6] "C" "C" "C" "C" ...
popbr(2013, idade = TRUE)  |> str()
#> 'data.frame':    902340 obs. of  6 variables:
#>  $ munic_res: chr  "110001" "110001" "110001" "110001" ...
#>  $ ano      : Factor w/ 1 level "2013": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sexo     : Factor w/ 2 levels "masc","fem": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ fxetar5  : Factor w/ 17 levels "0-4","5-9","10-14",..: 1 1 1 1 1 2 2 2 2 2 ...
#>  $ fxetaria : Factor w/ 81 levels "000","001","002",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ populacao: int  201 204 202 198 197 195 201 210 220 226 ...
#>  - attr(*, "data_types")= chr [1:5] "C" "C" "C" "C" ...
# Por isso, quando a seleção de interesse contempla os dois períodos, como no exemplo seguinte,
# a faixa etária detalhada não é apresentada, e o argumento \code{idade} não tem efeito.
popbr(2012:2013) |> str()
#> tibble [378,590 × 5] (S3: tbl_df/tbl/data.frame)
#>  $ munic_res: chr [1:378590] "110001" "110001" "110001" "110001" ...
#>  $ ano      : Factor w/ 2 levels "2012","2013": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sexo     : Factor w/ 2 levels "masc","fem": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ fxetar5  : Factor w/ 17 levels "0-4","5-9","10-14",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ populacao: int [1:378590] 943 1058 1239 1343 1090 1039 938 866 901 835 ...
popbr(2012:2013, idade = TRUE) |> str()
#> tibble [378,590 × 5] (S3: tbl_df/tbl/data.frame)
#>  $ munic_res: chr [1:378590] "110001" "110001" "110001" "110001" ...
#>  $ ano      : Factor w/ 2 levels "2012","2013": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ sexo     : Factor w/ 2 levels "masc","fem": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ fxetar5  : Factor w/ 17 levels "0-4","5-9","10-14",..: 1 2 3 4 5 6 7 8 9 10 ...
#>  $ populacao: int [1:378590] 943 1058 1239 1343 1090 1039 938 866 901 835 ...
```
