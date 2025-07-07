#' @title Ler arquivos de população do DATASUS
#' @aliases ler_popbr
#'
#' @description Lê os arquivos com estimativas e contagens da população dos municípios brasileiros por sexo e faixa etária disponibilizados pelo DATASUS e entrega um banco de dados com as variáveis originais mais a faixa etária quinquenal.
#'
#' @param x Nome do arquivo armazenado no computador, ou ano da estimativa ou contagem populacional a ser capturada no site FTP DATASUS. Se o alvo é um arquivo no computador, o nome com a extensão (dbf) deve vir entre aspas. Se o alvo é um arquivo do servidor FTP do DATASUS, deve-se usar o argumento \code{ano}, com o ano (sem aspas) desejado, de 1980 a 2024. Apenas arquivos em formato DBF são lidos.
#'
#' @details
#'  Nos arquivos de 2013 a 2024 o código IBGE do município está registrado com todos os sete dígitos, enquanto nos arquivos de 1980 a 2012, como em outros SIS com dados disponibilizados pelo DATASUS, são registrados apenas os seis primeiros dígitos do código. \code{ler_popbr} devolve uma variável (\code{munic_res}) de caracteres com os seis primeiros dígitos.
#'
#'  As informações atualizadas podem ser tabuladas em
#'  http://tabnet.datasus.gov.br/cgi/deftohtm.exe?ibge/cnv/popsvs2024br.def
#'
#' @references
#' http://tabnet.datasus.gov.br/cgi/IBGE/SEI_MS-0034745983-Nota_Tecnica_final.pdf
#'
#' @examples
#' \dontrun{
#' # Um arquivo no computador:
#' popBR2010 <- ler_popbr("data-raw/POPBR10.DBF")
#' head(popBR2010)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)
#'
#' popBR2024 <- ler_popbr("data-raw/POPBR24.DBF")
#' head(popBR2024)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2024)
#' }
#'
#' # Um arquivo no diretório FTP do DATASUS
#' popBR2010 <- ler_popbr(2010)
#' head(popBR2010)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2010)
#'
#' popBR2013 <- ler_popbr(2013)
#' head(popBR2013)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2013)
#'
#' popBR2024 <- ler_popbr(2024)
#' head(popBR2024)
#' xtabs(populacao ~ fxetar5 + sexo, data = popBR2024)
#'
#' @importFrom utils download.file unzip
#' @importFrom dplyr relocate
#' @export

ler_popbr <- function(x) {
  fxetar5 <- fxetaria <- situacao <- NULL

  ano <- arquivo <- NULL
  if(x %in% 1980:2024) ano = x
    else arquivo = x

  if(!is.null(ano)) {
    if(ano %in% 1980:2012) {
      pop <- paste0("POPBR", substr(as.character(ano), 3,4))
      url <- paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POP/", pop, ".zip")
      temp <- tempfile()
      download.file(url, temp)
      unzip(temp, paste0(pop, ".DBF"))
      populacao <- foreign::read.dbf(paste0(pop, ".DBF"))
      # populacao$SITUACAO <- NULL
      unlink(temp)
      unlink(paste0(pop, ".DBF"))
    } else if(ano %in% 2013:2024){
      pop <- paste0("POPSBR", substr(as.character(ano), 3,4))
      url <- paste0("ftp://ftp.datasus.gov.br/dissemin/publicos/IBGE/POPSVS/", pop, ".zip")
      pop <- paste0(substr(pop, 1,3), substr(pop, 7,8))
      if(ano %in% 2013:2021) {
        pop <- tolower(pop)
      }
      temp <- tempfile()
      download.file(url, temp)
      unzip(temp, paste0(pop, ".dbf"))
      populacao <- foreign::read.dbf(paste0(pop, ".dbf"))
      unlink(temp)
      unlink(paste0(pop, ".dbf"))
    } else if(ano %in% 1980:2024 == FALSE){
      stop("S\u00f3 h\u00e1 arquivos dispon\u00edveis para os anos 1980 a 2024.")
    }
  } else if(!is.null(arquivo)) {
    if(grepl('dbf', arquivo, ignore.case = TRUE)) {
      populacao <- foreign::read.dbf(arquivo)
    }
  }

  names(populacao) <- tolower(names(populacao))

  if( unique(populacao$ano) %in% 2013:2024) {
    names(populacao)[1] <- "munic_res"
    names(populacao)[4] <- "fxetaria"
    names(populacao)[5] <- "populacao"

    populacao$fxetar5 <- populacao$fxetaria |>
      as.character() |>
      as.numeric() |>
      cut(breaks = c(seq(0, 80, 5), Inf), right = FALSE)
  }

  if(unique(populacao$ano) %in% c(1980, 1991, 1996:2012)) {
    populacao$fxetar5 <- cut(as.numeric(populacao$fxetaria),
                             breaks = c(0, 5, 10, 15, 20:33))
  } else if(unique(populacao$ano) %in% c(1981:1990, 1992)) {
    populacao$fxetar5 <- populacao$fxetaria
  } else if(unique(populacao$ano) %in% 1993:1995) {
     populacao$fxetar5 <- cut(as.numeric(populacao$fxetaria),
                              breaks = c(0, 5:21))
  }

  # Deixar o código IBGE do município com os seis primeiros caracteres (de 2013 em diante tem sete) e a variável como caractere:
  populacao$munic_res <- as.character(populacao$munic_res) |> substr(1,6)

  # Rótulos para a faixa etária
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
   attr(populacao$fxetar5, which = "label") <- "Faixa et\u00e1ria quinquenal"
   # attr(populacao$munic_res, which = "label") <- "Codigo IBGE do municipio"
   # names(populacao)[5] <- "fxetar.det"
   populacao <- relocate(populacao, fxetar5, .before = fxetaria)
   if (x <= 2012) {
     populacao <- relocate(populacao, situacao, .before = ano)
     attr(populacao$fxetaria, which = "label") <- "Faixa et\u00e1ria detalhada"
   } else if (x > 2012) {
     attr(populacao$fxetaria, which = "label") <- "Idade em anos completos"
   }
 populacao
}

