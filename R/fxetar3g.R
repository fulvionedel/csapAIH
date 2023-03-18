#' Faixa etária em três grandes categorias
#'
#' @description Recodifica vetores com a idade em números inteiros ou em faixas etárias quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.
#'
#' @param idade Vetor numérico representando a idade em valores contínuos ou inteiros.
#' @param fxetar5 Vetor da classe \code{factor} ou \code{character} representando 17 faixas etárias quinquenais, rotuladas conforme o resultado da função \code{\link{fxetar_quinq}} (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e +").
#'
#' @returns _Se fornecida a idade_, devolve um fator com as frequências observada em cada faixa etária; _se fornecida a faixa etária_, devolve um vetor da classe caractere com as frequências de cada faixa etária; _se não são fornecidas nem a idade nem a faixa etária_ -- com `fxetar3g()` --, a função devolve um vetor com os nomes das faixas etárias.
#'
#' @examples
#' # Apenas citar os grupos:
#' fxetar3g()
#'
#' # Categorizar a idade
#' ## Criar um vetor para idade
#' idade <- as.integer(runif(100, 0, 100))
#' ## Computar a faixa etária
#' fxetar3g(idade) |> table()
#'
#' # Recategorizar a faixa etária quinquenal
#' # Criar um vetor para faixa etária quinquenal
#' fxetar <- fxetar_quinq(idade)
#' # Computar a faixa etária em três grandes gupos
#' fxetar3g(fxetar5 = fxetar) |> table()
#'
#' @export

fxetar3g <- function(idade = NULL, fxetar5 = NULL) {
  if(is.null(idade) & is.null(fxetar5)) {
    return(c("0-14", "15-59", "60e+"))
  }

  if(!is.null(idade)) {
    fxetar3g <- cut(idade, c(0, 15, 60, Inf), right = FALSE,
                    labels = c("0-14", "15-59", "60e+"))
  }
  if(!is.null(fxetar5)){
    if(!is.character(fxetar5)) {fxetar5 <- as.character(fxetar5)}
    fxetar3g <- dplyr::case_when(fxetar5 < "15-19" ~ "0-14",
                                 fxetar5 == "5-9"  ~ "0-14",
                                 fxetar5 >= "15-19" & fxetar5 <= "55-59" ~ "15-59",
                                 fxetar5 > "55-59" ~ "60e+")
  }
  fxetar3g
}
