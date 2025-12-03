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
#>        <char> <char> <fctr> <num>  <fctr> <char>   <fctr> <char>     <Date>
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
```
