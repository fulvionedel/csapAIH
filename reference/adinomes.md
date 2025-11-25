# Adiciona o nome dos grupos

Acrescenta uma variável com o nome dos grupos de causa segundo a lista
selecionada ("MS" ou "Alfradique") a um banco de dados resultante da
função \`csapAIH\` ou que contenha uma variável de nome "grupo" com os
grupos nomeados segundo aquela função ("g01", ...)

## Usage

``` r
adinomes(x, lista = "MS")
```

## Arguments

- x:

  Banco de dados

- lista:

  Lista CSAP a ser utilizada. O padrão é "MS" (v.
  [nomesgruposCSAP](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md)).

## Details

Define como missing os não-CSAP

## See also

nomesgruposCSAP()

\[listaBRMS()\]

\[listaBRAlfradique\]

## Examples

``` r
data("aih100")
adinomes(csapAIH(aih100))[1:5, 9:11]
#> Importados 100 registros.
#> Excluídos 15 (15%) registros de procedimentos obstétricos.
#> Excluídos 1 (1%) registros de AIH de longa permanência.
#> Exportados 84 (84%) registros.
#> Joining with `by = join_by(grupo)`
#>   csap    grupo nomegrupo
#> 1  não nao-CSAP      <NA>
#> 2  não nao-CSAP      <NA>
#> 3  não nao-CSAP      <NA>
#> 4  não nao-CSAP      <NA>
#> 5  sim      g10    Angina
```
