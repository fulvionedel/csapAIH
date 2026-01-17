# Baixa os arquivos da AIH e classifica as internações em CSAP

Descarrega os "arquivos da AIH" (arquivos RD\<UFAAMM\>.DBC das Bases de
Dados do Sistema de Informações Hospitalares do SUS - BD-SIH/SUS) do
site FTP do DATASUS e classifica as internações segundo a Lista
Brasileira de Condições Sensíveis à Atenção Primária.

## Usage

``` r
fetchcsap(
  anoinicio,
  anofim = NULL,
  mesinicio = 1,
  mesfim = NULL,
  uf = "all",
  regiao = NULL,
  periodo = "interna",
  cep = FALSE,
  cnes = FALSE,
  ...
)
```

## Arguments

- anoinicio:

  Ano de competência da AIH para início da seleção dos dados, em formato
  numérico; sem padrão.

- anofim:

  Ano de competência da AIH para fim da seleção dos dados, em formato
  numérico; por padrão é igual ao ano seguinte ao ano de início
  (`anoinicio + 1`).

- mesinicio:

  Mês de competência da AIH para início da seleção dos dados, em formato
  numérico; por padrão é 1.

- mesfim:

  Mês de competência da AIH para fim da seleção dos dados, em formato
  numérico; por padrão é 6 (junho). V. detalhes.

- uf:

  Unidade da Federação. A sigla da UF ou um vetor com as siglas das UF
  de interesse, entre aspas e em letras maiúsculas. Para todo o Brasil
  (padrão), use "all".

- regiao:

  Região administrativa do Brasil ("Grandes Regiões"). O padrão é
  `NULL`. Se usado, deve ser uma entre "N", "NE", "SE", "S" e "CO".

- periodo:

  O período definido refere-se ao mês e ano de "competência" da AIH ou à
  data de internação? O padrão (`"interna"`) é a internação. V.
  detalhes.

- cep:

  CEP de internação.

- cnes:

  Código CNES do estabelecimento que gerou a AIH.

- ...:

  Permite o uso de outros parâmetros de
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md).

## Value

Um objeto de classes `data.table` e `data.frame` com as seguintes
variáveis:

- `munres` Município de residência do paciente

- `munint` Município de internação do paciente

- `sexo` Sexo do paciente

- `idade` Idade do paciente em anos completos

- `fxetar5` Faixa etária quinquenal (0-4, ..., 76-79, 80 e +)

- `csap` Internação por CSAP (sim/não)

- `grupo` Grupo de causa da Lista Brasileira de ICSAP, ou "não-CSAP"

- `cid` Diagnóstico principal da internação, segundo a Classificação
  Internacional de Doenças, 10ª Revisão

- `data.inter` Data da internação

- `data.saida` Data da alta

## Details

\- Período de download dos arquivos e de internação dos sujeitos.

- Os "arquivos da AIH" são definidos por mês e ano de "competência", e
  não da data de internação. Assim, o arquivo de um determinado "mês de
  competência" pode incluir registros de internações ocorridas em outro
  mês ou ano, enquanto pode não incluir todos os casos ocorridos naquele
  mês. Por padrão, `fetchcsap` usa o argumento `periodo = "interna"`
  para selecionar os casos por data de internação de acordo com o
  período definido nos argumentos `anoinicio`, `mesinicio` e `anofim`,
  de modo a iniciar no primeiro dia do ano e mês de competência
  (`anoinicio` e `mesinicio`) e terminar em 31 de dezembro do ano
  anterior ao definido em `anofim`.

- Assim, por padrão, a função exige apenas a definição do ano de início
  dos casos. Se o usuário definir apenas esse argumento, `fetchcsap`
  fará o download e leitura dos arquivos (de todo o Brasil) de todos os
  meses até junho do ano seguinte para então selecionar as internações
  ocorridas no ano definido em `anoinicio`.

