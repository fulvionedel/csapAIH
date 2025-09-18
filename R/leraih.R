#' @title Ler os arquivos da AIH.
#' @aliases leraih
#'
#' @description Lê os "arquivos reduzidos" da Autorização de Internação Hospitalar (AIH).
#' @param x Alvo da função. Banco de dados com a estrutura dos arquivos da AIH, carregado como \code{data frame} na seção de trabalho ou armazenado em arquivo em formato dbc, dbf ou csv.
#' @param arquivo x é um arquivo de dados? Padrão é \code{TRUE}.
#' @param vars Variáveis da AIH para seleção. O padrão (\code{vars = NULL}), seleciona o conjunto usado em \code{\link{csapAIH}}. V. details.
#' @param procobst.rm As internações para procedimentos obstétricos devem ser excluídas? Padrão é \code{TRUE}. V. details.
#' @param parto.rm argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por parto (\code{ver detalhes});
#' @param longa.rm As internações de longa permanência (tipo 5) devem ser excluídas? Padrão é \code{TRUE}. V. details.
#' @param ... outros parâmetros das funções utilizadas
#'
#' @details
#'  \itemize{
#'   \item x pode ser:
#'    \enumerate{
#'     \item um arquivo de dados armazenado num diretório;
#'     \item um banco de dados, ou um vetor da classe \code{factor} presente como objeto no espaço de trabalho do R, em que uma das variáveis, ou o vetor, contenha códigos da CID-10.
#'    }
#' Se for um arquivo, o nome deve ser escrito entre aspas e com a extensão do arquivo (DBC, DBF ou CSV, em minúsculas ou maiúsculas). Se não estiver no diretório de trabalho ativo, seu nome deve ser precedido pelo caminho (path) até o diretório de armazenamento. Se estiver em outro formato, podem-se usar os argumentos da função \code{\link{read.table}} para leitura dos dados.
#'
#' \item \code{procbst.rm} TRUE (padrão) exclui as internações por procedimentos relacionados ao parto ou abortamento. São excluídas as internações pelos seguintes procedimentos obstétricos, independente do diagnóstico principal de internação (variável `DIAGPRINC`):
#'   \itemize{
#'    \item 0310010012  ASSISTENCIA AO PARTO S/ DISTOCIA
#'    \item 0310010020  ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO
#'    \item 0310010039  PARTO NORMAL
#'    \item 0310010047  PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO
#'    \item 0411010018  DESCOLAMENTO MANUAL DE PLACENTA
#'    \item 0411010026  PARTO CESARIANO EM GESTAÇÃO ALTO RISCO
#'    \item 0411010034  PARTO CESARIANO
#'    \item 0411010042  PARTO CESARIANO C/ LAQUEADURA TUBÁRIA
#'    \item 0411020013  CURETAGEM PÓS-ABORTAMENTO / PUERPERAL
#'    \item 0411020021  EMBRIOTOMIA
#'    }
#' \item \code{parto.rm } TRUE (padrão) exclui as internações por parto pelo campo diagnóstico, independente do procedimento. São excluídas as internações com os seguintes diagnósticos (CID-10):
#'  \itemize{
#'   \item O80 Parto único espontâneo
#'   \item O81 Parto único por fórceps ou vácuo-extrator
#'   \item O82 Parto único por cesariana
#'   \item O83 Outros tipos de parto único assistido
#'   \item O84 Parto múltiplo
#'  }
#'
#' É retornada uma mensagem informando o número de registros lidos, o número e proporção de registros excluídos e o total de registros importados.
#'
#' }
#'
#' @examples
#' leraih(aih500) |> head()
#' leraih(aih500, procobst.rm = FALSE) |> head()
#' leraih(aih500, parto.rm = FALSE) |> head()
#' \dontrun{
#' leraih("data-raw/RDRS1801.dbc", vars = c("DIAG_PRINC", "SEXO", "IDADE", "MUNIC_RES")) |> head()
#' leraih("data-raw/RDRS1801.dbf", vars = c("DIAG_PRINC", "SEXO", "IDADE", "COD_IDADE")) |> head()
#' }
#'
#' @seealso [idadeSUS()]
#'
#' @importFrom utils hasName
#' @export
#'
leraih <- function(x, arquivo=TRUE, procobst.rm=TRUE, parto.rm=TRUE, longa.rm=TRUE, vars = NULL, ...)
  {
    # # Nuntius errorum
    # # ----------------
    # if (grepl("data.frame", list(class(x))) | grepl("data.table", list(class(x)))) file = FALSE
    # if (file == FALSE & (!grepl("data.frame", list(class(x))) & !grepl("data.table", list(class(x))))) {
    #   stop("x must be a .DBC, .DBF, or .CSV file, otherwise a data frame in the workspace")
    # }

  # Leitura do arquivo de dados    # Lego limae data
  if (is.data.frame(x)) {
    arquivo <- FALSE
    # if(is.tbl(x)) x <- as.data.frame(x)
  }

  if (isTRUE(arquivo)) {
    if ( isTRUE(grepl('dbc', x, ignore.case = TRUE))) {
      x <- read.dbc::read.dbc(x, ...)
    } else if ( isTRUE(grepl('dbf', x, ignore.case = TRUE) )) {
        x <- foreign::read.dbf(x, as.is = TRUE, ...)
      } else if ( isTRUE(grepl('csv', x, ignore.case=T))) {
          sep <- NULL
          if (sep == ';') x = utils::read.csv2(x, colClasses=c('PROC_REA'='character'), ...)
          if (sep == ',') x = utils::read.csv(x, colClasses=c('PROC_REA'='character'), ...)
        # x <- data.table::fread(x, ...)
      } else
      warning('------------------------------------------------------\n
                ERRO DE LEITURA em ', deparse(substitute(x)), ' \n
                O objeto deve ser da um "data.frame" ou um arquivo \n
                no formato .dbc, .dbf ou .csv. \n
                -----------------------------------------------------\n ')
    if(!data.table::is.data.table(x)) x <- data.table::setDT(x)
  }
#

  # Total de registros importados
  nlidos <- nrow(x)
  if (is.data.frame(x)) {
    message(paste(c("Importados ",
                    suppressWarnings(formatC(nlidos <- nrow(x), big.mark = ".")),
                    " registros.")))
    importados <- paste(c("Importados", nlidos, 100, "registros."))
  }

  # Contagem de registros excluídos ---- início da função
  #
  freqs <- function(tamini, tamfin, digits = 1, tipo = "proc") {
    fr <- tamini - tamfin
    pfr <- round(fr / tamini * 100, digits)
    fr.form <- suppressWarnings(format(fr, big.mark = "."))
    pfr.form <- format(pfr, decimal.mark = ",")
    if (tipo == "proc") {
      excluidos.obst <- c("Exclu\u00EDdos",
                          fr, pfr,
                          "registros de procedimentos obst\u00E9tricos.")
      message( c("Exclu\u00EDdos ",
                 fr.form, " (", pfr.form, "\u0025) "),
               "registros de procedimentos obst\u00E9tricos." )
    } else if (tipo == "diag") {
      excluidos.obst <- c("Exclu\u00EDdos",
                          fr, pfr,
                          "registros de parto.")
      message(c("Exclu\u00EDdos ",
                fr.form, " (", pfr.form, "\u0025) "),
              "registros de parto.")
    }
    excluidos.obst
  }
  # ----------------------- fim da função

  # Procedimentos obstétricos
  # ---------------------------
  x$DIAG_PRINC <- as.character(x$DIAG_PRINC)
  if (procobst.rm == TRUE) {
    # x <- proc.obst(x)
    x <- suppressMessages( proc.obst(x) )
    if (parto.rm == TRUE) {
      x <- subset(x, subset = x$DIAG_PRINC < "O80" | x$DIAG_PRINC >= "O85")
    }
    # x <- droplevels(x)
    excluidos.obst <- freqs(nlidos, nrow(x))
  } else if (procobst.rm == FALSE) {
    if (parto.rm == TRUE) {
      x <- subset(x, subset = x$DIAG_PRINC < "O80" | x$DIAG_PRINC >= "O85", drop = TRUE)
      excluidos.obst <- freqs(nlidos, nrow(x), tipo = "diag")
    }
  }

  #   Exclusão das AIHs de longa permanência
  #--------------------------------------------
  if(isFALSE(hasName(x, "IDENT"))) {
    longa.rm <- FALSE
  }
  if (isTRUE(longa.rm)) {
    fr <- table(x$IDENT)[2]
    pfr <- round((fr/nlidos)*100,1)
    # pfr <- round(prop.table(table(x$IDENT))[2]*100,1)
    fr.form <- suppressWarnings(format(fr, big.mark = "."))
    pfr.form <- format(pfr, decimal.mark = ",")
    x <- subset(x, x$IDENT==1)
    excluidos.lp <- c("Exclu\u00EDdos", fr, pfr,
                      "registros de AIH de longa perman\u00EAncia.")
    message("Exclu\u00EDdos ", fr.form, " (", pfr.form, "\u0025) registros de AIH de longa perman\u00EAncia.")
  }

  #   Construção da tabela com o resumo das importações
  #   (isso tem de melhorar, tem código repetido e mistura
  #   mensagem com valor, não sei se é legal!)

  exportados <- paste(c("Exportados",
                        nrow(x),
                        pexportados <- round((1-(nlidos-nrow(x))/nlidos)*100,1), "registros."))
  message(paste(c("Exportados ", suppressWarnings(formatC(length(x[,1]), big.mark = ".")), " (", formatC(pexportados, decimal.mark = ","), "\u0025) registros.")))
  resumo <- rbind(importados, exportados)
  colnames(resumo) = c("acao", "freq", "perc", "objeto")
  if (longa.rm == TRUE) {
    if (exists('excluidos.obst')) {
      resumo <- rbind(resumo[1,],
                      excluidos.obst,
                      excluidos.lp,
                      resumo[2,])
    } else
      resumo <- rbind(resumo[1,],
                      excluidos.lp,
                      resumo[2,])
  } else if (longa.rm == FALSE) {
    if (exists('excluidos.obst')) {
      resumo <- rbind(resumo[1,],
                      suppressWarnings(excluidos.obst),
                      resumo[2,])
    } else
      resumo <- resumo
  }
  rownames(resumo) <- NULL
  resumo <- as.data.frame(resumo)
  resumo$freq <- as.numeric(as.character(resumo$freq))
  resumo$perc <- as.numeric(as.character(resumo$perc))


  #   Montar o banco final
  #--------------------------------------------
      if(!is.null(vars)) {
        # vars = c("DIAG_PRINC", vars)
        vars = vars
      } else {
        vars = c("MUNIC_RES", "COD_IDADE", "IDADE", "SEXO", "DIAG_PRINC", "PROC_REA", "DT_INTER", "DT_SAIDA")
      }
      x <- x[, vars] |> as.data.frame()
      if(length(vars == 1)) names(x) <- vars

      # if("N_AIH" %in% vars) {
      #   x$N_AIH <- as.character(x$N_AIH)
      #   # names(x)[which(names(x) == 'N_AIH')] <- 'n.aih'
      # }
      if( "IDADE" %in% vars ) {
        if (!"COD_IDADE" %in% vars) {
          warning("Para computar a idade, inclua o campo 'COD_IDADE'.")
          x$.tempovida <- x$IDADE
          x$IDADE <- NA
        } else
        x$IDADE <- idadeSUS(x)$idade
        x$COD_IDADE <- NULL
      }
      if("SEXO" %in% vars) {
        x$SEXO <- factor(x$SEXO, levels = c(1, 3), labels=c("masc", "fem"))
      }
      if("NASC" %in% vars) {
        x$NASC <- as.Date(format(x$NASC), format="%Y%m%d")
      }
      if("DT_INTER" %in% vars) {
        x$DT_INTER <- as.Date(format(x$DT_INTER), format="%Y%m%d")
        # names(x)[which(names(x) == 'DT_INTER')] <- 'data.inter'
      }
      if("DT_SAIDA" %in% vars) {
        x$DT_SAIDA <- as.Date(format(x$DT_SAIDA), format="%Y%m%d")
        # names(x)[which(names(x) == 'DT_SAIDA')] <- 'data.saida'
      }
      if("MUNIC_RES" %in% vars) {
        x$MUNIC_RES <- x$MUNIC_RES
        # names(x)[which(names(x) == 'MUNIC_RES')] <- 'munres'
      }
      if("MUNIC_MOV" %in% vars) {
        x$MUNIC_MOV   <- x$MUNIC_MOV
        # names(x)[which(names(x) == 'MUNIC_MOV')] <- 'munint'
      }
      # if("CEP" %in% vars) {
      #   X$cep <- x$CEP
      #   x$CEP <- NULL
      #   # Hmisc::label(banco$cep) <- 'C\u00F3digo de Endere\u00E7amento Postal'
      #   # attr(X$cep, which = "label") <- "Codigo de Enderecamento Postal"
      # }
      # if("CNES" %in% vars) {
      #   X$cnes <- x$CNES
      #   x$CNES <- NULL
      #   # Hmisc::label(banco$cnes) <- 'N\u00B0 do hospital no CNES'
      #   # attr(x$cnes, which = "label") <- "No. do hospital no CNES"
      # }
      # if("PROC_REA" %in% vars) {
      #   names(x)[which(names(x) == 'PROC_REA')] <- 'proc.rea'
      #   # x$proc.obst <- factor(ifelse(x$proc.rea %in% procobst, 1, 2), labels=c('sim', 'nao'))
      # }

      attr(x, which = "resumo") <- resumo

    # cid = as.character(x$DIAG_PRINC)
    #
    # attr(x$n.aih, which = "label") <- "No. da AIH"
    # attr(x$munres, which = "label") <- "Municipio de residencia"
    # attr(x$munint, which = "label") <- "Municipio de internacao"
    # attr(x$sexo, which = "label") <- "Sexo"
    # attr(x$nasc, which = "label") <- "Data de nascimento"
    # attr(x$idade, which = "label") <- "Idade"
    # attr(x$fxetar.det, which = "label") <- "Faixa etaria detalhada"
    # attr(x$fxetar5, which = "label") <- "Faixa etaria quinquenal"
    # attr(x$cid, which = "label") <- "CID-10"
    # x$cid <- as.character(banco$cid)
    # attr(x$proc.rea, which = "label") <- "Procedimento realizado"
    # attr(x$data.inter, which = "label") <- "Data de internacao"
    # attr(x$data.saida, which = "label") <- "Data de saida"
    #
  return(x)
}
