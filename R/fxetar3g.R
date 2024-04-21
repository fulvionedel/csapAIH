#' Faixa etária em três grandes categorias
#'
#' @description Recodifica vetores com a idade em números inteiros ou em faixas etárias quinquenais em três grandes faixas etárias: 0-14, 15-59 e 60 e + anos.
#'
#' @param idade Vetor representando a idade ou a faixa etária. Pode ser numérico, em valores contínuos ou inteiros, ou da classe \code{factor} ou \code{character} representando 17 faixas etárias quinquenais, rotuladas conforme o resultado da função \code{\link{fxetar_quinq}} (números separados por hífen, sem espaços: "0-4", ..., "75-79", "80 e +").
#'
#' @returns \emph{Se fornecida a idade}, devolve um fator com as frequências observadas em cada faixa etária; \emph{se fornecida a faixa etária}, devolve um vetor da classe caractere com as frequências de cada faixa etária; \emph{se não é informado o argumento}, a função devolve um vetor com os nomes das faixas etárias. V. exemplos.
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
#' # Recategorizar a faixa etária quinquenal e
#' # computar a faixa etária em três grandes gupos
#' fxetar_quinq(idade) |>
#' fxetar3g() |> table()
#'
#' @export
#'
fxetar3g <- function(idade = NULL) {
  if(is.null(idade)) {
    return(c("0-14", "15-59", "60e+"))
  } else if (is.numeric(idade)) {
    fxetar3g <- cut(idade, c(0, 15, 60, Inf), right = FALSE,
                    labels = c("0-14", "15-59", "60e+"))
  } else if (!is.numeric(idade)) {
    if(is.factor(idade)) {idade <- as.character(idade)}
    fxetar3g <- dplyr::case_when(
      idade < "15-19" ~ "0-14",
      idade == "5-9"  ~ "0-14",
      idade >= "15-19" & idade <= "55-59" ~ "15-59",
      idade > "55-59" ~ "60e+")
  }
  # if(!is.null(idade)) {
    # fxetar3g <- cut(idade, c(0, 15, 60, Inf), right = FALSE,
    #                 labels = c("0-14", "15-59", "60e+"))
  # }
  # if(!is.null(fxetar5)){
    # if(!is.character(fxetar5)) {fxetar5 <- as.character(fxetar5)}
    # fxetar3g <- dplyr::case_when(fxetar5 < "15-19" ~ "0-14",
    #                              fxetar5 == "5-9"  ~ "0-14",
    #                              fxetar5 >= "15-19" & fxetar5 <= "55-59" ~ "15-59",
    #                              fxetar5 > "55-59" ~ "60e+")
  # }
  fxetar3g
}
