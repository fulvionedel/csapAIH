% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nomesgruposCSAP.R
\name{nomesgruposCSAP}
\alias{nomesgruposCSAP}
\title{Nomes dos grupos de causa da Lista Brasileira de Condições Sensíveis à Atenção Primária}
\usage{
nomesgruposCSAP(lista = "MS", lang = "pt.ca")
}
\arguments{
\item{lista}{Lista de causas a ser considerada (v. referências); pode ser \code{"MS"} (default) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.}

\item{lang}{idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.}
}
\value{
Um vetor da classe \code{character} com os nomes (abreviados) dos 19 grupos de causa segundo a Lista Brasileira.
}
\description{
Lista os 19 grupos de causa CSAP, em ordem crescente.
}
\examples{
nomesgruposCSAP()
nomesgruposCSAP(lang = "pt.ca")
nomesgruposCSAP(lang = "en")
nomesgruposCSAP(lang = "es")

}
\references{
Alfradique ME et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6):1337-1349. https://doi.org/10.1590/S0102-311X2009000600016.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
}
\seealso{
\code{\link{csapAIH}}, \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}}
}
