#' @title Obstetric procedures from the Brazilian Hospital Information System data bases (BD-SIH/SUS)
#' @aliases proc.obst
#'
#' @description Identifies records of hospitalizations for non-morbidity obstetric procedures (v.g. deliveries etc.) from the Brazilian Hospital Information System data bases (BD-SIH/SUS) and, according to user options, (1) create a new variable \code{procobst} with the procedure identification, (2) exclude these records from the data frame, or (3) create a new data frame with only these records.
#'
#' @param x A data frame with the Brazilian records for hospital discharges from Unified Health System, the Hospital Admission Autorization Form -- "Autorização de Internação Hospitalar (AIH)", v.g. "AIH files -- arquivos da AIH", on the Bases de Dados do Sistema de Informacao Hospitalar do SUS -- BD-SIH/SUS.
#' @param procobst.action Character argument indicating the action to be fulfilled on the data frame: (1) \code{"exclude"} (default) returns a data frame without the hospitalizations for obstetric procedures, (2) \code{"extract"} returns a data frame with only the hospitalizations for obstetric procedures, (3) \code{"identify"} returns a data frame with all the original records plus one variable (\code{procobst}) of class \code{factor} indicating whether the hospitalization was for an obstetric procedure or not.
#' @param proc.rea Procedure performed, name to the "procedimento realizado" field (\code{PROC_REA}) on the AIH file).
#' @param language Language for displayed messages and summary of fulfilled actions; may be "pt" (default) for portuguese or "en" for english.
#'
#' @seealso \code{\link{legoAIH}} and \link{csapAIH}
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @export
#'
proc.obst <- function(x, procobst.action = "exclude", proc.rea = "PROC_REA", language = "pt")
  {
  if(!is.data.frame(x) & class(x) != "data.table") stop("x must be a data frame")
  if(! procobst.action %in% c("exclude", "extract", "identify")) {
    stop("'language' must be 'exclude', 'extract' or 'identify'")
  }

  # Total of read records
  readrecs = nrow(x)
  if (language == "pt") {
    suppressWarnings(message("Importados ", format(readrecs, big.mark = "."), " registros."))
  }
  if (language == "en") {
    message("Read     ", format(readrecs, big.mark = " "), " records.")
  }

#------------------------------------------
#   Obstetric procedures, codes and names
#------------------------------------------
#     0310010012 ASSISTENCIA AO PARTO S/ DISTOCIA
#     0310010020 ATEND AO RECEM-NASCIDO EM SALA DE PARTO
#     0310010039 PARTO NORMAL
#     0310010047 PARTO NORMAL EM GESTACAO DE ALTO RISCO
#     0411010018 DESCOLAMENTO MANUAL DE PLACENTA
#     0411010026 PARTO CESARIANO EM GESTACAO ALTO RISCO
#     0411010034 PARTO CESARIANO
#     0411010042 PARTO CESARIANO C/ LAQUEADURA TUBARIA
#     0411020013 CURETAGEM POS-ABORTAMENTO / PUERPERAL
#     0411020021 EMBRIOTOMIA
  procobst <- c('0310010012', '0310010020', '0310010039', '0310010047', '0411010018',
                '0411010026',  '0411010034', '0411010042', '0411020013', '0411020021')

  proc.rea = x[,proc.rea] |>
    as.character()
  nprocobst = sum(proc.rea %in% procobst)
  pprocobst = nprocobst/readrecs
  rpprocobst = round(pprocobst*100, 1)

  # --------------------------------
  # IF procobst.action == "exclude"
  # --------------------------------
  if (procobst.action == "exclude") {
    x <- x[ ! proc.rea %in% procobst,]
    finrecs = nrow(x)
    pfinrecs <- round(nrow(x)/readrecs*100, 1)

    resumo = rbind(readrecs, nprocobst, finrecs)
    resumo = cbind(resumo, round(c(1, pprocobst, 1-pprocobst)*100,1) )
    colnames(resumo) = c("Freq.", "Perc.")

    if (language == "en") {
      message("Excluded  ", format(nprocobst, big.mark = " "),
              " (", rpprocobst, "\u0025) records for obstetric procedures.")
      message("Exported ",
              formatC(finrecs, big.mark = " "),
              " (", formatC(pfinrecs),
              "\u0025) records.")

      rownames(resumo) = c("Records in the original data frame",
                           "Excluded records for obstetric procedure",
                           "Records in the exported data frame")
    }
    if (language == "pt") {
      suppressWarnings(message("Exclu\u00EDdos   ", format(nprocobst, big.mark = "."),
                               " (", rpprocobst,
                               "\u0025) registros de procedimentos obst\u00E9tricos."))
      suppressWarnings(message("Exportados ",
                               formatC(finrecs, big.mark = "."),
                               " (", formatC(pfinrecs),
                               "\u0025) registros."))

    rownames(resumo) = c("Registros no banco original",
                         "Registros de procedimentos obst\u00E9tricos exclu\u00EDdos",
                         "Registros no banco final exportado")
    }
  }

  # --------------------------------
  # IF procobst.action == "extract"
  # --------------------------------
  if (procobst.action == "extract") {
    x <- x[proc.rea %in% procobst,]
    finrecs = nrow(x)
    pfinrecs <- round(nrow(x)/readrecs*100, 1)

    resumo = rbind("Records in the original data frame" = readrecs,
                   "Extracted records for obstetric procedure" = nprocobst,
                   "Records in the exported data frame" = finrecs)
    resumo = cbind(resumo, round(c(1, pprocobst, pprocobst)*100,1) )
    colnames(resumo) = c("Freq.", "Perc.")


    if (language == "en") {
      message("Extracted ",
              format(nprocobst, big.mark = " "),
              " (", rpprocobst, "\u0025) records for obstetric procedures")
      rownames(resumo) = c("Records in the original data frame",
                           "Extracted records for obstetric procedure",
                           "Records in the exported data frame")
    }

    if (language == "pt") {
      suppressWarnings(message("Exportados  ",
                               formatC(finrecs, big.mark = "."),
                               " (", formatC(pfinrecs),
                               "\u0025) registros de procedimentos obst\u00E9tricos.")
                       )

      rownames(resumo) = c("Registros no banco original",
                           "Registros de procedimentos obst\u00E9tricos exclu\u00EDdos",
                           "Registros no banco final exportado")
    }
  }

  # ---------------------------------
  # IF procobst.action == "identify"
  # ---------------------------------
  if (procobst.action == "identify") {
    x$procobst <- factor(ifelse(proc.rea %in% procobst, 1, 2), labels=c('yes', 'no'))
    finrecs = nrow(x)
    resumo = rbind(readrecs, finrecs)
    colnames(resumo) = "Freq."
    if (language == "pt") {
      rownames(resumo) = c("Registros no banco original",
                           "Registros no banco final")
    }
    if (language == "en") {
      rownames(resumo) = c("Records in the original data frame",
                           "Records in the final data frame")
    }
  }

# Returned object
#----------------------------------------------
    attr(x, which = "Records") = resumo
    # attr(banco, which = "Resumo") = resumo
    return(x)
}
