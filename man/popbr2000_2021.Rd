% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/popbr2000_2021.R
\name{popbr2000_2021}
\alias{popbr2000_2021}
\title{População dos municípios brasileiros, 2000-2021}
\usage{
popbr2000_2021(
  anoi = NULL,
  anof = NULL,
  uf = NULL,
  munic = NULL,
  droplevels = TRUE
)
}
\arguments{
\item{anoi}{Ano de início do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis, i.e., de 2000 a 2021 (v. Examples).}

\item{anof}{Ano de fim do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis, i.e., de 2000 a 2021 (v. Examples).}

\item{uf}{Vetor com a(s) sigla(s) da(s) Unidade(s) da Federação de interesse.}

\item{munic}{Vetor com o código IBGE do(s) municípios(s) de interesse.}

\item{droplevels}{Vetor lógico. Se TRUE (padrão), exclui as categorias ("\code{levels}") sem observações em vetores da classe \code{factor}, comportamento normalmente desejável em seleções por município, UF ou região.}
}
\value{
Um banco de dados de classes \code{data.table} e \code{data.frame} com oito variáveis: \code{CO_UF, UF_SIGLA, REGIAO, ano, mun, sexo, fxetar5, pop}. A variável sexo é um \code{factor} com dois \code{levels}: "masc" e "fem". A variável \code{fxetar5} representa a idade agrupada em 17 categorias -- 16 faixas quinquenais (0-4, ... 75-79) e a última aberta a partir dos 80 anos (80 e +).
}
\description{
Estimativas populacionais anuais por sexo e faixa etária quinquenal para os municípios brasileiros, de 2000 a 2021. Modifica a tabela de dados resultante da função \code{\link[brpop]{mun_sex_pop}} do pacote \code{brpop} (\url{https://github.com/rfsaldanha/brpop}), permitindo seu uso como um banco de dados, além de mudar o rótulo de faixas etárias e categorias de sexo(v. Value). Exige a instalação prévia dos pacotes \code{brpop} e \code{\link{dplyr}}.
}
\details{
Essas informações podem ser tabuladas em \url{http://tabnet.datasus.gov.br/cgi/deftohtm.exe?ibge/cnv/popsvsbr.def}.

A nota técnica do estudo: \url{http://tabnet.datasus.gov.br/cgi/IBGE/SEI_MS-0034745983-Nota_Tecnica_final.pdf}
}
\examples{
library(dplyr)
# Ano 2021, todos os municípios brasileiros:
popbr2000_2021(2021)
# Anos 2019 a 2021, RS:
popbr2000_2021(2019, 2021, uf = "RS") \%>\%
  dplyr::group_by(ano) \%>\%
  dplyr::summarise(pop = sum(pop))
# Anos 2000 a 2003, AC:
popbr2000_2021(anof = 2003, uf = "AC") \%>\%
  group_by(ano) \%>\%
  summarise(pop = sum(pop))
# Anos 2014 a 2016, Cerro Largo, RS:
popbr2000_2021(2014, 2016, munic = "430520") \%>\%
  group_by(sexo, fxetar5) \%>\%
  summarise(pop = sum(pop))

}
\seealso{
\code{\link[brpop]{mun_sex_pop}}
}
