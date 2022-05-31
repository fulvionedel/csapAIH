#' @title Banco com 500 registros de um "arquivo da AIH", ano 2018
#' @name aih500
#' @aliases aih500
#' @docType data
#'
#' @description Amostra aleatória de 500 registros e todas as variáveis de um "arquivo da AIH" (RD??????.DBC), ano 2018.
#'
#' @usage data(aih500)
#'
#' @source \url{http://www2.datasus.gov.br/DATASUS/index.php?area=0901}
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @examples
#' data("aih500")
#' str(aih500)
#' @keywords datasets
"aih500"

# aih500 <- read.dbc::read.dbc("data-raw/RDRS1801.dbc")
# set.seed(1)
# aih500 <- aih500[sample(nrow(aih500), 500), ]
# rownames(aih500) <- NULL
#
# write.csv2(aih500, file = "data-raw/aih500.csv")
#
# # Problema de cadeias não ASCII
# Encoding(levels(aih500$AUD_JUST)) <- "UTF-8"
# levels(aih500$AUD_JUST)
#
# # Mandar pro diretório de dados de exemplo
# usethis::use_data(aih500, overwrite = TRUE)
