#' @title Tabulate Primary Health Care Sensitive Conditions (PHCSC)
#' @aliases tabCSAP
#'
#' @description Tabulates Primary Health Care Sensitive Conditions (PHCSC, CSAP) according to the Brazilian list of causes.
#'
#' @param x a vector containing the Brazilian PHCSC groups of causes.
#' @param digits number of decimals to be rounded (with \code{\link{round}}).
#' @param tipo argument to be passed to \code{\link{nomesgruposCSAP}}.
#' @param format Should the table be formatted to print? (default = FALSE).
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{nomesgruposCSAP}}

#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' data("aih500")
#' csap <- csapAIH(aih500)
#' tabCSAP(csap$grupo)
#' tabCSAP(csap$grupo, tipo = "pt.sa")
#' tabCSAP(csap$grupo, tipo = "en")
#' tabCSAP(csap$grupo, tipo = "es")
#'
#' @export
tabCSAP <- function(x, digits = 2, tipo = "pt.ca", format = FALSE){
  if(is.factor(x)) tabelagrupos <- stats::addmargins(table(x))
  if(is.table(x) | is.matrix(x)) tabelagrupos <- x

  somacsap  <- sum(tabelagrupos[1:19]) # total de internações por CSAP
  psomacsap <- somacsap / sum(table(x))*100 # % de CSAP sobre o total de internações
  proptotal <- prop.table(tabelagrupos[1:20])*100
  proptotal <- c( proptotal[1:19],
                 totalcsap = psomacsap,
                 proptotal[20] )
  propcsap     <- prop.table(tabelagrupos[1:19])*100
  tabelagrupos <- c( tabelagrupos[1:19],
                     "Total CSAP" = somacsap,
                     tabelagrupos[20:21] )

  substr(names(tabelagrupos)[21], 1,1) <- "N"
  nomesgrupos                          <- nomesgruposCSAP(tipo = tipo)
  # nomesgrupos                          <- groupnamesCSAP(tipo = tipo)
  names(tabelagrupos)[22]              <- "Total de interna\U00E7\u00F5es"

  if (tipo == "en") {
    names(tabelagrupos)[20:22] <- c("ACSC",
                                    "Non ACSC",
                                    "TOTAL hospitalizations")
    # names(tabelagrupos)[20:22] <- c("PHCSC",
    #                                 "Not PHCSC",
    #                                 "Total admissions")
  } else if (tipo == "es") {
    names(tabelagrupos)[21:22] <- c("No-CSAP", "Total de ingresos")
    } else if (tipo == "pt.sa") {
      names(tabelagrupos)[21:22] <- c("Nao-CSAP", "Total de internacoes")
      }

  nomes = c(nomesgrupos, names(tabelagrupos[20:22]))

  if (format == FALSE) {
    tab <- cbind(casos = tabelagrupos,
                 perctot = round(c(proptotal, sum(proptotal[20:21])), digits),
                 percsap = round(c(propcsap, sum(propcsap), NA, NA), digits))
    tab <- as.data.frame(tab)
    rownames(tab) <- NULL
    tab$grupo <- nomes
    tab <- tab[,c(4,1:3)]
    return(tab)
    } else if (format == TRUE) {
      if (tipo == "en") {
        proptotal = formatC(proptotal, digits = digits, format = "f")
        propcsap  = formatC(propcsap,  digits = digits, format = "f")
        tabelagrupos.formatada = cbind(Group = nomes,
                                       Cases = formatC(tabelagrupos,
                                                       digits = 0,
                                                       big.mark = ",",
                                                       format = "f"),
                                       "Total %" = c(proptotal, 100),
                                       "ACSC %" = c(propcsap, 100, rep('--',2))
        )
      } else if (tipo != "en") {
        tabelagrupos.formatada =
          suppressWarnings(
            formatC(tabelagrupos, big.mark = ".", format = "d")
          )
        proptotal =
          suppressWarnings(
            formatC(proptotal, digits = digits, format = "f", decimal.mark = ",")
          )
        propcsap =
          suppressWarnings(
            formatC(propcsap, digits = digits, format = "f", decimal.mark = ",")
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
}
