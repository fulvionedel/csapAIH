#' @title Tabular Condicoes Sensiveis a Atencao Primaria
#' @description Constrói uma tabela de frequências absolutas e relativas das CSAP por grupo de causa
#' @aliases descreveCSAP
#'
#' @param grupos Pode ser:
#' \itemize{
#'   \item Um \code{data.frame} gerado pela função \code{\link{csapAIH}}, ou qualquer \code{data.frame} com uma variável chamada \code{grupo} com os grupos de causa da Lista Brasileira de CSAP, rotulados como os resultantes da função \code{\link{csapAIH}}, isto é, "g01", "g02", ..., "g19".
#'   \item Um vetor da classe \code{factor} ou \code{character} com os grupos de causa CSAP, nomeados de acordo com o resultado da função \code{\link{csapAIH}}. Esse vetor não precisa ser gerado pela função \code{\link{csapAIH}}, mas deve conter todos os 19 grupos de causa, ainda que sua frequência seja zero, e também devem ser rotulados da mesma forma e ordem que na função, isto é, "g01", "g02", ..., "g19".
#'   }
#' @param digits Número de decimais nas proporções apresentadas.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{desenhaCSAP}}, \code{\link{nomesgruposCSAP}}
#'
#' @examples
#' data(aih100)
#' df = csapAIH(aih100)
#' descreveCSAP(df$grupo)
#'
#' @export
#'
descreveCSAP <- function(grupos, digits = 2){
  if(is.character(grupos)) {
    if(length(table(grupos)) < 19) {
      stop("O vetor precisa ter os 19 grupos, mesmo que com freq = 0")
    }
  }
  if( is.factor(grupos) ) {
    if(length(levels(grupos)) < 19) {
      stop("O fator precisa ter como n\U00EDveis os 19 grupos, mesmo que com freq = 0")
    }
  }
  if(is.data.frame(grupos)) {
    if(nrow(grupos) < 23) {
      tabelagrupos = grupos
      return(tabelagrupos)
    } else
      grupos = grupos$grupo
  }
  if(is.factor(grupos)) tabelagrupos <- stats::addmargins(table(grupos))
  if(is.character(grupos)) tabelagrupos <- stats::addmargins(table(grupos))
  if(is.table(grupos) | is.matrix(grupos)) tabelagrupos <- grupos

  somacsap = sum(tabelagrupos[1:19]) # total de internações por CSAP
  psomacsap = somacsap / sum(table(grupos)) *100 # % de CSAP sobre o total de internações
  proptotal = prop.table(tabelagrupos[1:20])*100
  proptotal = c( proptotal[1:19],
                 totalcsap = psomacsap,
                 proptotal[20] )
  propcsap = prop.table(tabelagrupos[1:19])*100
  tabelagrupos = c( tabelagrupos[1:19],
                    "Total CSAP" = somacsap,
                    tabelagrupos[20:21] )
  names(tabelagrupos)[22] <- "Total de interna\U00E7\u00F5es"
  nomesgrupos <- nomesgruposCSAP()
  nomes <- c(nomesgrupos, names(tabelagrupos[20:22]))
  tabelagrupos.formatada <-
    suppressWarnings(
      formatC(tabelagrupos, digits = 0, big.mark = ".", format = "d"))
  proptotal <-
    suppressWarnings(
      formatC(proptotal, digits = digits, format = "f", decimal.mark = ",") )
  propcsap <-
    suppressWarnings(
      formatC(propcsap, digits = digits, format = "f", decimal.mark = ",") )

  tabelagrupos.formatada = cbind(Grupo = nomes,
                                 Casos = tabelagrupos.formatada,
                                 "\U0025Total" = c(proptotal, 100),
                                 "\u0025CSAP" = c(propcsap, 100,
                                              rep('--',2)) )
  rownames(tabelagrupos.formatada) <- NULL
  tabelagrupos.formatada <- as.data.frame(tabelagrupos.formatada)

  return(tabelagrupos.formatada)
}
