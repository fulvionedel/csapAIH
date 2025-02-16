% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fxetar3g.R
\name{fxetar3g}
\alias{fxetar3g}
\title{Faixa etária em três grandes categorias}
\usage{
fxetar3g(idade = NULL)
}
\arguments{
\item{idade}{Vetor representando a idade ou a faixa etária. Pode ser numérico, em valores contínuos ou inteiros, ou da classe \code{factor} ou \code{character} representando 17 faixas etárias quinquenais, rotuladas conforme o resultado da função \code{\link{fxetar_quinq}} (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e +").}
}
\value{
\emph{Se fornecida a idade}, devolve um fator com as frequências observadas em cada faixa etária; \emph{se fornecida a faixa etária}, devolve um vetor da classe caractere com as frequências de cada faixa etária; \emph{se não é informado o argumento}, a função devolve um vetor com os nomes das faixas etárias. V. exemplos.
}
\description{
Recodifica vetores com a idade em números inteiros ou em faixas etárias quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.
}
\examples{
# Apenas citar os grupos:
fxetar3g()

# Categorizar a idade
## Criar um vetor para idade
idade <- as.integer(runif(100, 0, 100))
## Computar a faixa etária
fxetar3g(idade) |> table()

# Recategorizar a faixa etária quinquenal e
# computar a faixa etária em três grandes gupos
fxetar_quinq(idade) |>
fxetar3g() |> table()

}
