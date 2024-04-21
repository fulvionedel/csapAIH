#' Baixa os arquivos da AIH e classifica as internações em CSAP
#' @aliases fetchcsap
#'
#' @description
#' Descarrega os "arquivos da AIH" (arquivos RD<UFAAMM>.DBC das Bases de Dados do Sistema de Informações Hospitalares do SUS - BD-SIH/SUS) do site FTP do DATASUS e classifica as internações segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária.
#'
#' @param uf        Unidade da Federação. A sigla da UF ou um vetor com as siglas das UF de interesse, entre aspas e em letras maiúsculas. Para todo o Brasil (padrão), use "all".
#' @param mesinicio Mês de competência da AIH para início da seleção dos dados, em formato numérico; por padrão é 1
#' @param anoinicio Ano de competência da AIH para início da seleção dos dados, em formato numérico; sem padrão
#' @param mesfim    Mês de competência da AIH para fim da seleção dos dados, em formato numérico; por padrão é igual ao mês de início
#' @param anofim    Ano de competência da AIH para fim da seleção dos dados, em formato numérico; por padrão é igual ao ano de início
#' @param ...       Permite o uso de parâmetros de \code{\link{csapAIH}}
#'
#' @returns Um objeto de classes \code{data.table} e \code{data.frame} com as seguintes variáveis:
#'  \itemize{
#'   \item \code{munres} Município de residência do paciente
#'   \item \code{munint} Município de internação do paciente
#'   \item \code{sexo} Sexo do paciente
#'   \item \code{idade} Idade do paciente em anos completos
#'   \item \code{fxetar.det} Faixa etária detalhada
#'   \item \code{fxetar5} Faixa etária quinquenal (0-4, ..., 76-79, 80 e +)
#'   \item \code{csap} Internação por CSAP (sim/não)
#'   \item \code{grupo} Grupo de causa da Lista Brasileira de ICSAP, ou "não-CSAP"
#'   \item \code{cid} Diagnóstico principal da internação, segundo a Classificação Internacional de Doenças, 10ª Revisão
#'   \item \code{data.inter} Data da internação
#'   \item \code{data.saida} Data da alta
#'  }
#'
#' @details
#' \code{fetchcsap} é apenas uma abreviatura para um uso específico da função \code{fetch_datasus}, do pacote \code{microdatasus}, de Raphael Saldanha. Funciona apenas com o SIH/SUS, através do argumento \code{information_system = "SIH-RD"}, e faz apenas o download das variáveis exigidas pela função \code{csapAIH}, i.e., \code{DIAG_PRINC, NASC, DT_INTER, DT_SAIDA, IDADE, COD_IDADE, MUNIC_RES, MUNIC_MOV, SEXO, N_AIH, PROC_REA, IDENT, CEP, CNES}.
#'
#' @seealso \code{\link{csapAIH}}
#'
#' @examples
#' # Internações de todo o Brasil, "mês de competência" janeiro de 2023
#' \dontrun{
#'   fetchcsap(anoinicio = 2023)
#' }
#' # Internações no RS, jan 2023
#' fetchcsap("RS", 2023)
#' ## RS, 2023
#' \dontrun{
#' fetchcsap("RS", 2023, mesfim = 12)
#' }
#'
#' @importFrom data.table setDT `:=`
#'
#' @export
fetchcsap <- function(uf = "all", anoinicio, mesinicio = 1, mesfim = mesinicio, anofim = anoinicio, ...) {
':=' <- setDT <- DT_INTER <- idade <- NULL

  # Seleção de variáveis da AIH
  vars <- c("DIAG_PRINC", "NASC", "DT_INTER", "DT_SAIDA", "IDADE", "COD_IDADE", "MUNIC_RES", "MUNIC_MOV", "SEXO", "N_AIH", "PROC_REA", "IDENT", "CEP", "CNES")

  # if(is.null(anofim)) { anofim <- anoinicio }

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
  # csap <- setDT(
  csap <- csapAIH::csapAIH(aih, ...)
  # )

  # O banco final (produto da função)
  csap
}
