#' Tabulate Primary Health Care Sensitive Conditions (PHCSC)
#'
#' @aliases tableCSAP
#'
#' @description Tabulates Primary Health Care Sensitive Conditions (PHCSC, CSAP) according to the Brazilian list of causes.
#'
#' @param x a vector containing the Brazilian PHCSC groups of causes.
#' @param idioma argument to be passed to \code{\link{groupnamesCSAP}}.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{groupnamesCSAP}}, \code{\link{legoAIH}}

#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' data("aih500")
#' csap <- csapAIH(aih500)
#' tableCSAP(csap$grupo)
#' tableCSAP(csap$grupo, idioma = "pt.sa")
#' tableCSAP(csap$grupo, idioma = "en")
#' tableCSAP(csap$grupo, idioma = "es")
#'
#' @export
tableCSAP <- function(x, idioma = "pt.ca"){
  if(is.factor(x)) tabelagrupos = stats::addmargins(table(x))
  if(is.table(x) | is.matrix(x)) tabelagrupos = x

  somacsap = sum(tabelagrupos[1:19]) # total de internações por CSAP
  psomacsap = somacsap / sum(table(x)) *100 # % de CSAP sobre o total de internações
  proptotal = prop.table(tabelagrupos[1:20])*100
  proptotal = c( proptotal[1:19],
                 totalcsap = psomacsap,
                 proptotal[20] )
  propcsap = prop.table(tabelagrupos[1:19])*100
  tabelagrupos = c( tabelagrupos[1:19],
                    "Total CSAP" = somacsap,
                    tabelagrupos[20:21] )

  substr(names(tabelagrupos)[21], 1,1) = "N"
  nomesgrupos = csapAIH::groupnamesCSAP(idioma = idioma)
  names(tabelagrupos)[22] <- "Total de interna\U00E7\u00F5es"
  if (idioma == "en") {
    names(tabelagrupos)[20:22] <- c("PHCSC",
                                    "Not PHCSC",
                                    "Total admissions")
  } else if (idioma == "es") {
    names(tabelagrupos)[21:22] <- c("No-CSAP", "Total de ingresos")
    } else if (idioma == "pt.sa") {
      names(tabelagrupos)[21:22] <- c("Nao-CSAP", "Total de internacoes")
      }

  nomes = c(nomesgrupos, names(tabelagrupos[20:22]))
  if (idioma == "en") {
    tabelagrupos.formatada = formatC(tabelagrupos, big.mark = " ", format = "d")
    proptotal = formatC(proptotal, digits = 2, format = "f")
    propcsap = formatC(propcsap, digits = 2, format = "f")
    tabelagrupos.formatada = cbind(Group = nomes,
                                   Cases = tabelagrupos,
                                   "Total %" = c(proptotal, 100),
                                   "PHCSC %" = c(propcsap, 100, rep('--',2))
                                   )
  } else if (idioma != "en") {
    tabelagrupos.formatada =
      suppressWarnings(
        formatC(tabelagrupos, big.mark = ".", format = "d")
        )
    proptotal =
      suppressWarnings(
        formatC(proptotal, digits = 2, format = "f", decimal.mark = ",")
        )
    propcsap =
      suppressWarnings(
        formatC(propcsap, digits = 2, format = "f", decimal.mark = ",")
        )
    tabelagrupos.formatada = cbind(Grupo = nomes,
                                   Casos = tabelagrupos,
                                   "% Total" = c(proptotal, 100),
                                   "% CSAP" = c(propcsap, 100,
                                                rep('--',2))
                                   )
  }
  rownames(tabelagrupos.formatada) <- NULL
  tabelagrupos.formatada <- as.data.frame(tabelagrupos.formatada)
  return(tabelagrupos.formatada)
}
