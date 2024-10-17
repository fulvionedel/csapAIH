#' @title Computa a idade nas bases de dados do SIH/SUS e SIM
#' @aliases idadeSUS
#'
#' @description Computa a idade em anos completos, a "faixa etária detalhada" e faixa etária quinquenal do indivíduo em registros dos bancos de dados do Sistema de Informação Hospitalar (SIH/SUS) ou do Sistema de Informação sobre Mortalidade (SIM) do SUS.
#'
#' @param dados Um objeto da classe `data frame` com a estrutura das bases de dados de hospitalização pelo SUS ("arquivos da AIH") ou das Declarações de Óbito ("arquivos do SIM").
#' @param sis O Sistema de Informação de Saúde fonte dos dados. Pode ser "SIH" [padrão], "SIM" ou "SIM-DOINF, em maiúsculas ou minúsculas
#'
#' @details O campo \code{IDADE} nas bases de dados do SIH e do SIM não é a idade em anos mas o tempo de vida em dias, meses, anos ou anos após a centena, de acordo com outro campo, (\code{COD_IDADE}) no SIH, ou um "subcampo" (1º dígito do campo \code{IDADE}) no SIM. Analisar o campo \code{IDADE} como se fosse a idade em anos completos pode gerar equívocos. A função computa a idade do indivíduo, evitando esse erro, e o classifica em faixas etárias utilizadas pelo DATASUS em suas ferramentas de tabulação, o TABNET e TabWin. Para os dados de hospitalização (\code{sis = "SIH"}) ou quando \code{sis = "SIM"}, é computada a idade em anos completos, a faixa etária quinquenal e a "faixa etária detalhada". Quando \code{sis = "SIM-DOINF"}, é computada a faixa etária em menores de um ano, classificada segundo os componentes da Taxa de Mortalidade Infantil (isto é, \emph{Neonatal precoce} (0 a 6 dias), \emph{Neonatal tardia} (7 a 28 dias), \emph{Pós-neonatal} (29 dias a 11 meses e 29 dias).
#'
#' @return Quando \code{sis = "SIM-DOINF"}, devolve um fator com os componentes da Taxa de Mortalidade Infantil. Para os dados de hospitalização (\code{sis = "SIH"}) ou quando \code{sis = "SIM"}, devolve um objeto da classe \code{data frame} com três variáveis:
#'  \enumerate{
#'   \item \code{idade}: idade em anos completos;
#'   \item \code{fxetar.det}: \code{factor} com 33 \code{levels}, a idade em anos completos de 0 a 19 ("<1ano", ..., "19anos"), em faixas quinquenais de "20-24" a "75-79" e "80 e +". Essa classificação é chamada pelo DATASUS de "idade detalhada";
#'   \item \code{fxetar5}: \code{factor} de 17 \code{levels} com a idade em faixas quinquenais ("0-4", ..., "75-79", "80 e +").
#'  }
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' Brasil. Ministério da Saúde. DATASUS. Tab para Windows - TabWin. Ministério da Saúde: Brasília, 2010.
#'
#' @examples
#' \dontrun{
#' df <- read.dbc::read.dbc("rdrs1801.dbc")
#' idades <- idadeSUS(df)
#'
#' # Em ordem, para pegar apenas um fator com a categoria desejada:
#' ## Idade em anos completos
#' idade.ano.a <- idadeSUS(df)[1] # "data.frame" com 1 variável
#' idade.ano.b <- idadeSUS(df)[,1] # vetor numérico
#' idade.ano.c <- idadeSUS(df)["idade"] # "data.frame" com 1 variável
#' all.equal(idade.ano.a, idade.ano.b)
#' all.equal(idade.ano.a, idade.ano.c)
#' all.equal(as.numeric(as.matrix(idade.ano.a)), idade.ano.b)
#' attributes (idade.ano.b)
#'
#' ## Faixa etária detalhada
#' idade.detalhada.a <- idadeSUS(df)[2]
#' idade.detalhada.b <- idadeSUS(df)[,2]
#' idade.detalhada.c <- idadeSUS(df)["fxetar.det"]
#'
#' ## Faixa etária quinquenal
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
#' # Mortalidade
#' # ----------------
#' \dontrun{
#' library(microdatasus)
#' dors19 <- fetch_datasus(2019, 01, 2019, 12, "RS", "SIM-DO")
#' idadeSUS(dors19, "sim") |> summary()
#' idadeSUS(dors19, "SIM-DOINF") |> summary()
#' }
#'
#' @export
idadeSUS <- function(dados, sis = "SIH")
{
  sis <- tolower(sis)
  if(sis %in% c("sih", "SIH", "sim", "SIM", "sim-doinf", "SIM-DOINF") == FALSE) {
    stop("sis precisa ser 'SIH', 'SIM' ou 'SIM-DOINF")
  }
  if(sis == "SIH" | sis == "sih") COD_IDADE <- as.character(dados$COD_IDADE)
  if(grepl("sim", sis, ignore.case = T)) {
    COD_IDADE <- substr(dados$IDADE, 1, 1)
    dados$IDADE <- as.numeric(substr(dados$IDADE, 2, 3))
  }
  if(sis == "sim" | sis == "sih") {
    idade <- ifelse(COD_IDADE == 4, dados$IDADE,
                  ifelse(COD_IDADE  < 4, 0,
                         ifelse(COD_IDADE == 5, dados$IDADE+100, NA))
                  )
  comment(idade) <- "em anos completos"
  rotulo.det <- cbind(
    faixa = levels(cut(idade, right=FALSE, breaks = c(0:19, seq(20, 85, 5)))),
    rotulo = c("<1ano", " 1ano", " 2anos", " 3anos", " 4anos", " 5anos",
               " 6anos", " 7anos", " 8anos", " 9anos", "10anos", "11anos",
               "12anos", "13anos", "14anos", "15anos", "16anos", "17anos",
               "18anos", "19anos", "20-24", "25-29", "30-34", "35-39",
               "40-44", "45-49", "50-54", "55-59", "60-64", "65-69",
               "70-74", "75-79", "80 e +"))
  fxetar.det <- droplevels(
    cut(idade, right=FALSE,
        breaks = c(0:19, seq(20, 80, 5), Inf),
        labels = rotulo.det[, 'rotulo']))
  # rotulo5 <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
  #              "30-34","35-39", "40-44","45-49","50-54", "55-59",
  #              "60-64", "65-69", "70-74", "75-79", "80 +")
  #
  # fxetar5 <- cut(idade, right=FALSE,
  #                breaks = c(seq(0, 80, 5), Inf),
  #                labels = c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
  #                           "30-34","35-39", "40-44","45-49","50-54", "55-59",
  #                           "60-64", "65-69", "70-74", "75-79", "80 +"))
  fxetar5 <- fxetar_quinq(idade)
  idade <- data.frame(idade,
                      fxetar.det,
                      fxetar5)
  }
  if(sis == "sim-doinf") {
    rotulos <- c("Neonatal precoce", "Neonatal tardia", "P\U000F3s-neonatal")
    idade <- ifelse(COD_IDADE < 2, 1,
                    ifelse(COD_IDADE == 2 & dados$IDADE < 7, 1,
                           ifelse(COD_IDADE == 2 & dados$IDADE >= 7 & dados$IDADE < 28, 2,
                                  ifelse(COD_IDADE == 2 & dados$IDADE >= 28, 3,
                                         ifelse(COD_IDADE == 3, 3, NA)))))
    idade <- factor(idade, labels = rotulos)
  }
  idade
}
