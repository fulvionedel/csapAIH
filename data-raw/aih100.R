#' @title Banco com 100 registros de um 'arquivo da AIH' (RD??????.DBF).
#' @name aih100
#' @aliases aih100
#' @docType data
#'
#' @description Contém todas as variáveis dos "arquivos da AIH" em sua forma atual.
#'
#' @usage data(aih100)
#'
#' @format
# Um banco de dados (classe \code{data.frame}) com 100 observações e as seguintes variáveis:
#'
#' @source
#' \url{http://www2.datasus.gov.br/DATASUS/index.php?area=0901}
#'
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @examples
#' data("aih100")
#' str(aih100)
#'
#' @keywords datasets
"aih100"

# Ler o "arquivo da AIH"
## Sem acesso ao ftp do DATASUS
aih <- read.dbc::read.dbc("../RDRS1801.dbc")
## Com acesso ao ftp do DATASUS 
temp <- tempfile()
download.file(url="ftp://ftp.datasus.gov.br/dissemin/publicos/SIHSUS/200801_/Dados/RDRS1801.dbc", destfile = temp)
aih <- read.dbc::read.dbc(temp)

# Selecionar uma amostra aleatória de 100 registros e todas as variáveis da AIH
aih100 <- aih[sample(rownames(aih), 100), ]
rownames(aih100) <- NULL
str(aih100)

# Criar o arquivo dados com os registros selecionados
write.csv2(aih100, file = "data-raw/aih100.csv")
# save(aih100, file = "data/aih100.rda")
usethis::use_data(aih100, overwrite = TRUE, compress = "xz")
