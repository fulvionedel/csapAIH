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
  mês. Por padrão, `fetchcsap` usa o argumento `periodo = "interna"` (e
  aceita suas abreviaturas `periodo = "int"` ou `periodo = "i"`) para
  selecionar os casos por data de internação de acordo com o período
  definido nos argumentos `anoinicio`, `mesinicio` e `anofim`, de modo a
  iniciar no primeiro dia do ano e mês de competência (`anoinicio` e
  `mesinicio`) e terminar em 31 de dezembro do ano anterior ao definido
  em `anofim`. Para baixar apenas os arquivos do mês de competência do
  período desejado, use `periodo = "competencia"` (ou as abreviaturas
  `"comp"` ou `"c"`).

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
# exemplo com as internações em Roraima:
# - todas as internações registradas no mês de competência jan 2023:
rr.comp <- fetchcsap(2023, uf = "RR", mesfim = 1, periodo = 'competencia')
#> ℹ Discovering available files on DataSUS...
#> ℹ Preparing to download and read 1 DataSUS file...
#> ℹ Downloading [1/1] RDRR2301.dbc...
#> ℹ Reading [1/1] RDRR2301.dbc...
#> ✔ Downloaded and read 1 of 1 DataSUS file.
#> Importados 4.734 registros.
#> Excluídos 1.166 (24,6%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 3.568 (75,4%) registros.
nrow(rr.comp)
#> [1] 3568
summary(rr.comp$data.inter)
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#> "2022-07-07" "2022-10-27" "2022-11-24" "2022-11-27" "2023-01-01" "2023-01-30" 
# - internações ocorridas em jan/2023 e registradas nos meses de competência
# janeiro a junho de 2023:
rr.int <- fetchcsap(2023, mesfim = 1, uf = "RR")
#> ℹ Discovering available files on DataSUS...
#> ℹ Preparing to download and read 6 DataSUS files...
#> ℹ Downloading [1/6] RDRR2301.dbc...
#> ℹ Reading [1/6] RDRR2301.dbc...
#> ℹ Downloading [2/6] RDRR2302.dbc...
#> ℹ Reading [2/6] RDRR2302.dbc...
#> ℹ Downloading [3/6] RDRR2303.dbc...
#> ℹ Reading [3/6] RDRR2303.dbc...
#> ℹ Downloading [4/6] RDRR2304.dbc...
#> ℹ Reading [4/6] RDRR2304.dbc...
#> ℹ Downloading [5/6] RDRR2305.dbc...
#> ℹ Reading [5/6] RDRR2305.dbc...
#> ℹ Downloading [6/6] RDRR2306.dbc...
#> ℹ Reading [6/6] RDRR2306.dbc...
#> ✔ Downloaded and read 6 of 6 DataSUS files.
#> Importados 4.156 registros.
#> Excluídos 1.044 (25,1%) registros de procedimentos obstétricos.
#> Excluídos NA (NA%) registros de AIH de longa permanência.
#> Exportados 3.112 (74,9%) registros.
nrow(rr.int)
#> [1] 3112
summary(rr.int$data.inter)
#>         Min.      1st Qu.       Median         Mean      3rd Qu.         Max. 
#> "2023-01-01" "2023-01-08" "2023-01-16" "2023-01-15" "2023-01-24" "2023-01-31" 
# Assim, há
nrow(rr.comp) - nrow(rr.int)
#> [1] 456
# internações registradas naquele mês de competência, mas que ocorreram antes.

# Internações ocorridas na Região Norte no mês de janeiro de 2023 e registradas naquele mês:
if (FALSE) { # \dontrun{
fetchcsap(2023, mesfim = 1, regiao = "N")
} # }

# Internações anteriores a 2008 carregam do pacote microdatasus os avisos de
# "arquivos antigos, que podem conter códigos incompatíveis"
if (FALSE) { # \dontrun{
microdatasus::fetch_datasus(2007, 1, 2007, 12, "RR", "SIH-RD")
fetchcsap(2007, uf = "RR")
} # }
```
