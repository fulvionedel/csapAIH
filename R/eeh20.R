#' @title Banco com 1000 registros de hospitalização do Equador.
#' @name eeh20
#' @aliases eeh20
#' @docType data
#'
#' @description A *Encuesta de Egresos Hospiatalarios* registra as hospitalizações ocorridas em todo o Equador, no setor público e privado. Aqui é apresentada uma amostra aleatória da base de dados do ano 2020.
#'
#' @usage data(eeh20)
#'
# Um banco de dados (classe \code{data.frame}) com 1000 observações e as seguintes variáveis:
#'
#' @source
#' \url{https://www.ecuadorencifras.gob.ec/}
#' O Equador tem mudado os links e nomes ou estrutura da árvore de arquivos. Além disso as últimas buscas têm direcionado a uma página para download dos arquivos em que não se pode copiar o link da fonte, obrigando ao download e salvamento do arquivo em alguma pasta. ... :(
#' Nas bases disponíveis através da página https://anda.inec.gob.ec/anda/index.php/catalog/SOCDEMO parece que ainda podemos copiar o link do arquivo-fonte desejado. O deste exemplo, a _Encuesta de Egresos Hospitalarios_ do ano 2020, é, neste momento, esse: https://anda.inec.gob.ec/anda/index.php/catalog/883/get_microdata.
#'
#' @references
#' Arrumar
#'
#' @examples
#' data("eeh20")
#' str(eeh20)
#'
#' @keywords datasets
"eeh20"

# # Ler o arquivo de dados
# # O Equador tem mudado os links e nomes ou estrutura da árvore de arquivos... :(
# # link <- "https://www.ecuadorencifras.gob.ec/documentos/web-inec/Estadisticas_Sociales/Camas_Egresos_Hospitalarios/Cam_Egre_Hos_2020/BDD_Camas_Egresos_Hospitalarios_2020.zip"
# # eeh20 <- unzip(temp, "1. Base_de_datos_EEH_2020.zip")
# # eeh20 <- unzip(eeh20, "1. Base_de_datos_EEH_2020/egresos_hospitalarios_2020.sav")
# # eeh20 <- unzip(eeh20, "1. Base_de_datos_EEH_2020/egresos_hospitalarios_2020.sav")
# # eeh20 <- haven::read_sav("1. Base_de_datos_EEH_2020/egresos_hospitalarios_2020.sav")
# link <- "https://anda.inec.gob.ec/anda/index.php/catalog/883/download/18480" # em 09/04/2023
# temp <- tempfile()
# download.file(link,  temp, mode = "wb")
# unzip(temp, list = T)
# eeh20 <- haven::read_sav("2. Base de Datos de Egresos Hospitalarios/egresos_hospitalarios_2020.sav")
# unlink(temp)
# rm(link, temp)
#
# # Selecionar uma amostra aleatória de 1000 registros e todas as variáveis do banco
# eeh20 <- eeh20[sample(nrow(eeh20), 1000), ]
# rownames(eeh20) <- NULL
# # str(eeh20)
#
# # Criar o arquivo dados com os registros selecionados
# write.csv2(eeh20, file = "data-raw/eeh20.csv")
# usethis::use_data(eeh20, overwrite = TRUE, compress = "xz")
