#' @title Tabular Condições Sensíveis à Atenção Primária
#' @description Constrói uma tabela de frequências absolutas e relativas das CSAP por grupo de causa
#' @aliases descreveCSAP
#'
#' @param grupos Pode ser:
#' \itemize{
#'   \item Um \code{data.frame} gerado pela função \code{\link{csapAIH}}, ou qualquer \code{data.frame} com uma variável chamada \code{grupo} com os grupos de causa da Lista Brasileira de Internações por CSAP, rotulados como os resultantes da função \code{\link{csapAIH}}, isto é, "g01", "g02", ..., "g19".
#'   \item Um vetor da classe \code{factor} ou \code{character} com os grupos de causa CSAP, nomeados de acordo com o resultado da função \code{\link{csapAIH}}. Esse vetor não precisa ser gerado pela função \code{\link{csapAIH}}, mas deve conter todos os 19 grupos de causa, ainda que sua frequência seja zero, e também devem ser rotulados da mesma forma e ordem que na função, isto é, "g01", "g02", ..., "g19".
#'   }
#' @param digits Número de decimais nas proporções apresentadas.
#' @param lang Define o idioma dos nomes dos grupos. O padrão é \code{"pt.ca"} ("português com acentos"). Pode ser \code{"pt.sa"}, \code{"es"} ou \code{"en"}.
#' @param ... Permite a inclusão de argumentos da função \link{nomesgruposCSAP}, como "\code{lista}", para definição da lista de causas usada, se "MS" ou "Alfradique".
#'
#' @returns Um objeto da classe \code{data.frame} com a tabulação dos códigos da CID-10 segundo os grupos de causa da Lista Brasileira de ICSAP (19 grupos), com a frequência absoluta de casos e as porcentagens sobre o total de internações e sobre o conjunto das ICSAP.
#'
#' @note Os valores são armazenados em formato latino (vírgula como separador decimal e ponto como separador de milhar) e são, portanto, da classe \code{character}. Isso é indesejado, porque impede a realização de operações matemáticas ou mesmo a aplicação direta da função \code{\link{as.numeric}}, para retornar à classe \code{numeric}. Para resolver esse problema foi criada uma nova função \code{\link{tabCSAP}} que tem por output uma versão da tabela com os valores numéricos, com um argumento para a apresentação em formato latino. Portanto, para evitar a quebra de código já escrito, \code{\link{descreveCSAP}} será mantida como está, mas não será mais desenvolvida com esse nome, sua continuidade se dará por meio de \code{\link{tabCSAP}}. Tabulações com a lista de 20 grupos de causa deve ser feita com esta última função.
#'
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{desenhaCSAP}}, \code{\link{nomesgruposCSAP}}, \code{\link{tabCSAP}}
#'
#' @examples
#' data(aih100)
#' df = csapAIH(aih100)
#' descreveCSAP(df$grupo)
#' descreveCSAP(df)
#'
#' df = csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10, lista = "Alfradique")
#' descreveCSAP(df$grupo)
#' descreveCSAP(df, lang = "es")
#'
#' @export
#'
descreveCSAP <- function(grupos, digits = 2, lang = "pt.ca", ...){

    if(is.data.frame(grupos)) grupos = grupos$grupo
    if(any(grupos %in% "g20")) lista = "Alfradique" else lista = "MS"

  #   if(is.factor(grupos)) tabelagrupos <- stats::addmargins(table(grupos)) else
  #   if(is.table(grupos) | is.matrix(grupos)) tabelagrupos <- grupos

  # if(is.character(grupos)) {
  #   if(length(table(grupos)) < 19) {
  #     stop("O vetor precisa ter todos os grupos da lista, mesmo que com freq = 0")
  #   }
  # }
  # if( is.factor(grupos) ) {
  #   if(length(levels(grupos)) < 19) {
  #     stop("O fator precisa ter como n\U00EDveis os grupos, mesmo que com freq = 0")
  #   }
  # }
  # if(is.data.frame(grupos)) {
  #   if(nrow(grupos) < 23) {
  #     #tabelagrupos = grupos
  #     tabelagrupos <- cbind(c(nomesgruposCSAP(lista = lista, ...), "N\U00E3o-CSAP"),
  #                             grupos)
  #     tabelagrupos <- tabelagrupos[,-2]
  #     colnames(tabelagrupos) <- c("Grupo", "Freq.")
  #
  #     return(tabelagrupos)
  #   } else
  #     grupos = grupos$grupo
  # }
  if(is.factor(grupos)) tabelagrupos <- stats::addmargins(table(grupos))
  if(is.character(grupos)) tabelagrupos <- stats::addmargins(table(grupos))
  if(is.table(grupos) | is.matrix(grupos)) tabelagrupos <- grupos

  # somacsap = sum(tabelagrupos[1:19]) # total de internações por CSAP
  somacsap = sum(utils::head(tabelagrupos, -2)) # total de internações por CSAP
  psomacsap = somacsap / sum(table(grupos)) *100 # % de CSAP sobre o total de internações
  proptotal = prop.table(utils::head(tabelagrupos, -1))*100
  proptotal = c( utils::head(proptotal, -1),
                 # proptotal[1:19],
                 totalcsap = psomacsap,
                 # proptotal[20]
                 utils::tail(proptotal, 1)
                 )
  propcsap = prop.table(#tabelagrupos[1:19]
                        utils::head(tabelagrupos, -2))*100
  tabelagrupos = c( #tabelagrupos[1:19],
                    utils::head(tabelagrupos, -2),
                    "Total CSAP" = somacsap,
                    # tabelagrupos[20:21]
                    utils::tail(tabelagrupos, 2)
                    )

  # names(tabelagrupos)[length(tabelagrupos)] <- "Total de interna\U00E7\u00F5es"
  names(tabelagrupos)[length(tabelagrupos)-1:0] <- c("N\U00E3o-CSAP",
                                                     "Total de interna\U00E7\u00F5es")

  nomesfim.tabela <- c("Total CSAP", "N\U00E3o-CSAP", "Total de interna\U00E7\u00F5es")
  if(lang =="pt.sa") {
      nomesfim.tabela[2:3] <- c("Nao-CSAP", "Total de internacoes")
    } else if(lang == "es") {
      nomesfim.tabela[2:3] <- c("No-CSAP", "Total de ingresos")
    } else if (lang == "en") {
      nomesfim.tabela[2:3] <- c("No-CSAP", "Total admissions")
    }

  nomesgrupos <- nomesgruposCSAP(lista = lista, lang = lang, ...)
  nomes <- c(nomesgrupos, nomesfim.tabela)
  # nomes <- c(nomesgrupos, names(#tabelagrupos[20:22]
  #                               utils::tail(tabelagrupos, 3)
  #                               ))
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
