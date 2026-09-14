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
if (FALSE) { # \dontrun{
anos <- popbr(2017:2019)
xtabs(populacao ~ fxetar5 + sexo + ano, anos) |> ftable(col.vars = c("ano", "sexo"))
popbr(c(2017, 2019))  |> str()
popbr(2022, "RS") |> head()
popbr(2022, "RS", pormun = FALSE) |> head()
popsul22 <- popbr(2022, c("PR", "SC", "RS"))
xtabs(populacao ~ fxetar5 + sexo + UF_SIGLA, popsul22) |> ftable(col.vars = c("UF_SIGLA", "sexo"))
popbr(2013, municipio = "430520") |> head()
popcap <- popbr(2013, municipio = c("431490", "420540"))
xtabs(populacao ~ fxetar5 + sexo + munic_res, popcap) |> ftable(col.vars = c("munic_res", "sexo"))
} # }

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
