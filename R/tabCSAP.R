#' @title Tabular Condições Sensíveis à Atenção Primária (CSAP)
#' @aliases tabCSAP
#'
#' @description Tabular Condições Sensíveis à Atenção Primária (CSAP) segundo a Lista Brasileira de Internações por Condições Sensíveis à Atenção Primária. Permite o uso da lista da portaria ministerial, com 19 grupos de causa, e da lista publicada por Alfradique et al., com 20 grupos de causa.
#'
#' @param x Um vetor da classe \code{factor} com os grupos de causa CSAP, nomeados de acordo com o resultado da função \code{\link{csapAIH}}. Esse vetor não precisa ser gerado pela função \code{\link{csapAIH}}, mas deve conter todos os 19 ou 20 grupos de causa da lista utilizada, ainda que sua frequência seja zero, e também devem ser rotulados da mesma forma e ordem que na função, isto é, "g01", "g02", ..., "g19" ou "g20".
#' @param digits número de decimais para o arredondamento (com \code{\link{round}}).
#' @param lang idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.
#' @param format Should the table be formatted to print? (default = FALSE).
#'
#' @return Uma tabela com a frequência absoluta dos grupos de causa e sua distribuição proporcional sobre o total de internações e sobre o total de ICSAP. Se os grupos forem classificados segundo a Lista Brasileira publicada em Portaria Ministerial, a tabela terá
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{nomesgruposCSAP}}
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' # data("aih500")
#' tabCSAP(csapAIH(aih500)$grupo)
#' tabCSAP(csapAIH(aih500)$grupo, lang = "pt.sa")
#' tabCSAP(csapAIH(aih500)$grupo, lang = "en")
#' tabCSAP(csapAIH(aih500)$grupo, lang = "es")
#' tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo)
#' tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "pt.sa")
#' tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "en")
#' tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "es")
#'
#' @export
tabCSAP <- function(x, digits = 2, lang = "pt.ca", format = FALSE){
  ngrupos <- length(table(x))
  if(ngrupos == 20) lista = "MS" else
    if(ngrupos == 21) lista = "Alfradique"
  if(is.factor(x)) tabelagrupos <- stats::addmargins(table(x)) else
    if(is.table(x) | is.matrix(x)) tabelagrupos <- x

  somacsap  <- sum(tabelagrupos[1:ngrupos-1]) # total de internações por CSAP
  psomacsap <- somacsap / sum(table(x))*100 # % de CSAP sobre o total de internações
  proptotal <- tabelagrupos/tabelagrupos['Sum']*100
  proptotal <- c( proptotal[1:(ngrupos-1)],
                 totalcsap = psomacsap,
                 proptotal[ngrupos] )
  propcsap     <- prop.table(tabelagrupos[1:ngrupos-1])*100
  tabelagrupos <- c( tabelagrupos[1:ngrupos-1],
                     "Total CSAP" = somacsap,
                     tabelagrupos[ngrupos + 0:1]
                     # tabelagrupos[20:21]
                     )

  substr(names(tabelagrupos)[ngrupos+1], 1,1) <- "N"
  nomesgrupos                          <- nomesgruposCSAP(lang = lang, lista = lista)
  # nomesgrupos                          <- groupnamesCSAP(lang = lang)
  names(tabelagrupos)[ngrupos+2]              <- "Total de interna\U00E7\u00F5es"

  if (lang == "en") {
    names(tabelagrupos)[ngrupos + 0:2] <- c("ACSC",
                                    "Non ACSC",
                                    "TOTAL hospitalizations")
    # names(tabelagrupos)[20:22] <- c("PHCSC",
    #                                 "Not PHCSC",
    #                                 "Total admissions")
  }
  if (lang == "es") {
    names(tabelagrupos)[ngrupos + 1:2] <- c("No-CSAP", "Total de ingresos")
    }
  if (lang == "pt.sa") {
      names(tabelagrupos)[ngrupos + 1:2] <- c("Nao-CSAP", "Total de internacoes")
    }

  nomes = c(nomesgrupos, names(tabelagrupos)[ngrupos + 0:2])

  if (format == FALSE) {
    tab <- cbind(casos = tabelagrupos,
                 perctot = round(c(proptotal, sum(proptotal[ngrupos + 0:1])), digits),
                 percsap = round(c(propcsap, sum(propcsap), NA, NA), digits))
    tab <- as.data.frame(tab)
    rownames(tab) <- NULL
    tab$grupo <- nomes
    tab <- tab[,c(4,1:3)]
    return(tab)
    }
  if (format == TRUE) {
    if (lang == "en") {
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
      } else if (lang != "en") {
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
                                       Casos = tabelagrupos.formatada,
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
