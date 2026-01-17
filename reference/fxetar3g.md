# Faixa etária em três grandes categorias

Recodifica vetores com a idade em números inteiros ou em faixas etárias
quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.

## Usage

``` r
fxetar3g(idade = NULL)
```

## Arguments

- idade:

  Vetor representando a idade ou a faixa etária. Pode ser numérico, em
  valores contínuos ou inteiros, ou da classe `factor` ou `character`
  representando 17 faixas etárias quinquenais, rotuladas conforme o
  resultado da função
  [`fxetar_quinq`](https://fulvionedel.github.io/csapAIH/reference/fxetar_quinq.md)
  (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e
  +").

## Value

*Se fornecida a idade ou a faixa etária*, devolve um vetor da classe
`factor` com a classificação de cada registro; *se não é informado o
argumento*, a função devolve um vetor com os nomes das faixas etárias.
V. exemplos.

## Examples

``` r
# Apenas citar os grupos:
fxetar3g()
#> [1] "0-14"  "15-59" "60e+" 

# Idade em anos
## Criar um vetor para idade
idade <- as.integer(runif(100, 0, 100))
## Computar a faixa etária
fxetar3g(idade) |> str()
#>  Factor w/ 3 levels "0-14","15-59",..: 3 2 3 3 1 2 3 3 1 2 ...
fxetar3g(idade) |> table()
#> 
#>  0-14 15-59  60e+ 
#>    10    51    39 

# Faixa etária
## Categorizar a faixa etária quinquenal e computar a faixa etária em três grandes grupos
fxetar_quinq(idade) |> str()
#>  Factor w/ 17 levels "0-4","5-9","10-14",..: 15 4 17 15 2 11 14 14 1 5 ...
fxetar_quinq(idade) |>
  fxetar3g() |>
  table()
#> 
#>  0-14 15-59  60e+ 
#>    10    51    39 

fxetar_quinq(idade, puer = TRUE) |> str()
#>  Factor w/ 18 levels "< 1","1-4","5-9",..: 16 5 18 16 3 12 15 15 2 6 ...
fxetar_quinq(idade, puer = TRUE) |>
  fxetar3g() |>
  table()
#> 
#>  0-14 15-59  60e+ 
#>    10    51    39 
```
