#' @title Ler arquivos POPBR????.CSV/DBF
#' @aliases ler_popbr
#' @description Lê os arquivos de população do DATASUS e cria uma variável com a faixa etária quinquenal
#'
#' @param pop População. Nome do arquivo a ser lido.
#' @param source Fonte de dados. Use `file` (padrão) para um arquivo no computador ou `url` para baixar o arquivo do FTP do DATASUS.
#'
#' @examples
#' \dontrun{
#' # Um arquivo no mesmo diretório de trabalho da sessão ativa:
#' popBR2012 <- ler_popbr("POPBR12.DBF")
#' head(popBR2012)
#' xtabs(populacao ~ fxetar5, data = popBR2012)
#' }
#'
#' # Um arquivo no diretório FTP do DATASUS
#' popBR2012 <- ler_popbr("popBR12", source = "url")
#' xtabs(populacao ~ fxetar5, data = popBR2012)
#'
#' @importFrom utils download.file unzip
#' @importFrom Hmisc upData
#' @export

ler_popbr <- function (pop, source = "file")
  {
   if(source == "url"){
      pop <- toupper(pop)
      url <- paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/", pop, ".zip")
      temp <- tempfile()
      download.file(url, temp)
      unzip(temp, paste0(pop, ".DBF"))
      populacao <- foreign::read.dbf(paste0(pop, ".DBF"))
      unlink(temp)
      unlink(paste0(pop, ".DBF"))
    } else if(source == "file") populacao <- foreign::read.dbf(pop)

   populacao <- Hmisc::upData(populacao, lowernames = T, print = F)
   populacao$fxetar5 <- cut(as.numeric(populacao$fxetaria),
                            breaks = c(0, 5, 10, 15, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33))
   levels(populacao$fxetar5) <- c("0-4", "5-9", "10-14", "15-19",
                                  "20-24", "25-29", "30-34", "35-39", "40-44", "45-49",
                                  "50-54", "55-59", "60-64", "65-69", "70-74", "75-79",
                                  "80 +")
   # pop$fxetaria <- factor(pop$fxetaria, levels = 1:33, labels = c("< 1 ano", 1:19, levels(pop$fxetar5)[5:17]))
   # levels(populacao$fxetaria) <- c("< 1 ano", 1:19, levels(populacao$fxetaria)[20:33]) #levels(populacao$fxetar5)[5:17])
   levels(populacao$sexo) <- c("masc", "fem")
   if ( length( levels(populacao$situacao)>1 ) ) {
      levels(populacao$situacao) <- c("urbana", "rural")
    }
   # populacao$ano <- as.integer(as.character(populacao$ano))
   attr(populacao$fxetar5, which = "label") <- "Faixa etaria quinquenal"
   attr(populacao$fxetaria, which = "label") <- "Faixa etaria detalhada"
   attr(populacao$munic_res, which = "label") <- "Codigo IBGE do municipio"
   # Hmisc::label(populacao$fxetar5) <- "Faixa etaria quinquenal"
   # names(populacao)[5] <- "fxetar.det"
   # Hmisc::label(populacao$fxetar.det) <- "Faixa etaria detalhada"
   # Hmisc::label(populacao$fxetaria) <- "Faixa etaria detalhada"
   # Hmisc::label(populacao$munic_res) <- "Codigo IBGE do municipio"
   return(populacao)
  }
