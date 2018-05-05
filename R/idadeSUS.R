#' @title Computa a idade nas bases de dados do SIH/SUS e SIM
#' @author Fúlvio B. Nedel
#'
#' @aliases idadeSUS
#' @aliases legoAIH
#' @aliases csapAIH
#' @aliases fxetar_quinq
#'
#' @description Computa a idade, "faixa etária detalhada" e faixa etária quinquenal do indivíduo em registros dos bancos de dados do Sistema de Informação Hospitalar (SIH/SUS) ou do Sistema de Informação sobre Mortalidade (SIM) do SUS.
#'
#' @param x Um objeto da classe `data frame` com a estrutura das bases de dados de hospitalização pelo SUS ("arquivos da AIH") ou das Declarações de Óbito ("arquivos do SIM").
#'
#' @details As bases de dados do SIH e do SIM têm um campo \code{IDADE} que não é a idade em anos mas o tempo de vida em dias, meses, anos ou anos após a centena, de acordo com outro campo, \code{COD_IDADE}. Analisar o campo \code{IDADE} como se fosse a idade em anos completos pode gerar equívocos. A função computa a idade do indivíduo, evitando esse erro, e o classifica em faixas etárias utilizadas pelo DATASUS em suas ferramentas de tabulação, o TABNET e TabWin.
#'
#' @return Devolve um objeto da classe \code{data frame} com três variáveis:
#'  \enumerate{
#'   \item \code{idade}: idade em anos completos.
#'   \item \code{fxetar.det}: \code{factor} com 33 \code{levels}, a idade em anos completos de 0 a 19 ("<1ano", ..., "19anos"), em faixas quinquenais de "20-24" a "75-79" e "80 +". Essa classificaçção é chamada pelo DATASUS de "idade detalhada"
#'   \item \code{fxetar5}: \code{factor} de 17 \code{levels} com a idade em faixas quinquenais ("0-4", ..., "75-79", "80 +").
#'  }
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#' Brasil. Ministério da Saúde. DATASUS. Tab para Windows - TabWin. Ministério da Saúde: Brasília, 2010.
#'
#' @examples
#' \dontrun{
#' df <- read.dbc::read.dbc("rdrs1701.dbc")
#' idades <- idadeSUS(df)
#'
#' # Em ordem, para pegar apenas um fator com a categoria desejada:
#' ## Idade em anos completos
#' idade.ano.a <- idadeSUS(df)[1]
#' idade.ano.b <- idadeSUS(df)[,1]
#' idade.ano.c <- idadeSUS(df)["idade"]
#'
#' ## Faixa etária detalhada
#' idade.detalhada.a <- idadeSUS(df)[2]
#' idade.detalhada.b <- idadeSUS(df)[,2]
#' idade.detalhada.c <- idadeSUS(df)["fxetar.det"]
#'
#' ## Faixa etária quinqunal
#' idade.fxet5.a <- idadeSUS(df)[3]
#' idade.fxet5.a <- idadeSUS(df)[,3]
#' idade.fxet5.a <- idadeSUS(df)["fxetar5"]
#' }
#'
#' data("aih100")
#' idades <- idadeSUS(aih100)
#' str(idades)
#' head(idades)
#' idade.ano <- idadeSUS(aih100)[1] ; str(idade.ano)
#' idade.detalhada <- idadeSUS(aih100)[,2] ; str(idade.detalhada)
#' idade.fxet5 <- idadeSUS(aih100)["fxetar5"] ; str(idade.fxet5)
#'
#' @export
idadeSUS <- function(x)
{
  COD_IDADE <- as.character(x$COD_IDADE)
  idade <- ifelse(COD_IDADE == 4, x$IDADE,
                  ifelse(COD_IDADE  < 4, 0,
                         ifelse(COD_IDADE == 5, x$IDADE+100, NA))
                  )
  comment(idade) <- "em anos completos"
  fxetar.det <- cut(idade, include.lowest=TRUE, right=FALSE,
                    breaks=c(0:19,20,25,30,35,40,45,50,55,60,65,70,75,80, max(idade)),
                    labels=c("<1ano", " 1ano", " 2anos", " 3anos", " 4anos", " 5anos",
                             " 6anos", " 7anos", " 8anos", " 9anos", "10anos", "11anos",
                             "12anos", "13anos", "14anos", "15anos", "16anos", "17anos",
                             "18anos", "19anos", "20-24", "25-29", "30-34", "35-39",
                             "40-44", "45-49", "50-54", "55-59", "60-64", "65-69",
                             "70-74", "75-79", "80 +")
                    )
  fxetar5 <- cut(idade, right=FALSE, include.lowest=TRUE,
                 breaks=c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80, max(idade)),
                 labels=c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
                          "30-34","35-39", "40-44","45-49","50-54", "55-59",
                          "60-64", "65-69", "70-74", "75-79", "80 +")
                 )
  data.frame(idade, fxetar.det, fxetar5)
}
