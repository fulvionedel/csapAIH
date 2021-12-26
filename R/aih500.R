#' @title Data frame with selected records from an 'AIH file'
#' @name aih500
#' @aliases aih500
#' @docType data
#'
#' @description A data frame with 500 records and all variables for the hospital admission form (Autorização de Internação Hospitalar - AIH), the "AIH files" (RD??????.DBC or RD??????.DBF) from DATASUS (Brazil, Ministry of Health), year 2018.
#'
#' @usage data(aih500)
#'
#' @source \url{http://www2.datasus.gov.br/DATASUS/index.php?area=0901}
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @examples
#' data("aih500")
#' str(aih500)
#' @keywords datasets
"aih500"

# aih500 <- read.dbc::read.dbc("data-raw/RDRS1801.dbc")
# aih500 <- aih500[sample(nrow(aih500), 500), ]
# write.csv2(aih500, file = "data-raw/aih500.csv")
# usethis::use_data(aih500, overwrite = TRUE)