\- `fetchcsap` é apenas uma abreviatura para um uso específico da função
[fetch_datasus](https://rfsaldanha.github.io/microdatasus/reference/fetch_datasus.html),
do pacote `microdatasus`, de Raphael Saldanha. Funciona apenas com o
SIH/SUS, através do argumento `information_system = "SIH-RD"`, e faz
apenas o download das variáveis exigidas pela função `csapAIH`, i.e.,
`DIAG_PRINC, NASC, DT_INTER, DT_SAIDA, IDADE, COD_IDADE, MUNIC_RES, MUNIC_MOV, SEXO, N_AIH, PROC_REA, IDENT, CEP, CNES`.

## See also

[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
[`fetch_datasus`](https://rfsaldanha.github.io/microdatasus/reference/fetch_datasus.html)

## Examples

``` r
# Internações de todo o Brasil, ocorridas no ano de 2023 e registradas até jun/2024:
# Colocando apenas o ano, único argumento obrigatório, a função executa o
# download dos arquivos RD??????.DBC de todas as UF de jan/2023 a jun/2024 e
# então extrais apenas os registros com data de internação em 2023.
if (FALSE) { # \dontrun{
  fetchcsap(2023)
} # }
# Diferença entre o mês e ano de "competência" da AIH e a data de internação da pessoa,
# exemplo com as internações no Acre:
# - todas as internações registradas no mês de competência jan 2023:
ac.comp <- fetchcsap(2023, uf = "AC", mesfim = 1, periodo = 'competencia')
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> Importados 4.165 registros.
#> Excluídos 1.179 (28,3%) registros de procedimentos obstétricos.
#> Excluídos 1 (0%) registros de AIH de longa permanência.
#> Exportados 2.985 (71,7%) registros.
nrow(ac.comp)
#> [1] 2985
summary(ac.comp$data.inter)
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#> "2022-07-17" "2022-11-27" "2022-12-26" "2022-12-14" "2023-01-10" "2023-01-31" 
# - internações ocorridas em jan/2023 e registradas nos meses de competência
# janeiro a junho de 2023:
ac.int <- fetchcsap(2023, mesfim = 1, uf = "AC")
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> Importados 4.628 registros.
#> Excluídos 1.253 (27,1%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 3.375 (72,9%) registros.
nrow(ac.int)
#> [1] 3375
summary(ac.int$data.inter)
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#> "2023-01-01" "2023-01-09" "2023-01-16" "2023-01-16" "2023-01-24" "2023-01-31" 
# Assim, há
nrow(ac.comp) - nrow(ac.int)
#> [1] -390
# internações registradas naquele mês de competência, mas que ocorreram antes.

# Internações ocorridas na Região Norte no mês de janeiro de 2023 e registradas naquele mês:
fetchcsap(2023, mesfim = 1, regiao = "N")
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> Importados 90.711 registros.
#> Excluídos 20.833 (23%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 69.878 (77%) registros.
#>        munres munint   sexo idade fxetar5   csap    grupo    cid data.inter
#>        <char> <char> <fctr> <num>  <fctr> <fctr>   <fctr> <char>     <Date>
#>     1: 110020 110020   masc    31   30-34    não nao-CSAP   N288 2023-01-17
#>     2: 110020 110020    fem    63   60-64    sim      g08   J441 2023-01-03
#>     3: 110020 110020   masc    68   65-69    sim      g12    I64 2023-01-05
#>     4: 110020 110020   masc    34   30-34    não nao-CSAP    B24 2023-01-21
#>     5: 110020 110020    fem    49   45-49    sim      g01   B518 2023-01-23
#>    ---                                                                     
#> 69874: 171820 171820    fem    86  80 e +    não nao-CSAP    J18 2023-01-08
#> 69875: 170755 171820   masc    87  80 e +    não nao-CSAP    J18 2023-01-27
#> 69876: 171870 171610   masc    58   55-59    sim      g13   E145 2023-01-25
#> 69877: 171610 171610   masc     9     5-9    sim      g15   N390 2023-01-31
#> 69878: 170210 170210    fem     0     0-4    não nao-CSAP   K564 2023-01-11
#>        data.saida
#>            <Date>
#>     1: 2023-01-20
#>     2: 2023-01-06
#>     3: 2023-01-12
#>     4: 2023-01-31
#>     5: 2023-01-31
#>    ---           
#> 69874: 2023-05-14
#> 69875: 2023-02-06
#> 69876: 2023-02-03
#> 69877: 2023-02-01
#> 69878: 2023-01-11

# Internações anteriores a 2008 têm aviso de
# "arquivos antigos, que podem conter códigos incompatíveis"
fetchcsap(2008, uf = "AC")
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> Importados 49.010 registros.
#> Excluídos 14.968 (30,5%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 34.042 (69,5%) registros.
#>        munres munint   sexo idade fxetar5   csap    grupo    cid data.inter
#>        <char> <char> <fctr> <num>  <fctr> <fctr>   <fctr> <char>     <Date>
#>     1: 120010 120010   masc     2     0-4    sim      g02    E86 2008-01-07
#>     2: 120025 120010   masc     0     0-4    sim      g02   A080 2008-01-14
#>     3: 120025 120010   masc    15   15-19    não nao-CSAP   B159 2008-01-15
#>     4: 120010 120010    fem    22   20-24    não nao-CSAP   N832 2008-01-14
#>     5: 120010 120010    fem    24   20-24    não nao-CSAP   N832 2008-01-12
#>    ---                                                                     
#> 34038: 120070 120070    fem     3     0-4    não nao-CSAP    R69 2008-12-31
#> 34039: 120040 120040   masc    40   40-44    não nao-CSAP   C152 2008-10-21
#> 34040: 120035 120040   masc    32   30-34    não nao-CSAP   C917 2008-11-12
#> 34041: 120040 120040   masc    73   70-74    não nao-CSAP   N188 2008-12-27
#> 34042: 120040 120040   masc    59   55-59    não nao-CSAP   I629 2008-11-01
#>        data.saida
#>            <Date>
#>     1: 2008-01-10
#>     2: 2008-01-17
#>     3: 2008-01-21
#>     4: 2008-01-17
#>     5: 2008-01-14
#>    ---           
#> 34038: 2009-01-01
#> 34039: 2009-04-03
#> 34040: 2009-04-29
#> 34041: 2009-02-23
#> 34042: 2009-03-05
fetchcsap(2007, uf = "AC")
#> ℹ Your local Internet connection seems to be ok.
#> ℹ DataSUS FTP server seems to be up and reachable.
#> ℹ Starting download...
#> → The following dates (yymm) are from old folders and may contain incompatible codes (including old ICD codes): 0701, 0702, 0703, 0704, 0705, 0706, 0707, 0708, 0709, 0710, 0711, 0712.
#> Importados 46.666 registros.
#> Excluídos 10.305 (22,1%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 36.361 (77,9%) registros.
#>        munres munint   sexo idade fxetar5   csap    grupo    cid data.inter
#>        <char> <char> <fctr> <num>  <fctr> <fctr>   <fctr> <char>     <Date>
#>     1: 120025 120010   masc    33   30-34    sim      g01    B54 2007-01-05
#>     2: 120010 120010    fem    60   60-64    não nao-CSAP   N200 2007-01-18
#>     3: 120010 120010   masc    50   50-54    sim      g02    E86 2007-01-20
#>     4: 120010 120010    fem    45   45-49    não nao-CSAP   K810 2007-01-15
#>     5: 120025 120010   masc    75   75-79    sim      g11   I509 2007-01-15
#>    ---                                                                     
#> 36357: 120040 120040   masc    45   45-49    não nao-CSAP   F068 2007-12-03
#> 36358: 120040 120040   masc    72   70-74    não nao-CSAP   A488 2007-12-15
#> 36359: 120010 120040    fem     2     0-4    não nao-CSAP   A488 2007-12-25
#> 36360: 120040 120040   masc    48   45-49    não nao-CSAP   F319 2007-12-13
#> 36361: 120040 120040    fem    49   45-49    não nao-CSAP   I738 2007-11-22
#>        data.saida
#>            <Date>
#>     1: 2007-01-07
#>     2: 2007-01-21
#>     3: 2007-01-24
#>     4: 2007-01-18
#>     5: 2007-01-21
#>    ---           
#> 36357: 2008-01-16
#> 36358: 2008-01-28
#> 36359: 2008-01-01
#> 36360: 2008-01-27
#> 36361: 2008-01-28
if (FALSE) { # \dontrun{
microdatasus::fetch_datasus(2007, 1, 2007, 12, "AC", "SIH-RD")
} # }
```
