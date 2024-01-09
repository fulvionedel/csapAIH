#' Identificar diagnósticos de parto na CID-10
#' @aliases partos
#'
#' @param cid Vetor com o código diagnóstico, segundo a CID-10.
#' @param opus Ação a ser executada: 1 (padrão) seleciona apenas os partos; 2 exclui os partos; e 3 cria um \code{data.frame} com duas variáveis -- \code{cid}, com o código diagnóstico, e \code{parto} (sim ou não).
#'
#' @examples
#' data(aih100)
#' # Selecionar os diagnósticos de parto em um vetor
#' partos(aih100$DIAG_PRINC)
#' # Selecionar os diagnósticos de parto em um vetor (mesma coisa, explicitando o argumento 'opus')
#' partos(aih100$DIAG_PRINC, 1)
#' # Excluir os diagnósticos de parto em um vetor
#' partos(aih100$DIAG_PRINC, 2)
#' # Criar um 'data frame' com duas variáveis classificando os diagnósticos em parto ou não
#' partos(aih100$DIAG_PRINC, 3)
#' #' # Selecionar apenas os registros de partos em um banco de dados
#' aih100[aih100$DIAG_PRINC == partos(aih100$DIAG_PRINC), ]
#' #' # Excluir os registros de partos em um banco de dados
#' aih100[aih100$DIAG_PRINC == partos(aih100$DIAG_PRINC, 2), ]
#' #' # Acrescentar ao banco uma coluna com a variável "parto"
#' aih100 <- cbind(aih100, partos(aih100$DIAG_PRINC, 3)[2]) |> print()
#' aih100$parto2 <- partos(aih100$DIAG_PRINC, 3)$parto
#'
#' @export
#'
partos <- function(cid, opus = 1) {
  if(is.factor(cid)) cid <- as.character(cid)
  parto <- ifelse(cid >= "O80" & cid < "O85", 1, 0)
  if(opus == 1) {
    cid[parto == 1]
  } else if(opus == 2) {
    cid[parto == 0]
  } else if(opus == 3) {
    parto <- factor(parto, levels = c(1,0), labels = c("sim", "n\u00e3o"))
    data.frame(cid, parto)
  }
}
