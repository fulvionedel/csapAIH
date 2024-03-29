% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fxetar_quinq.R
\name{fxetar_quinq}
\alias{fxetar_quinq}
\title{Categoriza a idade em faixas etárias quinquenais}
\usage{
fxetar_quinq(aetas = NULL, senectus = 80, puer = FALSE)
}
\arguments{
\item{aetas}{Se `NULL` (padrão), retorna um vetor com as faixas etárias definidas por `puer` e `senectus`. Se um vetor com valores numéricos (`dbl`, `num`, `int`), idealmente uma variável com valores de idade, classifica o valor na faixa etária.}

\item{senectus}{Um valor definindo o início do último intervalo, que é aberto. Com o padrão `senectus = 80`, a função retorna um fator (`fct`) com 17 nívels (`levels`) em que o último é "80 e +"}

\item{puer}{Se `TRUE`, a primeira faixa etária será quebrada em `< 1 ano` e `1-4`}
}
\description{
Categoriza um vetor de valores contínuos ou inteiros em faixas quinquenais. A primeira faixa pode ser quebrada em `< 1 ano` e `1-4`, com o argumento `puer = TRUE`. O número de faixas etárias é definido pelos argumentos `puer` e `senectus`. Por padrão (`puer = FALSE` e `senectus = 80`) são 17 faixas quinquenais: 0-4, ..., 80 e +.
}
\examples{
data("aih500")
idade <- csapAIH(aih500)$idade
table(fxetar_quinq(idade))
table(fxetar_quinq(idade, senectus = 90, puer = TRUE))

# ou com a função `idadeSUS` (e encadeamento/'piping' de comandos):
idadeSUS(aih500)$idade |>
  fxetar_quinq() |>
  table()

}
