#' @title Tabular Condicoes Sensiveis a Atencao Primaria
#' @author Fúlvio B. Nedel
#' @description Constrói uma tabela de frequências absolutas e relativas das CSAP por grupo de causa
#' @aliases descreveCSAP
#' @aliases csapAIH
#' 
#' @param grupos Vetor com os grupos de causa CSAP, de acordo com o resultado da função \code{\link{csapAIH}}
#' @details  \code{grupos} não precisa ser gerado com a função \code{\link{csapAIH}}, mas deve usar os mesmos caracteres de identificação dos grupos CSAP que o resultado da função, v.g. "g01", "g02", ..., "g19".
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
descreveCSAP <- function(grupos){
  if(is.factor(grupos)) tabelagrupos = stats::addmargins(table(grupos))
  if(is.table(grupos) | is.matrix(grupos)) tabelagrupos = grupos
  if(length(tabelagrupos) != 21) {
    warning("grupos deve incluir todos os grupos de CSAP")
    return(tabelagrupos)
  }

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

  # nomesgrupos <- c("1.Prev. vacinação", "2.Gastroenterite", "3.Anemia",
  #                  "4.Def. nutricion.", "5.Infec. ouvido, nariz e garganta",
  #                  "6.Pneumonias bacterianas", "7.Asma", "8.Pulmonares",
  #                  "9.Hipertensão", "10.Angina", "11.Insuf. cardíaca",
  #                  "12.Cerebrovasculares", "13.Diabetes mellitus",
  #                  "14.Epilepsias", "15.Infec. urinária", 
  #                  "16.Infec. pele e subcutâneo",
  #                  "17.D. infl. órgãos pélvicos femininos",
  #                  "18.Úlcera gastrointestinal", 
  #                  "19.Pré-natal e parto"
  #                  )
  nomesgrupos = nomesgruposCSAP()
  nomes = c(nomesgrupos, names(tabelagrupos[20:22]))
  tabelagrupos.formatada = suppressWarnings(formatC(tabelagrupos, big.mark = ".", format = "d"))
  proptotal = 
    suppressWarnings(
      formatC(proptotal, digits = 2, format = "f", decimal.mark = ",") )
  propcsap = 
    suppressWarnings(
      formatC(propcsap, digits = 2, format = "f", decimal.mark = ",") )

  tabelagrupos.formatada = cbind(Grupo = nomes,
                                 Casos = tabelagrupos,
                                 "\U0025Total" = c(proptotal, 100),
                                 "\u0025CSAP" = c(propcsap, 100,
                                              rep('--',2)) )
  rownames(tabelagrupos.formatada) <- NULL
  tabelagrupos.formatada <- as.data.frame(tabelagrupos.formatada)
  
  return(tabelagrupos.formatada)
  
}
