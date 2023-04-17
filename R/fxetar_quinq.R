#' @title Categoriza a idade em faixas etárias quinquenais
#' @aliases fxetar_quinq
#'
#' @description Categoriza um vetor de valores contínuos ou inteiros em faixas quinquenais. A primeira faixa pode ser quebrada em `< 1 ano` e `1-4`, com o argumento `puer = TRUE`. O número de faixas etárias é definido pelos argumentos `puer` e `senectus`. Por padrão (`puer = FALSE` e `senectus = 80`) são 17 faixas quinquenais: 0-4, ..., 80 e +.
#
#' @param aetas Se `NULL` (padrão), retorna um vetor com as faixas etárias definidas por `puer` e `senectus`. Se um vetor com valores numéricos (`dbl`, `num`, `int`), idealmente uma variável com valores de idade, classifica o valor na faixa etária.
#' @param senectus Um valor definindo o início do último intervalo, que é aberto. Com o padrão `senectus = 80`, a função retorna um fator (`fct`) com 17 nívels (`levels`) em que o último é "80 e +"
#' @param puer Se `TRUE`, a primeira faixa etária será quebrada em `< 1 ano` e `1-4`
#'
#' @examples
#' data("aih500")
#' idade <- csapAIH(aih500)$idade
#' table(fxetar_quinq(idade))
#' table(fxetar_quinq(idade, senectus = 90, puer = TRUE))
#'
#' # ou com a função `idadeSUS` (e encadeamento/'piping' de comandos):
#' idadeSUS(aih500)$idade |>
#'   fxetar_quinq() |>
#'   table()
#'
#' @export
#
fxetar_quinq <- function(aetas = NULL, senectus = 80, puer = FALSE){
  faixas <- FALSE
  start <- 3
  if(is.null(aetas)) {
    faixas <- TRUE
    aetas <- seq(1, 100, 1)
  }
  if(puer == TRUE) {
    corte1 <- c(0, 1)
    start = 4
  } else corte1 <- 0
  cortes <- c(corte1, seq(5, senectus, 5), Inf)
  x <- cut(aetas, cortes, right = F)
  niveis <- gsub(",", "-", levels(x))
  niveis <- gsub("\\[", "", niveis)
  niveis <- gsub(")", "", niveis)
  niveis[1:2] <- c("0-4", "5-9")
  niveis[length(niveis)] <- paste(senectus, "e +")
  substr(niveis[start:(nlevels(x)-1)], 4,5) <- as.character(as.numeric(substr(niveis[start:(nlevels(x)-1)], 4,5)) - 1)
  if(puer == TRUE) {
    niveis[1] <- "< 1"
    niveis[2] <- "1-4"
  }
  levels(x) <- niveis
  if(faixas == TRUE) return(niveis)
  else
    x
}

# fxetar_quinq(csapSE0719$idade, 73, puer = T) |> table()
# data("aih100")
# csapAIH(aih100) %>%
#   select(idade) %>%
#   summarise(fxetar = fxetar_quinq(senectus = 73, puer = T) |> table())
