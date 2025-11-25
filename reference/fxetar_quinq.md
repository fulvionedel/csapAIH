# Categoriza a idade em faixas etárias quinquenais

Categoriza um vetor de valores contínuos ou inteiros em faixas
quinquenais. A primeira faixa pode ser quebrada em \`\< 1 ano\` e
\`1-4\`, com o argumento \`puer = TRUE\`. O número de faixas etárias é
definido pelos argumentos \`puer\` e \`senectus\`. Por padrão (\`puer =
FALSE\` e \`senectus = 80\`) são 17 faixas quinquenais: 0-4, ..., 80 e
+.

## Usage

``` r
fxetar_quinq(aetas = NULL, senectus = 80, puer = FALSE)
```

## Arguments

- aetas:

  Se \`NULL\` (padrão), retorna um vetor com as faixas etárias definidas
  por \`puer\` e \`senectus\`. Se um vetor com valores numéricos
  (\`dbl\`, \`num\`, \`int\`), idealmente uma variável com valores de
  idade, classifica o valor na faixa etária.

- senectus:

  Um valor definindo o início do último intervalo, que é aberto. Com o
  padrão \`senectus = 80\`, a função retorna um fator (\`fct\`) com 17
  nívels (\`levels\`) em que o último é "80 e +"

- puer:

  Se \`TRUE\`, a primeira faixa etária será quebrada em \`\< 1 ano\` e
  \`1-4\`

## Examples

``` r
data("aih500")
idade <- csapAIH(aih500)$idade
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
table(fxetar_quinq(idade))
#> 
#>    0-4    5-9  10-14  15-19  20-24  25-29  30-34  35-39  40-44  45-49  50-54 
#>     29      7      9     15     19     15     26     35     23     24     25 
#>  55-59  60-64  65-69  70-74  75-79 80 e + 
#>     25     36     42     38     30     37 
table(fxetar_quinq(idade, senectus = 90, puer = TRUE))
#> 
#>    < 1    1-4    5-9  10-14  15-19  20-24  25-29  30-34  35-39  40-44  45-49 
#>     21      8      7      9     15     19     15     26     35     23     24 
#>  50-54  55-59  60-64  65-69  70-74  75-79  80-84  85-89 90 e + 
#>     25     25     36     42     38     30     16     13      8 

# ou com a função `idadeSUS` (e encadeamento/'piping' de comandos):
idadeSUS(aih500)$idade |>
  fxetar_quinq() |>
  table()
#> 
#>    0-4    5-9  10-14  15-19  20-24  25-29  30-34  35-39  40-44  45-49  50-54 
#>     29      7      9     27     38     28     37     37     28     26     25 
#>  55-59  60-64  65-69  70-74  75-79 80 e + 
#>     26     36     42     38     30     37 
```
