# Classificar códigos da CID-10 em Condições Sensíveis à Atenção Primária

``` r
library(csapAIH)
library(dplyr)
```

## Em arquivos de dados

É possível classificar as CSAP diretamente a partir de arquivos com
extensão .DBC, .DBF, ou .CSV, sem necessidade da leitura prévia dos
dados. Para outras extensões de arquivo é necessária a prévia importação
dos dados para um objeto de classe `data.frame`.

#### Arquivos do DATASUS

Através de seu site FTP, o DATASUS disponibiliza dados de diferentes
Sistemas de Informação em Saúde do SUS, em arquivos comprimidos de
extensão DBC. Os arquivos podem ser baixados na página de [transferência
de arquivos](https://datasus.saude.gov.br/transferencia-de-arquivos/) do
DATASUS e expandidos para DBF ou CSV (entre várias outras possibilidades
de manejo) pelo TabWin, disponível na mesma página. Graças ao pacote
[read.dbc](https://github.com/danicat/read.dbc), de Daniela Petruzalek,
também podemos ler os arquivos comprimidos do DATASUS no R, e graças ao
pacote [microdatasus](https://github.com/rfsaldanha/microdatasus), de
Raphael Saldanha \[@Saldanha2019\], podemos ler com facilidade esses
arquivos na internet, sem necessidade de download.

O código abaixo cria um banco com as informações das AIHs do “ano de
competência” 2021 ocorridas no RS e outro com as informações das
Declarações de Óbito (DO) de residentes no RS ocorridas em 2021:

``` r
# remotes::install_github("rfsaldanha/microdatasus") # desnecessário se o pacote estiver instalado
AIHRS2021 <- microdatasus::fetch_datasus(year_start = 2021, 1, 2021, 12, uf = "RS", information_system = "SIH-RD")
nrow(AIHRS2021) # linhas
[1] 709893
ncol(AIHRS2021) # colunas
[1] 113

DORS2021 <- microdatasus::fetch_datasus(year_start = 2021, year_end = 2021, uf = "RS", information_system = "SIM-DO")
nrow(DORS2021)
[1] 117722
ncol(DORS2021)
[1] 87
```

Se o arquivo de dados estiver armazenado no computador, basta digitar,
entre aspas, o nome do arquivo — com o “*path*” se o arquivo estiver em
diretório diferente daquele da sessão de trabalho ativa (neste exemplo,
num sub-diretório do diretório de trabalho da sessão ativa, chamado
‘data-raw’).

``` r
csap.dbc <- csapAIH("../../data-raw/RDRS1801.dbc")
csap.dbf <- csapAIH("../../data-raw/RDRS1801.dbf")
```

- No caso de arquivos CSV é mandatório indicar o tipo de separador de
  campos, com o argumento `sep`.

``` r
csap.csv <- csapAIH("../../data-raw/RDRS1801.csv", sep = ",")
```

A função `fetchcsap` foi pensada para apresentar um extrato dos
registros por período de internação e não de “competência” da AIH, que é
commo se organizam os arquivos de dados. Assim, precisamos modificar
alguns argumentos para ter os mesmos registros:

``` r
csap.ftp <- fetchcsap(2018, mesfim = 1, uf = 'RS', periodo = "competencia")
```

Os extratos são iguais:

``` r
all.equal(attributes(csap.dbc)$resumo, attributes(csap.dbf)$resumo)
[1] TRUE
all.equal(attributes(csap.dbc)$resumo, attributes(csap.csv)$resumo)
[1] TRUE
all.equal(attributes(csap.ftp)$resumo, attributes(csap.dbc)$resumo)
[1] TRUE
```

Mas em estudos epidemiológicos geralmente nos interessa delimitar a
população pela data de internação, o que exige trabalho posterior à
leitura do arquivo “RD”, pois o arquivo de um determinado mês e ano de
“competência” pode conter registros de internações ocorridas em outro
momento. Vemos abaixo que a data de internação nos objetos criados
anteriormente (a partir de “RDRS1801.dbc”) varia de 01Aug2017 a
31Oct2017. Além disso, o arquivo pode não conter o registro de todas as
internações ocorridas naquele mês.

Por isso `fetchcsap` tem seus argumentos de forma a devolver o banco de
dados apenas com os registros do período de interesse. Veja a seguir o
resultado com as internações não-obstétricas para jan2018 segundo a
seleção dos registros:  
a. todos daquele mês de competência (mesmo comando anterior para a
construção de csap.ftp”); b. apenas as internações ocorridas no mesmo
mês de competência da AIH; e c. apenas as internações ocorridas em
jan2018 e registradas nos arquivos “RD” dos meses de competência janeiro
a fevereiro de 20018.

``` r
a <- fetchcsap(2018, mesfim = 1, uf = 'RS', periodo = "c")
nrow(a)
[1] 51923
summary(a$data.inter)
        Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
"2017-06-06" "2017-12-08" "2017-12-28" "2017-12-20" "2018-01-10" "2018-01-31" 
b <- fetchcsap(2018, mesfim = 1, uf = 'RS')
nrow(b)
[1] 53757
summary(b$data.inter)
        Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
"2018-01-01" "2018-01-08" "2018-01-16" "2018-01-16" "2018-01-24" "2018-01-31" 
c <- fetchcsap(2018, mesfim = 2, uf = 'RS')
nrow(c)
[1] 100164
summary(c$data.inter)
        Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
"2018-01-01" "2018-01-15" "2018-01-30" "2018-01-29" "2018-02-14" "2018-02-28" 
```

``` r
# Limpar o ambiente de trabalho, renomear um dos bancos de dados:
csap <- csap.ftp
rm(csap.csv, csap.dbc, csap.dbf, csap.ftp)
```

### Em um banco de dados existente na sessão de trabalho

#### Com a estrutura dos arquivos da AIH

``` r
read.csv("../../data-raw/RDRS1801.csv") |> # criar o data.frame
  csapAIH() |>
  str()
'data.frame':   55119 obs. of  16 variables:
 $ n.aih     : chr  "4318100063695" "4318100349508" "4318100349563" "4318100349662" ...
  ..- attr(*, "label")= chr "No. da AIH"
 $ munres    : int  431340 430450 430450 430450 430450 430450 430450 430450 430450 430060 ...
  ..- attr(*, "label")= chr "Municipio de residencia"
 $ munint    : int  431080 430450 430450 430450 430450 430450 430450 430450 430450 430060 ...
  ..- attr(*, "label")= chr "Municipio de internacao"
 $ sexo      : Factor w/ 2 levels "masc","fem": 1 2 2 2 1 1 1 1 2 1 ...
  ..- attr(*, "label")= chr "Sexo"
 $ nasc      : Date, format: "55633-04-16" "56511-08-19" ...
 $ idade     : num  58 25 24 33 80 69 50 58 70 69 ...
  ..- attr(*, "comment")= chr "em anos completos"
  ..- attr(*, "label")= chr "Idade"
 $ fxetar.det: Factor w/ 33 levels "<1ano"," 1ano",..: 28 22 21 23 33 30 27 28 31 30 ...
  ..- attr(*, "label")= chr "Faixa etaria detalhada"
 $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 12 6 5 7 17 14 11 12 15 14 ...
  ..- attr(*, "label")= chr "Faixa etaria quinquenal"
 $ csap      : chr  "não" "não" "não" "não" ...
  ..- attr(*, "label")= chr "CSAP"
 $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 20 20 12 3 20 20 13 9 ...
  ..- attr(*, "label")= chr "Grupo de causa CSAP"
 $ cid       : chr  "K439" "O628" "O641" "O623" ...
 $ proc.rea  : int  407040064 411010034 411010034 303100044 303040149 303020059 303060239 308020022 303030038 303060182 ...
  ..- attr(*, "label")= chr "Procedimento realizado"
 $ data.inter: Date, format: "57221-04-11" "57221-03-29" ...
 $ data.saida: Date, format: "57221-04-13" "57221-03-31" ...
 $ cep       : int  93544360 96600000 96600000 96600000 96600000 96600000 96600000 96600000 96600000 94834152 ...
  ..- attr(*, "label")= chr "Codigo de Enderecamento Postal"
 $ cnes      : int  2232189 2232928 2232928 2232928 2232928 2232928 2232928 2232928 2232928 2232081 ...
  ..- attr(*, "label")= chr "No. do hospital no CNES"
 - attr(*, "resumo")='data.frame':  4 obs. of  4 variables:
  ..$ acao  : chr [1:4] "Importados" "Excluídos \t" "Excluídos \t" "Exportados"
  ..$ freq  : num [1:4] 60529 5044 366 55119
  ..$ perc  : num [1:4] 100 8.3 0.6 91.1
  ..$ objeto: chr [1:4] "registros." "registros de procedimentos obstétricos." "registros de AIH de longa permanência." "registros."
```

#### Sem o padrão dos arquivos da AIH

Mude o argumento `sihsus` para `FALSE` e indique no argumento `cid` qual
variável contém os códigos diagnósticos. As variáveis `csap` e `grupo`
(se `csapAIH(..., grupos = TRUE, ...)`) são acrescentadas ao final do
banco de dados alvo da função.

##### A *Encuesta de Egresos Hospitalarios* do Equador.

``` r
data("eeh20") # Amostra da "Encuesta de egresos hospitalarios" do Equador, ano 2020
names(eeh20) # Os nomes das variáveis
 [1] "prov_ubi"   "cant_ubi"   "parr_ubi"   "area_ubi"   "clase"     
 [6] "tipo"       "entidad"    "sector"     "mes_inv"    "nac_pac"   
[11] "cod_pais"   "nom_pais"   "sexo"       "cod_edad"   "edad"      
[16] "etnia"      "prov_res"   "area_res"   "anio_ingr"  "mes_ingr"  
[21] "dia_ingr"   "fecha_ingr" "anio_egr"   "mes_egr"    "dia_egr"   
[26] "fecha_egr"  "dia_estad"  "con_egrpa"  "esp_egrpa"  "cau_cie10" 
[31] "cant_res"   "parr_res"   "causa3"     "cap221rx"   "cau221rx"  
[36] "cau298rx"  
```

A variável `cau_cie10` (posição 30) tem o código do diagnóstico de
internação. A função csapAIH acrescenta à base duas (se `grupo == TRUE`)
variáveis, `csap` e `grupo`, dispostas nas últimas colunas (posição e
respectivamente.)

``` r
csap.eeh20 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10)
names(csap.eeh20)
 [1] "prov_ubi"   "cant_ubi"   "parr_ubi"   "area_ubi"   "clase"     
 [6] "tipo"       "entidad"    "sector"     "mes_inv"    "nac_pac"   
[11] "cod_pais"   "nom_pais"   "sexo"       "cod_edad"   "edad"      
[16] "etnia"      "prov_res"   "area_res"   "anio_ingr"  "mes_ingr"  
[21] "dia_ingr"   "fecha_ingr" "anio_egr"   "mes_egr"    "dia_egr"   
[26] "fecha_egr"  "dia_estad"  "con_egrpa"  "esp_egrpa"  "cau_cie10" 
[31] "cant_res"   "parr_res"   "causa3"     "cap221rx"   "cau221rx"  
[36] "cau298rx"   "csap"       "grupo"     
csap.eeh20[c(30,37:38)] |>
  head(3)
  cau_cie10 csap    grupo
1      C169  não nao-CSAP
2      U072  não nao-CSAP
3      A090  sim      g02
```

##### A Declaração de Óbito (DO) do SIM

A variável `CAUSABAS` tem o código da causa básica do óbito.

De modo semelhante à AIH, as bases de dados da DO também têm a idade
codificada e não a verdadeira idade da pessoa. Por exemplo, a variável
`IDADE` em `DORS2021` é um `factor` com 0 níveis, em que o primeiro é e
o último é . Neste caso podemos usar a função `idadeSUS` para computar a
idade, mas como o resultado de `idadeSUS` é “um objeto da classe data
frame com três variáveis” (v.
[`?idadeSUS`](https://fulvionedel.github.io/csapAIH/reference/idadeSUS.md)),
necessitamos a função `unnest` (de `tidyr`) para desagrupar as variáveis
antes de inseri-las em `DORS2021`. Além disso, foi excluída (com
`unnest(...)[-2]`) a “faixa etária detalhada”, que é a segunda variável
no output de `idadeSUS`.

``` r
DORS2021 <- DORS2021 %>%
  csapAIH(sihsus = FALSE, cid = CAUSABAS, parto.rm = FALSE) %>%
  mutate(tidyr::unnest(idadeSUS(DORS2021, sis = "SIM"), cols = c())[-2],
         fxetar3 = fxetar3g(idade),
         SEXO = factor(SEXO, levels = c(1,2), labels = c("masc", "fem")))
DORS2021[1:3, (ncol(DORS2021)-5):ncol(DORS2021)]
  CONTADOR csap    grupo idade fxetar5 fxetar3
1        1  não nao-CSAP    49   45-49   15-59
2        2  não nao-CSAP    41   40-44   15-59
3        3  não nao-CSAP    78   75-79    60e+
```

### A partir de uma variável com códigos da CID-10:

``` r
cids <- aih100$DIAG_PRINC[1:10]
cids
 [1] N189 O689 S423 H938 P584 I200 I442 C189 C409 K818
3254 Levels: A009 A020 A044 A045 A048 A049 A050 A058 A059 A061 A069 A071 ... Z990
csapAIH(cids)
    cid csap    grupo
1  N189  não nao-CSAP
2  O689  não nao-CSAP
3  S423  não nao-CSAP
4  H938  não nao-CSAP
5  P584  não nao-CSAP
6  I200  sim      g10
7  I442  não nao-CSAP
8  C189  não nao-CSAP
9  C409  não nao-CSAP
10 K818  não nao-CSAP
```
