# Ler os arquivos da AIH.

Lê os "arquivos reduzidos" da Autorização de Internação Hospitalar
(AIH).

## Usage

``` r
leraih(
  x,
  arquivo = TRUE,
  procobst.rm = TRUE,
  parto.rm = TRUE,
  longa.rm = TRUE,
  vars = NULL,
  ...
)
```

## Arguments

- x:

  Alvo da função. Banco de dados com a estrutura dos arquivos da AIH,
  carregado como `data frame` na seção de trabalho ou armazenado em
  arquivo em formato dbc, dbf ou csv.

- arquivo:

  x é um arquivo de dados? Padrão é `TRUE`.

- procobst.rm:

  As internações para procedimentos obstétricos devem ser excluídas?
  Padrão é `TRUE`. V. details.

- parto.rm:

  argumento lógico, obrigatório se `sihsus=TRUE`; `TRUE` (padrão) exclui
  as internações por parto (`ver detalhes`);

- longa.rm:

  As internações de longa permanência (tipo 5) devem ser excluídas?
  Padrão é `TRUE`. V. details.

- vars:

  Variáveis da AIH para seleção. O padrão (`vars = NULL`), seleciona o
  conjunto usado em
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md). V.
  details.

- ...:

  outros parâmetros das funções utilizadas

## Details

- x pode ser:

  1.  um arquivo de dados armazenado num diretório;

  2.  um banco de dados, ou um vetor da classe `factor` presente como
      objeto no espaço de trabalho do R, em que uma das variáveis, ou o
      vetor, contenha códigos da CID-10.

  Se for um arquivo, o nome deve ser escrito entre aspas e com a
  extensão do arquivo (DBC, DBF ou CSV, em minúsculas ou maiúsculas). Se
  não estiver no diretório de trabalho ativo, seu nome deve ser
  precedido pelo caminho (path) até o diretório de armazenamento. Se
  estiver em outro formato, podem-se usar os argumentos da função
  [`read.table`](https://rdrr.io/r/utils/read.table.html) para leitura
  dos dados.

- `procbst.rm` TRUE (padrão) exclui as internações por procedimentos
  relacionados ao parto ou abortamento. São excluídas as internações
  pelos seguintes procedimentos obstétricos, independente do diagnóstico
  principal de internação (variável \`DIAGPRINC\`):

  - 0310010012 ASSISTENCIA AO PARTO S/ DISTOCIA

  - 0310010020 ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO

  - 0310010039 PARTO NORMAL

  - 0310010047 PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO

  - 0411010018 DESCOLAMENTO MANUAL DE PLACENTA

  - 0411010026 PARTO CESARIANO EM GESTAÇÃO ALTO RISCO

  - 0411010034 PARTO CESARIANO

  - 0411010042 PARTO CESARIANO C/ LAQUEADURA TUBÁRIA

  - 0411020013 CURETAGEM PÓS-ABORTAMENTO / PUERPERAL

  - 0411020021 EMBRIOTOMIA

- `parto.rm ` TRUE (padrão) exclui as internações por parto pelo campo
  diagnóstico, independente do procedimento. São excluídas as
  internações com os seguintes diagnósticos (CID-10):

  - O80 Parto único espontâneo

  - O81 Parto único por fórceps ou vácuo-extrator

  - O82 Parto único por cesariana

  - O83 Outros tipos de parto único assistido

  - O84 Parto múltiplo

  É retornada uma mensagem informando o número de registros lidos, o
  número e proporção de registros excluídos e o total de registros
  importados.

## See also

\[idadeSUS()\]

## Examples

``` r
leraih(aih500) |> head()
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>   MUNIC_RES IDADE SEXO DIAG_PRINC   PROC_REA   DT_INTER   DT_SAIDA
#> 1    430720    79  fem       N189 0305020056 2017-12-21 2017-12-28
#> 3    432000    46  fem       S423 0408020393 2017-12-22 2017-12-23
#> 4    430920    10  fem       H938 0415010012 2018-01-16 2018-01-17
#> 5    430490     0 masc       P584 0303160047 2017-11-01 2017-11-03
#> 6    431560    39  fem       I200 0303060280 2017-11-09 2017-11-22
#> 7    431620    78  fem       I442 0406010650 2017-10-17 2017-10-18
leraih(aih500, procobst.rm = FALSE) |> head()
#> Importados 500 registros.
#> Excluídos 41 (8,2%) registros de parto.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 456 (91,2%) registros.
#>   MUNIC_RES IDADE SEXO DIAG_PRINC   PROC_REA   DT_INTER   DT_SAIDA
#> 1    430720    79  fem       N189 0305020056 2017-12-21 2017-12-28
#> 2    432145    27  fem       O689 0411010034 2018-01-18 2018-01-20
#> 3    432000    46  fem       S423 0408020393 2017-12-22 2017-12-23
#> 4    430920    10  fem       H938 0415010012 2018-01-16 2018-01-17
#> 5    430490     0 masc       P584 0303160047 2017-11-01 2017-11-03
#> 6    431560    39  fem       I200 0303060280 2017-11-09 2017-11-22
leraih(aih500, parto.rm = FALSE) |> head()
#> Importados 500 registros.
#> Excluídos 61 (12,2%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 436 (87,2%) registros.
#>   MUNIC_RES IDADE SEXO DIAG_PRINC   PROC_REA   DT_INTER   DT_SAIDA
#> 1    430720    79  fem       N189 0305020056 2017-12-21 2017-12-28
#> 3    432000    46  fem       S423 0408020393 2017-12-22 2017-12-23
#> 4    430920    10  fem       H938 0415010012 2018-01-16 2018-01-17
#> 5    430490     0 masc       P584 0303160047 2017-11-01 2017-11-03
#> 6    431560    39  fem       I200 0303060280 2017-11-09 2017-11-22
#> 7    431620    78  fem       I442 0406010650 2017-10-17 2017-10-18
if (FALSE) { # \dontrun{
leraih("data-raw/RDRS1801.dbc", vars = c("DIAG_PRINC", "SEXO", "IDADE", "MUNIC_RES")) |> head()
leraih("data-raw/RDRS1801.dbf", vars = c("DIAG_PRINC", "SEXO", "IDADE", "COD_IDADE")) |> head()
} # }
```
