#' @title Ler arquivos de população do DATASUS
#' @aliases ler_popbr
#' @description Lê os arquivos POPBR?? com estimativas e contagens da população dos municípios brasileiros por sexo e faixa etária disponibilizados pelo DATASUS e cria uma variável com a faixa etária quinquenal.
#'
#' @param arquivo Nome do arquivo armazenado no computador, em formato CSV ou DBF. Padrão é \code{NULL}, v. details.
#' @param ano Ano da estimativa ou contagem populacional a ser capturada no site FTP DATASUS. Padrão é \code{NULL}, v. details.
#'
#' @details Apenas um dos dois parâmetros deve ser preenchido. Se o alvo é um arquivo no computador, o nome com a extensão (csv ou dbf) deve vir entre aspas; se for um arquivo csv, deve ser separado por vírgulas (é usada a função \link{read.csv} e não \link{read.csv2}). Se o alvo é um arquivo do servidor FTP do datasus, deve-se usar o argumando \code{ano}, com o ano (sem aspas) desejado, de 1980 a 2012.
#'
#' @examples
#' \dontrun{
#' # Um arquivo no mesmo diretório de trabalho da sessão ativa:
#' popBR2010 <- ler_popbr("data-raw/POPBR10.DBF")
#' head(popBR2010)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)
#' }
#'
#' # Um arquivo no diretório FTP do DATASUS
#' popBR2010 <- ler_popbr(ano = 2010)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)
#'
#' @importFrom utils download.file unzip read.csv
#' @export

ler_popbr <- function (arquivo = NULL, ano = NULL) {

  if(!is.null(ano)) {
    if(ano %in% 1980:2012 == FALSE) {
      stop("S\u00f3 h\u00e1 arquivos dispon\u00edveis para os anos 1980 a 2012.")
    }
    pop <- paste0("POPBR", substr(as.character(ano), 3,4))
    url <- paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/", pop, ".zip")
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, paste0(pop, ".csv"))
    populacao <- read.csv(paste0(pop, ".csv"))
    unlink(temp)
    unlink(paste0(pop, ".csv"))
  } else if(!is.null(arquivo)) {
    if(grepl('dbf', ignore.case = TRUE) %in% arquivo) {
      populacao <- foreign::read.dbf(arquivo)
    } else if(grepl('csv', ignore.case = TRUE) %in% arquivo) {
      populacao <- read.csv(arquivo)
    }
  }

  names(populacao) <- tolower(names(populacao))

  if(unique(populacao$ano) %in% c(1980, 1991, 1996:2012)) {
    populacao$fxetar5 <- cut(as.numeric(populacao$fxetaria),
                             breaks = c(0, 5, 10, 15, 20:33))
  } else if(unique(populacao$ano) %in% c(1981:1990, 1992)) {
    populacao$fxetar5 <- populacao$fxetaria
  } else if(unique(populacao$ano) %in% 1993:1995) {
     populacao$fxetar5 <- cut(as.numeric(populacao$fxetaria),
                              breaks = c(0, 5:21))
   }
  levels(populacao$fxetar5) <- c(  "0-4",   "5-9", "10-14", "15-19", "20-24",
                                 "25-29", "30-34", "35-39", "40-44", "45-49",
                                 "50-54", "55-59", "60-64", "65-69", "70-74",
                                 "75-79", "80 +")

   # pop$fxetaria <- factor(pop$fxetaria, levels = 1:33, labels = c("< 1 ano", 1:19, levels(pop$fxetar5)[5:17]))
   # levels(populacao$fxetaria) <- c("< 1 ano", 1:19, levels(populacao$fxetaria)[20:33]) #levels(populacao$fxetar5)[5:17])
   levels(populacao$sexo) <- c("masc", "fem")
   if ( length( levels(populacao$situacao) > 1 ) ) {
      levels(populacao$situacao) <- c("urbana", "rural")
    }
   # populacao$ano <- as.integer(as.character(populacao$ano))
   attr(populacao$fxetar5, which = "label") <- "Faixa etaria quinquenal"
   attr(populacao$fxetaria, which = "label") <- "Faixa etaria detalhada"
   attr(populacao$munic_res, which = "label") <- "Codigo IBGE do municipio"
   # names(populacao)[5] <- "fxetar.det"
   return(populacao)
  }