#'
#' Estimativas populacionais para os municípios brasileiros.
#'
#' @description Lê os arquivos com estimativas e contagens da população dos municípios brasileiros por sexo e faixa etária disponibilizados pelo DATASUS.
#' @param x Ano ou vetor com os anos a serem lidos.
#' @param uf Unidade(s) da Federação de interesse para seleção. O padrão é todas.
#' @param municipio Município(s) de interesse para seleção. O padrão é todos. Ainda não implementado.
#' @param idade Argumento lógico. A idade detalhada deve ser apresentada? O padrão é FALSE (v. Details).
#' @examples
#' popbr(2017:2019) |> str()
#' popbr(c(2017, 2019))  |> str()
#' popbr(2022, "SC") |> head()
#' popbr(2010, "RS", idade = TRUE) |> head()
#' # O exemplo seguinte dá erro, porque a estrutura da base muda em 2013.
#' \dontrun{
#' popbr(2012:2013)
#' }
#'
#' @importFrom dplyr `%>%` group_by group_by_at reframe inner_join mutate select filter
#' @export
#'
popbr <- function(x, uf = NULL, municipio = NULL, idade = FALSE) {
  # Nuntius errorum
    if(!is.null(uf)) {
      if(!uf %in% ufbr()$UF_SIGLA) {
      stop("'uf' deve ser uma de RO, AC, AM, RR, PA, AP, TO, MA, PI, CE, RN,
    PB, PE, AL, SE, BA, MG, ES, RJ, SP, PR, SC, RS, MS, MT, GO ou DF") }
    }
  # ---------

  munic_res <- UF_SIGLA <- fxetar5 <- fxetaria <- situacao <- NULL

  if (length(x) > 1) {
    resultados <- lapply(x, ler_popbr)
    populacao <- do.call(rbind, resultados)
  } else {
    populacao <- ler_popbr(x)
  }
  vars <- c("munic_res", "ano", "sexo", "fxetar5", "fxetaria")
  if(!is.null(uf)) {
    vars <- vars[-1]
    populacao <- populacao %>%
      mutate(CO_UF = substr(munic_res, 1, 2)) %>%
      inner_join(csapAIH::ufbr()) %>%
      filter(UF_SIGLA %in% uf) %>%
      reframe(populacao = sum(populacao), .by = c(UF_SIGLA, vars))
  } else if(!is.null(municipio)) {
    # Nuntius errorum
    # if(!is.null(uf)) { stop("Para a população por município, deixe 'uf' em branco.")}
    if(!municipio %in% populacao$munic_res) { stop("Digite o c\u00f3digo IBGE do munic\u00edpio com seis d\u00edgitos.")}
    # ---------
    # vars <- vars[-1]
    populacao <- populacao %>%
      filter(municipio %in% munic_res) %>%
      reframe(populacao = sum(populacao), .by = vars)
  }
  if(isFALSE(idade)) {
    vars <- names(populacao)[-c(4,6)]
    return(list(vars, nomes = names(populacao)))
    populacao <- populacao %>%
      # select(-fxetaria) %>%
      reframe(populacao = sum(populacao), .by = vars)
  } #else if (is.null(idade)) populacao <- populacao


  populacao
}
#'
