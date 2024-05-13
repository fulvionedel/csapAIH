#' @title Banco com 1000 registros de hospitalização do Equador.
#' @name eeh20
#' @aliases eeh20
#' @docType data
#'
#' @description A \emph{Encuesta de Egresos Hospitalarios} registra as hospitalizações ocorridas em todo o Equador, no setor público e privado. Aqui é apresentada uma amostra aleatória da base de dados do ano 2020.
#'
#' @usage data(eeh20)
#'
# Um banco de dados (classe \code{data.frame}) com 1000 observações e as seguintes variáveis:
#'
#' @source
#' \url{https://www.ecuadorencifras.gob.ec/}
#'
#' @examples
#' data("eeh20")
#' str(eeh20)
#'
#' @keywords datasets
"eeh20"

# # Ler o arquivo de dados
# temp <- tempfile()
# download.file("https://www.ecuadorencifras.gob.ec/documentos/web-inec/Estadisticas_Sociales/Camas_Egresos_Hospitalarios/Cam_Egre_Hos_2020/BDD_Camas_Egresos_Hospitalarios_2020.zip",
#               temp)
# eeh20 <- unzip(temp, "1. Base_de_datos_EEH_2020.zip")
# eeh20 <- unzip(eeh20, "1. Base_de_datos_EEH_2020/egresos_hospitalarios_2020.sav")
# eeh20 <- haven::read_sav("1. Base_de_datos_EEH_2020/egresos_hospitalarios_2020.sav")
# unlink(temp)
# rm(temp)
#
# # Selecionar uma amostra aleatória de 100 registros e todas as variáveis da AIH
# eeh20 <- eeh20[sample(nrow(eeh20), 1000), ]
# rownames(eeh20) <- NULL
# # str(eeh20)
#
# # Criar o arquivo dados com os registros selecionados
# write.csv2(eeh20, file = "data-raw/eeh20.csv")
# # save(aih100, file = "data/aih100.rda")
# usethis::use_data(eeh20, overwrite = TRUE, compress = "xz")
