#' Baixa os arquivos da AIH e classifica as internações em CSAP
#' @aliases fetchcsap
#'
#' @description
#' Descarrega os "arquivos da AIH" (arquivos RD<UFAAMM>.DBC das Bases de Dados do Sistema de Informações Hospitalares do SUS - BD-SIH/SUS) do site FTP do DATASUS e classifica as internações segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária.
#'
#' @param anoinicio Ano de competência da AIH para início da seleção dos dados, em formato numérico; sem padrão.
#' @param anofim Ano de competência da AIH para fim da seleção dos dados, em formato numérico; por padrão é igual ao ano seguinte ao ano de início (\code{anoinicio + 1}).
#' @param mesinicio Mês de competência da AIH para início da seleção dos dados, em formato numérico; por padrão é 1.
#' @param mesfim Mês de competência da AIH para fim da seleção dos dados, em formato numérico; por padrão é 6 (junho). V. detalhes.
#' @param uf Unidade da Federação. A sigla da UF ou um vetor com as siglas das UF de interesse, entre aspas e em letras maiúsculas. Para todo o Brasil (padrão), use "all".
#' @param regiao Região administrativa do Brasil ("Grandes Regiões). O padrão é \code{NULL}. Se usado, deve ser uma entre "N", "NE", "SE", "S" e "CO".
#' @param periodo O período definido refere-se ao mês e ano de "competência" da AIH ou à data de internação? O padrão (\code{"interna"}) é a internação. V. detahes.
#' @param  cep CEP de internação
#' @param cnes CNES do estabelecimento que gerou a AIH
#' @param ... Permite o uso de outros parâmetros de \code{\link{csapAIH}}
#'
#' @returns Um objeto de classes \code{data.table} e \code{data.frame} com as seguintes variáveis:
#'  \itemize{
#'   \item \code{munres} Município de residência do paciente
#'   \item \code{munint} Município de internação do paciente
#'   \item \code{sexo} Sexo do paciente
#'   \item \code{idade} Idade do paciente em anos completos
#'   \item \code{fxetar5} Faixa etária quinquenal (0-4, ..., 76-79, 80 e +)
#'   \item \code{csap} Internação por CSAP (sim/não)
#'   \item \code{grupo} Grupo de causa da Lista Brasileira de ICSAP, ou "não-CSAP"
#'   \item \code{cid} Diagnóstico principal da internação, segundo a Classificação Internacional de Doenças, 10ª Revisão
#'   \item \code{data.inter} Data da internação
#'   \item \code{data.saida} Data da alta
#'  }
#'
#' @details
#'
#' - Período de download dos arquivos e de internação dos sujeitos.
#' \itemize{
#'   \item Os "arquivos da AIH" são definidos por mês e ano de "competência", e não da data de internação. Assim, o arquivo de um determinado "mês de competência" pode incluir registros de internações ocorridas em outro mês ou ano, enquanto pode não incluir todos os casos ocorridos naquele mês. Por padrão, \code{fetchcsap} usa o argumento \code{periodo = "interna"} para selecionar os casos por data de internação de acordo com o período definido nos argumentos \code{anoinicio}, \code{mesinicio} e \code{anofim}, de modo a iniciar no primeiro dia do ano e mês de competência (\code{anoinicio} e \code{mesinicio}) e terminar em 31 de dezembro do ano anterior ao definido em \code{anofim}.
#'   \item Assim, por padrão, a função exige apenas a definição do ano de início dos casos. Se o usuário definir apenas esse argumento, \code{fetchcsap} fará o download e leitura dos arquivos (de todo o Brasil) de todos os meses até junho do ano seguinte para então selecionar as internações ocorridas no ano definido em \code{anoinicio}.
#' }
#'
#' - \code{fetchcsap} é apenas uma abreviatura para um uso específico da função \code{fetch_datasus}, do pacote \code{microdatasus}, de Raphael Saldanha. Funciona apenas com o SIH/SUS, através do argumento \code{information_system = "SIH-RD"}, e faz apenas o download das variáveis exigidas pela função \code{csapAIH}, i.e., \code{DIAG_PRINC, NASC, DT_INTER, DT_SAIDA, IDADE, COD_IDADE, MUNIC_RES, MUNIC_MOV, SEXO, N_AIH, PROC_REA, IDENT, CEP, CNES}.
#'
#' @seealso \code{\link{csapAIH}}
#'
#' @examples
#' # Internações de todo o Brasil, ocorridas no ano de 2023 e registradas até jun/2024:
#' # Colocando apenas o ano, único argumento obrigatório, a função executa o
#' # download dos arquivos RD??????.DBC de todas as UF de jan/2023 a jun/2024 e
#' # então extrais apenas os registros com data de internação em 2023.
#' \dontrun{
#'   fetchcsap(2023)
#' }
#' # Diferença entre o mês e ano de "competência" da AIH e a data de internação da pessoa,
#' # exemplo com as internações no Acre:
#' # - todas as internações registradas no mês de competência jan 2023:
#' ac.comp <- fetchcsap(2023, uf = "AC", mesfim = 1, periodo = 'competencia')
#' nrow(ac.comp)
#' summary(ac.comp$data.inter)
#' # - internações ocorridas em jan/2023 e registradas nos meses de competência
#' # janeiro a junho de 2023:
#' ac.int <- fetchcsap(2023, anofim = 2023, mesfim = 1, uf = "AC")
#' nrow(ac.int)
#' summary(ac.int$data.inter)
#' # Assim, há
#' nrow(ac.comp) - nrow(ac.int)
#' # internações registradas naquele mês de competência, mas que ocorreram antes.
#'
#' # Internações ocorridas na Região Norte no mês de janeiro de 2023 e registradas naquele mês:
#' fetchcsap(2023, 2023, mesfim = 1, regiao = "N")
#'
#' @importFrom data.table setDT `:=`
#'
#' @export
fetchcsap <- function(anoinicio, anofim = NULL,
                      mesinicio = 1, mesfim = NULL,
                      uf = "all", regiao = NULL,
                      periodo = "interna",
                      cep = FALSE, cnes = FALSE, ...) {
':=' <- setDT <- DT_INTER <- idade <- NULL

  # Seleção de variáveis da AIH
  vars <- c("DIAG_PRINC", "NASC", "DT_INTER", "DT_SAIDA", "IDADE", "COD_IDADE", "MUNIC_RES", "MUNIC_MOV", "SEXO", "N_AIH", "PROC_REA", "IDENT", "CEP", "CNES")

  # Definir extração de dados de interesse
  mesi <- ifelse(mesinicio < 10, paste0("0", mesinicio), mesinicio)
  peri <- paste0(anoinicio, mesi, "01")
  # Data de competência
  if (periodo  %in% c("competencia", "comp", "c")) {
    if (is.null(anofim)) { anofim = anoinicio }
    if (is.null(mesfim)) { mesfim = 12 }
    mesf <- ifelse(mesfim < 10, paste0("0", mesfim), mesfim)
    perf <- paste0(anofim, mesf, "31")
  }
  # Data de internação
  if (periodo %in% c("interna", "int", "i")) {
    periodo = "i"
    if( is.null(anofim) & is.null(mesfim) ) {
      anof = anofim = anoinicio
      # mesfim = mesinicio + 5
      mesf = 12
    } else anof = anofim
    if( is.null(anofim) & !is.null(mesfim) ) {
      anof = anofim = anoinicio
    }
    if( !is.null(anofim) & is.null(mesfim) ) {
      anofim = anofim + 1
      mesf = 12
    }
    if( is.null(mesfim) ) { mesfim = mesinicio + 5 } else mesfim = mesfim + 5
    if( !exists("mesf") ) {
      mesf <- ifelse(mesfim < 10, paste0("0", mesfim - 5), mesfim - 5)
    }
    perf <- paste0(anof, mesf, "31")
  }
#
  # Definir a(s) UF
  if(!is.null(regiao)) {
    if(regiao == "N") {
      uf <- c("RO", "AC", "AM", "RR", "PA", "AP", "TO")
      aih  <- rbind(microdatasus::fetch_datasus(year_start  = anoinicio,
                                          month_start = mesinicio,
                                          year_end    = anofim,
                                          month_end   = mesfim,
                                          uf = uf[1],
                                          information_system = "SIH-RD",
                                          vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[2],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[3],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[4],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[5],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[6],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[7],
                                                information_system = "SIH-RD",
                                                vars = vars)
      )
    } else if(regiao == "NE") {
      uf <- c("MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA")
      aih  <- rbind(microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[1],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[2],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[3],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[4],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[5],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[6],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[7],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[8],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[9],
                                                information_system = "SIH-RD",
                                                vars = vars)
      )
    } else if(regiao == "SE") {
      uf <- c("MG", "ES", "RJ", "SP")
      aih  <- rbind(microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[1],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[2],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[3],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[4],
                                                information_system = "SIH-RD",
                                                vars = vars)
      )
    } else if(regiao == "S") {
      uf <- c("PR", "SC", "RS")
      aih  <- rbind(microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[1],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[2],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[3],
                                                information_system = "SIH-RD",
                                                vars = vars)
      )
    } else if(regiao == "CO") {
      uf <- c("MS", "MT", "GO", "DF")
      aih  <- rbind(microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[1],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[2],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[3],
                                                information_system = "SIH-RD",
                                                vars = vars),
                    microdatasus::fetch_datasus(year_start  = anoinicio,
                                                month_start = mesinicio,
                                                year_end    = anofim,
                                                month_end   = mesfim,
                                                uf = uf[4],
                                                information_system = "SIH-RD",
                                                vars = vars)
      )
    } else
      stop("'regiao' deve ser uma entre 'N', 'NE', 'SE', 'S' e 'CO'")
  } else
    aih  <- microdatasus::fetch_datasus(year_start  = anoinicio,
                                        month_start = mesinicio,
                                        year_end    = anofim,
                                        month_end   = mesfim,
                                        # uf = deparse(substitute(uf)),
                                        uf = uf,
                                        information_system = "SIH-RD",
                                        vars = vars)
  setDT(aih)
  if(periodo == 'i') {
    aih <- aih[aih$DT_INTER >= peri, ]
    aih <- aih[aih$DT_INTER <= perf, ]
  }
  aih <- data.frame(aih)
 # return(list("mesf" = mesf, "anof" = anof, "peri" = peri, "perf" = perf))
  # Classificar as CSAP
  csap <- csapAIH::csapAIH(aih, cep = cep, cnes = cnes, ...) |>
    setDT()
  csap <- csap[, c("fxetar.det", "nasc", "n.aih", "proc.rea") := NULL]

  # O banco final (produto da função)
  csap[]
}
