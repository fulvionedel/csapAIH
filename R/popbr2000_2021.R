#' População Brasil 2000-2021
#'
#' @aliases popbr2000_2021
#'
#' @description Estimativas populacionais para os municípios brasileiros por sexo e faixa etária quinquenal, por ano de 2000 a 2021. Modifica a tabela de dados resultante da função \code{\link[brpop]{mun_sex_pop}} do pacote [`brpop`](https://github.com/rfsaldanha/brpop), permitindo seu uso como um banco de dados, além de outras mudanças (v. Details). Exige a instalação prévia dos pacotes `brpop` e \code{\link{dplyr}}.
#'
#' @details Colocar o link pro TABNET, detalhar as mudanças feitas.
#'
#' @param anoi Ano de início do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis (v. Examples).
#' @param anof Ano de fim do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis (v. Examples).
#' @param uf Vetor com a(s) sigla(s) da(s) Unidade(s) da Federação de interesse.
#' @param munic Vetor com o código IBGE do(s) municípios(s) de interesse.
#' @param droplevels Se TRUE (padrão), não inclui as categorias sem observações.
#'
#' @seealso \code{\link[brpop]{mun_sex_pop}}
#'
#' @examples
#' library(dplyr)
#' # Ano 2021, todos os municípios brasileiros:
#' popbr2000_2021(2021)
#' # Anos 2019 a 2021, RS:
#' popbr2000_2021(2019, 2021, uf = "RS") %>%
#'   group_by(ano) %>%
#'   summarise(pop = sum(pop))
#' # Anos 2000 a 2003, AC:
#' popbr2000_2021(anof = 2003, uf = "AC") %>%
#'   group_by(ano) %>%
#'   summarise(pop = sum(pop))
#' # Anos 2014 a 2016, Cerro Largo, RS:
#' popbr2000_2021(2014, 2016, munic = "430520") %>%
#'   group_by(sexo, fxetar5) %>%
#'   summarise(pop = sum(pop))
#'
#'
#' @import dplyr
#'
#' @export

 popbr2000_2021 <- function(anoi = NULL, anof = NULL, uf = NULL, munic = NULL, droplevels = TRUE) {

   . <- UF_SIGLA <- age_group <- ano <- mun <- fxetar5 <- pop <- sex <- sexo <- year <- NULL

   if( !is.null(anoi) & is.null(anof)) {
     anof = anoi
   }

   niveis <- c(  "From 0 to 4 years",   "From 5 to 9 years", "From 10 to 14 years",
               "From 15 to 19 years", "From 20 to 24 years", "From 25 to 29 years",
               "From 30 to 34 years", "From 35 to 39 years", "From 40 to 44 years",
               "From 45 to 49 years", "From 50 to 54 years", "From 55 to 59 years",
               "From 60 to 64 years", "From 65 to 69 years", "From 70 to 74 years",
               "From 75 to 79 years", "From 80 years or more")

  popbr <- brpop::mun_sex_pop() %>%
    filter(age_group != "Total",
           substr(mun, 3, 6) != "0000") %>%
    mutate(mun = as.character(mun),
           CO_UF = substr(mun, 1, 2),
           sexo = factor(sex, levels = c("Male", "Female"),
                         labels = c("masc", "fem")),
           fxetar5 = factor(age_group, levels = niveis, labels = csapAIH::fxetar_quinq())) %>%
    rename(ano = year) %>%
    select(-c(age_group, sex)) %>%
    relocate(pop, .after = last_col()) %>%
    arrange(ano, mun, sexo, fxetar5)

  if(!is.null(anoi)) popbr <- filter(popbr, ano >= anoi)
  if(!is.null(anof)) popbr <- filter(popbr, ano <= anof)

  popbr <- popbr %>%
    right_join(csapAIH::ufbr(), .) %>%
    tidyr::as_tibble() %>%
    relocate(ano) %>%
    suppressMessages()

  if(!is.null(uf)) popbr <- filter(popbr, UF_SIGLA == uf)
  if(!is.null(munic)) popbr <- filter(popbr, mun == munic)

  if(droplevels == TRUE) {
    popbr <- base::droplevels(popbr)
  } #else if(droplevels == FALSE)

  popbr
}
