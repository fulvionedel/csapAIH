#' Baixa os arquivos da AIH e classifica em CSAP
#' @aliases fetchcsap
#'
#' @description
#' Descarrega os "arquivos da AIH" (arquivos RD<UFAAMM>.DBC) do site FTP do DATASUS e classifica as internações segundo a Lista Brasileira de Condições Sensíveis à atenção Primária.
#'
#' @param uf Unidade da Federação
#' @param mesinicio Mês de competência da AIH para início da seleção dos dados
#' @param anoinicio Ano de competência da AIH para início da seleção dos dados
#' @param mesfim    Mês de competência da AIH para fim da seleção dos dados
#' @param anofim    Ano de competência da AIH para fim da seleção dos dados
#'
#' @returns Um objeto da classe data.table/data.frame com as seguintes variáveis:
#' \describe{
#'   \item{\code{munres}}{Município de residência do paciente}
#'   \item{\code{munint}}{Município de internação do paciente}
#'   \item{\code{sexo}}{Sexo do paciente}
#'   \item{\code{idade}}{Idade do paciente em anos completos}
#'   \item{\code{fxetar.det}}{Faixa etária detalhada}
#'   \item{\code{fxetar5}}{Faixa etária quinquenal (0-4, ..., 76-79, 80 e +)}
#'   \item{\code{csap}}{Internação por CSAP (sim/não)}
#'   \item{\code{grupo}}{Grupo de causa da Lista Brasileira de ICSAP, ou "não-CSAP"}
#'   \item{\code{cid}}{Diagnóstico principal da internação, segundo a Classificação Internacional de Doenças, 10ª Revisão}
#'   \item{\code{data.inter}}{Data da internação}
#'   \item{\code{data.saida}}{Data da alta}
#' }
#'
#' @examples
#' fetchcsap("RS", anoinicio = 2022, mesfim = 1) |>
#'   str()
#' # fetchcsap("RS", anoinicio = 2022, mesfim = 1, anofim = 2022) |>
#' #   str()
#'
#' @importFrom data.table setDT `:=`
#'
#' @export
fetchcsap <- function(uf, mesinicio = 1, anoinicio = NULL, mesfim = 6, anofim = NULL) {
':=' <- setDT <- DT_INTER <- idade <- NULL

  # Seleção de variáveis da AIH
  vars <- c("DIAG_PRINC", "NASC", "DT_INTER", "DT_SAIDA", "IDADE", "COD_IDADE", "MUNIC_RES", "MUNIC_MOV", "SEXO", "N_AIH", "PROC_REA", "IDENT")

  if(is.null(anofim)) { anofim <- anoinicio }

  # Baixar os dados do DATASUS
  aih  <- microdatasus::fetch_datasus(year_start  = anoinicio,
                                      month_start = mesinicio,
                                      year_end    = anofim,
                                      month_end   = mesfim,
                                      # uf = deparse(substitute(uf)),
                                      uf = uf,
                                      information_system = "SIH-RD",
                                      vars = vars)

  # Selecionar o período de interesse
  # setDT(aih)
  # aih <- aih[as.character(DT_INTER) >= "20170101", ]
  # aih <- aih[as.character(DT_INTER) <= "20191231", ]
  # aih <- data.frame(aih)

  # Classificar as CSAP
  csap <- setDT(csapAIH::csapAIH(aih, cep = FALSE, cnes = FALSE))
  csap <- csap[, c("nasc", "n.aih", "proc.rea") := NULL]
  csap$fxetar3 = cut(csap$idade,
                     breaks = c(0, 15, 60, max(idade, na.rm = T)),
                     labels = c("0-14", "15-59", "60 e +"),
                     include.lowest = TRUE, right = FALSE)

  # O banco final (produto da função)
  csap
}
