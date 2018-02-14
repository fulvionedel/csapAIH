\name{csapAIH-package}
\alias{csapAIH-package}
%\alias{csapAIH}
\docType{package}
\title{
\packageTitle{csapAIH}
}
\description{
% \packageDescription{csapAIH}
Classifica códigos da CID-10 segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos "arquivos da AIH" (RD??????.DBF; BD-SIH/SUS).
}
\details{
Foram acrescentadas três funções ao pacote: \code{descreveCSAP}, \code{desenhaCSAP} e \code{nomesgrupos}, para a realização de tabelas e gráficos com qualidade de impressão para artigos e apresentação de relatórios.

A função principal, continua sendo \code{csapAIH()}, que permite trabalhar com um objeto no espaço de trabalho ou ler um arquivo com os dados. Se os dados tiverem a estrutura dos "arquivos da AIH" com uma definição mínima de variáveis, a função, com suas opções padrão, além de classificar a internação em CSAP, computa a idade em anos completos e em duas classificações etárias e permite a exclusão das AIHs de "longa permanência" e internações por alguns procedimentos obstétricos definidos. Veja o manual para detalhes.
}

% \packageIndices{csapAIH}
%%~~ An overview of how to use the package, including the most important functions ~~

\author{
%\packageAuthor{csapAIH}
Fúlvio B. Nedel \email{fulvionedel@gmail.com}

% Maintainer: Fúlvio B. Nedel \email{fulvionedel@gmail.com}
%\packageMaintainer{csapAIH}
}
%\references{
%%~~ Literature or other references for background information ~~
%}
%%~~ Optionally other standard keywords, one per line, from file KEYWORDS in the R documentation directory ~~
\keyword{ package }
\keyword{ CSAP }
\keyword{ AIH-SUS }
\keyword{ ACSC }
%\seealso{
%%~~ Optional links to other man pages, e.g. ~~
%%~~ \code{\link[<pkg>:<pkg>-package]{<pkg>}} ~~
%}
%\examples{
%%~~ simple examples of the most important functions ~~
%}
