#' @title Read the Brazilian Hospital Information System data bases (BD-SIH/SUS)
#' @aliases legoAIHb
#'
#' @description Read files from the Brazilian Hospital Information System data bases (BD-SIH/SUS), in .DBC, .DBF or .CSV format, and allows to exclude, extract or identify records of hospitalization for obstetric procedures, as well to exclude duplicated records for large continuance hospitalization ("large stay AIH"). The function also makes changes in variables to be more usable: computes age in completed years, "detailed age groups" (as DATASUS tables) and five-years age groups, turns sex into a factor, and returns a data frame with less (and more used in epidemiological studies) variables.
#'
#' @param x A data file with the Brazilian records for hospital discharges from the Unified Health System ('AIH files -- arquivos da AIH'), in .DBC, .DBF or .CSV format, or yet an object of class data.frame on the active session, with the same structure of AIH files.
#' @param file TRUE (default) indicates that \code{x} is a file
#' @param procobst.rm TRUE (default) removes records for obstetric procedures hospitalization. See 'Details'.
#' @param longa.rm TRUE (default) removes records for large continuance hospitalizations. See 'Details'.
#' @param cep TRUE (default) includes the patient ZIP code in the resulting data frame; if the read data frame has the SIHSUS structure but doesn't include that variable, the argument should be passed to FALSE, otherwise the function will be stopped, by error.
#' @param cnes TRUE (default) includes the hospital registry on the Brazilian National Register for Health Centers ("Cadastro Nacional de Estabelecimentos de Saúde -- CNES)" in the returned data frame; if the read data frame has the SIHSUS structure but doesn't include the variable, this argument should be passed to FALSE, or the function will be stopped by error.
#' @param sep required argument for reading .CSV files, indicating the field separator; possible values are "," and ";".
#' @param language Language for displayed messages, summary of reading data, and variable labels; may be "pt" (default) for Portuguese or "en" for English.
#' @param ... Further arguments passed to \code{\link{read.dbf}}, \code{\link{read.csv}}, and \code{\link[read.dbc]{read.dbc}}.
#'
#' @details
#'  \itemize{
#'   \item[procobst.rm] When analyzing the proportion of causes of hospitalization (i.e. the 'proportional morbidity'), whe are usually not interested in counting in the denominator the obstetric admissions which are not due to illness. Thus, the argument \code{procobst.rm} (which equals to TRUE for default) is used to exclude admissions for childbirth or post-abortion curettage.
#'   \item[longa.rm] In the Unified Health System (SUS), when a patient stays hospitalized for more than a month, the hospital must generate other hospital admission form (AIH) for the same case. These records ("type 5 AIH") are indeed duplicated records, and thus the argument \code{longa.rm} (which for default equals to TRUE) is used to remove or not those records.
#'  }
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{idadeSUS}}, \code{\link{read.csv}}, \code{\link[read.dbc]{read.dbc}} (to read the DATASUS compressed .DBC files), and \code{\link{read.dbf}}
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @examples
#' ## An 'AIH file' in the working directory
#' ##-----------------------------------------
#' \dontrun{
#' aih <- legoAIHb('RDSC1201.dbc')
#' str(aih)
#' attributes(aih)$Resumo
#' }
#'
#' ## An 'AIH file' in the internet
#' ##---------------------------------------------
#'
#' <<<<<<<<<<< FAZER DOIS EXEMPLOS, COM E SEM O MICRODATASUS >>>>>>>>>>>>
#'
#'
#'
#' @import data.table
#' @export
#'
legoAIHb <-
# function(x, file=TRUE, procobst.rm=TRUE, longa.rm=TRUE, cep=TRUE, cnes=TRUE, sep, language="pt", ...)
  function(x, sep, vars = NULL, ...)
  {

  #===================
  ## Parat data
  #===================
  destinatio = deparse(substitute(x))

  # Lego limae data
  # if (file==TRUE) {
    if (grepl('dbc', x, ignore.case=TRUE)==TRUE) {
      x <- read.dbc::read.dbc(x, ...)
    }
    else
      if (grepl('dbf', x, ignore.case=TRUE)==TRUE) {
        x <- foreign::read.dbf(x, as.is=TRUE)
      }
    else
      if (grepl('csv', x, ignore.case=T)==T) {
        x <- data.table::fread(x)
        # if (sep == ';') x = utils::read.csv2(x, colClasses=c('PROC_REA'='character'), ...)
        # if (sep == ',') x = utils::read.csv(x, colClasses=c('PROC_REA'='character'), ...)
        }
    else
      stop('------------------------------------------------------\n
              Reading error in', deparse(substitute(x)), '. x is  \n
              not a file in format .DBC, .DBF or .CSV..
           -----------------------------------------------------\n ')
  # }
#
  # Total of imported records
  readrecs = nrow(x)
  # if (language=="pt") {
    # suppressWarnings(message("Importados ",
    #                          format(readrecs, big.mark = "."),
    #                          " registros de ", destinatio, "."))
    suppressWarnings(message("Importados ",
                             format(readrecs, big.mark = "."),
                             " registros de."))
  # }
  # if (language == "en") {
  #   message("Read     ", format(readrecs, big.mark = " "), " records.")
  #   # message("Read     ", format(readrecs, big.mark = " "), " records from ", destinatio, ".")
  # }

  #---------------------------------------#
  #   Organização e seleção de variáveis  #
  #---------------------------------------#
  #   Exclusão dos procedimentos obstétricos
  #--------------------------------------------
      # if(procobst.rm == TRUE) {
      #   x = suppressMessages(csapAIH::proc.obst(x, language = language))
      #   procedobst = attributes(x)$Records[2,1]
      #   pprocedobst = attributes(x)$Records[2,2]
      #   if (language=="pt") {
      #     suppressWarnings(message("Exclu\u00EDdos   ",
      #                              formatC(procedobst, big.mark = "."),
      #                              " (",
      #                              formatC(pprocedobst, decimal.mark = ","),
      #                              "\u0025) registros de procedimentos obst\u00E9tricos.",
      #                              sep="")
      #                      )
      #   }
      #   if (language=="en") {
      #     message("Excluded  ",
      #             formatC(procedobst, big.mark = " "),
      #             " (", pprocedobst, "\u0025) records for obstetrics procedures.")
      #   }
      # }
  #--------------------------------------------
  #   Exclusão das AIHs de longa permanência
  #--------------------------------------------
      # if (longa.rm == TRUE) {
      #   longa.permanencia = table(x$IDENT)[2]
      #   fr <- suppressWarnings(format(longa.permanencia, big.mark = "."))
      #   pfr <- round(prop.table(table(x$IDENT))[2]*100,1)
      #   x <- droplevels(subset(x, x$IDENT==1)) # hic exclusio
      #   pfin <- round(nrow(x)/readrecs*100, 1)
      #   if (language=="pt") {
      #     suppressWarnings(message("Exclu\u00EDdos     ",
      #                              fr,
      #                              " ( ", formatC(pfr, decimal.mark = ","),
      #                              "\u0025) registros de AIH de longa perman\u00EAncia.",
      #                              sep=""))
      #     suppressWarnings(message("Exportados ",
      #                              formatC(nrow(x), big.mark = "."),
      #                              " (", formatC(pfin, decimal.mark = ","),
      #                              "\u0025) registros."))
      #   }
      #   if (language=="en") {
      #     message("Excluded    ", fr, " ( ", pfr, "\u0025) records for 'large stay' AIH.")
      #     message("Exported ",
      #             formatC(nrow(x), big.mark = " "),
      #             " (", formatC(pfin),
      #             "\u0025) records.")
      #   }
      # }

  #   Criar uma tabela com o resumo da importação
  #----------------------------------------------
      # if (procobst.rm == TRUE) {
      #   if(longa.rm == TRUE) {
      #     resumo = rbind(readrecs, procedobst, longa.permanencia, nrow(x))
      #     resumo = cbind(resumo, round(c(1, prop.table(resumo[2:4]))*100,1) )
      #
      #     if(language == "pt") {
      #       rownames(resumo) = c("Registros importados",
      #                            "Procedimentos obst\u00E9tricos exclu\u00EDdos",
      #                            "AIHs de longa perman\u00EAncia exclu\u00EDdas",
      #                            "Exportados"
      #                            )
      #       }
      #     if(language == "en") {
      #       rownames(resumo) = c("Read records",
      #                            "Excluded obstetrics procedures",
      #                            "Excluded 'large stay' AIHs",
      #                            "Exported records"
      #                            )
      #       }
      #     } else if(longa.rm == FALSE) { resumo = attributes(x)$Records }
      # }
      #
      # if (procobst.rm==FALSE) {
      #   if(longa.rm == TRUE) {
      #     resumo = rbind(readrecs, longa.permanencia, nrow(x))
      #     resumo = cbind(resumo, round(c(1, prop.table(resumo[2:3]))*100,1) )
      #
      #     if(language == "pt") {
      #       rownames(resumo) = c("Registros importados",
      #                            "AIHs de longa perman\u00EAncia exclu\u00EDdas",
      #                            "Exportados"
      #                            )
      #       }
      #     if(language == "en") {
      #       rownames(resumo) = c("Read records",
      #                            "Excluded 'large stay' AIHs",
      #                            "Exported records"
      #       )
      #     }
      #   } else if(longa.rm == FALSE) {
      #     resumo = rbind(readrecs, nrow(x))
      #     resumo = cbind(resumo, round(c(1, prop.table(resumo[2:2]))*100,1) )
      #
      #     if(language == "pt") {
      #       rownames(resumo) = c("Registros importados", "Registros exportados")
      #       }
      #     if(language == "en") {
      #       rownames(resumo) = c("Read records", "Exported records")
      #     }
      #   }
      # }
      # colnames(resumo) = c("Freq.", "Perc.")
      # resumo = list(destinatio, resumo)
      # if (language == "pt") {
      #   names(resumo) = c('Banco de dados de origem', 'Registros')
      # }
      # if (language == "en") {
      #   names(resumo) = c('Original data frame', 'Records')
      # }

    #   Criar as variáveis do banco final
    #--------------------------------------------
  if(is.null(vars)) {
    vars <- c("N_AIH", "IDADE", "COD_IDADE", "SEXO", "NASC", "DIAG_PRINC", "DT_INTER", "DT_SAIDA", "PROC_REA", "IDENT", "MUNIC_RES", "MUNIC_MOV", "CEP", "CNES")
  }
    ..vars <- DT_INTER <- DT_SAIDA <- NASC <- SEXO <- barplot <- fifelse <- idioma <- nomes <- par <- rainbow <- reorder <- setDF <- setnames <- NULL

  if(!is.data.table(x)) data.table::setDT(x)
  x <- x[, ..vars]
  # x <- x[, lapply(.SD, as.character), by = .(N_AIH, IDADE)]
  x <- x[, `:=` (nasc       = as.Date(NASC, format="%Y%m%d"),
                 data.inter = as.Date(DT_INTER, format="%Y%m%d"),
                 data.saida = as.Date(DT_SAIDA, format="%Y%m%d"),
                 idade      = csapAIH::idadeSUS(x)[["idade"]],
                 fxetar.det = csapAIH::idadeSUS(x)[["fxetar.det"]],
                 fxetar5    = csapAIH::idadeSUS(x)[["fxetar5"]],
                 sexo       = factor(SEXO, levels=c(1,3), labels=c("masc", "fem"))
                 )]
  setnames(x,
           c("N_AIH", "DIAG_PRINC", "PROC_REA", "IDENT", "MUNIC_RES", "MUNIC_MOV", "CEP", "CNES"),
           c("n.aih", "cid", "proc.rea", "longa.perm", "munres", "munint", "cep", "cnes"))
  x <- x[, !c("IDADE", "COD_IDADE", "SEXO", "NASC", "DT_INTER", "DT_SAIDA")]
  x

############################
### Montar o objeto final
############################
    # banco <- data.frame(n.aih, munres, munint, sexo, nasc, idade, fxetar.det, fxetar5,
    #                     cid, proc.rea, data.inter, data.saida)
    # if (language == "pt") {
    #   attr(banco$n.aih, which = "label") <- "No. da AIH" # N\u00B0 da AIH
    #   attr(banco$munres, which = "label") <- "Munic\u00EDpio de resid\u00EAncia"
    #   attr(banco$munint, which = "label") <- "Munic\u00EDpio de interna\u00E7\u00E3o"
    #   # attr(banco$munres, which = "label") <- "Municipio de residencia"
    #   # attr(banco$munint, which = "label") <- "Municipio de internacao"
    #   attr(banco$sexo, which = "label") <- "Sexo"
    #   attr(banco$nasc, which = "label") <- "Data de nascimento"
    #   attr(banco$idade, which = "label") <- "Idade"
    #   attr(banco$fxetar.det, which = "label") <- "Faixa et\u00E1ria detalhada"
    #   attr(banco$fxetar5, which = "label") <- "Faixa et\u00E1ria quinquenal"
    #   # attr(banco$fxetar.det, which = "label") <- "Faixa etaria detalhada"
    #   # attr(banco$fxetar5, which = "label") <- "Faixa etaria quinquenal"
    #   attr(banco$cid, which = "label") <- "CID-10"
    #   attr(banco$proc.rea, which = "label") <- "Procedimento realizado"
    #   attr(banco$data.inter, which = "label") <- "Data de internacao"
    #   attr(banco$data.saida, which = "label") <- "Data de saida"
    #   # attr(banco$data.inter, which = "label") <- "Data de internacao"
    #   # attr(banco$data.saida, which = "label") <- "Data de saida"
    # } else if (language == "en") {
    #   attr(banco$n.aih, which = "label") <- "Admission authorization form number"
    #   attr(banco$munres, which = "label") <- "Municipality of residence"
    #   attr(banco$munint, which = "label") <- "Municipality of hospitalization"
    #   attr(banco$sexo, which = "label") <- "Gender"
    #   attr(banco$nasc, which = "label") <- "Date of birth"
    #   attr(banco$idade, which = "label") <- "Age"
    #   attr(banco$fxetar.det, which = "label") <- "Detailed age group"
    #   attr(banco$fxetar5, which = "label") <- "Five-year age group"
    #   attr(banco$cid, which = "label") <- "ICD-10"
    #   attr(banco$proc.rea, which = "label") <- "Performed procedure"
    #   attr(banco$data.inter, which = "label") <- "Admission date"
    #   attr(banco$data.saida, which = "label") <- "Departure date"
    # }
    #
    # if (cep==TRUE) {
    #   banco$cep <- x$CEP
    #   if (language == "pt") {
    #     attr(banco$cep, which = "label") <- "C\u00F3digo de Endere\u00E7amento Postal"
    #     # attr(banco$cep, which = "label") <- "Codigo de Enderecamento Postal"
    #   } else if (language == "es") {
    #     attr(banco$cep, which = "label") <- "Patient ZIP code"
    #     }
    #   }
    # if (cnes==TRUE) {
    #   banco$cnes <- x$CNES
    #   if (language == "pt") {
    #     # Hmisc::label(banco$cnes) <- 'N\u00B0 do hospital no CNES'
    #     attr(banco$cnes, which = "label") <- "No. do hospital no CNES"
    #   } else if (language == "es") {
    #     attr(banco$cnes, which = "label") <- "Number of hospital registry in CNES"
    #   }
    # }
    # if (longa.rm == FALSE )  {
    #  banco$longa.perm <- longa.perm
    #  if (language == "pt") {
    #    attr(banco$longa.perm, which = "label") <- "AIH de longa permanencia"
    #  } else if (language == "es") {
    #    attr(banco$longa.perm, which = "label") <- "large stay AIH"
    #  }
    # }

    # attr(banco, which = "Resumo") = resumo
    # return(banco)
}
