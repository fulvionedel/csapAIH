#' População Brasil 2000-2021
#'
#' @aliases popbr2000_2021
#'
#' @description Estimativas populacionais para os municípios brasileiros por sexo e faixa etária quinquenal, por ano de 2000 a 2021. Modifica a tabela de dados resultante da função \code{\link[brpop]{mun_sex_pop}} do pacote [`brpop`](https://github.com/rfsaldanha/brpop), permitindo seu uso como um banco de dados, além de outras mudanças (v. Details).
#'
#' @details Colocar o link pro TABNET, detalhar as mudanças feitas.
#'
#' @param anoi Ano de início do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis (v. Examples).
#' @param anof Ano de fim do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis (v. Examples).
#' @param uf Vetor com a(s) sigla(s) da(s) Unidade(s) da Federação de interesse.
#' @param munic Vetor com o código IBGE do(s) municípios(s) de interesse.
#'
#' @seealso \code{\link[brpop]{mun_sex_pop}}
#'
#' @examples
#' # Ano 2021, todos os municípios brasileiros:
#' popbr2000_2021(2021)
#' # Anos 2019 a 2021, RS:
#' popbr2000_2021(2019, uf = "RS")
#' # Anos 2000 a 2003, AC:
#' popbr2000_2021(anof = 2003, uf = "AC")
#' # Ano 2015, Cerro Largo, RS:
#' popbr2000_2021(2015, 2015, munic = "430520")
#'
#'
#' @import dplyr
#'
#' @export

 popbr2000_2021 <- function(anoi = NULL, anof = NULL, uf = NULL, munic = NULL) {
   . <- UF_SIGLA <- age_group <- ano <- mun <- fxetar3 <- fxetar5 <- pop <- sex <- sexo <- year <- NULL
  popbr <- brpop::mun_sex_pop() %>%
    filter(age_group != "Total",
           substr(mun, 3, 6) != "0000") %>%
    mutate(mun = as.character(mun),
           CO_UF = substr(mun, 1, 2),
           sexo = factor(sex, levels = c("Male", "Female"),
                         labels = c("masc", "fem")),
           fxetar5 = factor(age_group, labels = csapAIH::fxetar_quinq()),
           fxetar3 = as.character(fxetar5),
           fxetar3 = case_when(fxetar3 < "15-19" ~ "0-14",
                               fxetar3 == "5-9"  ~ "0-14",
                               fxetar3 >= "15-19" & fxetar3 <= "55-59" ~ "15-59",
                               fxetar3 > "55-59" ~ "60e+") |>
             as.factor()) %>%
    rename(ano = year) %>%
    select(-c(age_group, sex)) %>%
    relocate(fxetar5, .after = fxetar3) %>%
    relocate(pop, .after = last_col()) %>%
    arrange(ano, mun, sexo, fxetar3, fxetar5)

  if(!is.null(anoi)) popbr <- filter(popbr, ano >= anoi)
  if(!is.null(anof)) popbr <- filter(popbr, ano <= anof)

  popbr <- popbr %>%
    right_join(csapAIH::ufbr(), .) %>%
    tidyr::as_tibble() %>%
    relocate(ano)

  if(!is.null(uf)) popbr <- filter(popbr, UF_SIGLA == uf)
  if(!is.null(munic)) popbr <- filter(popbr, mun == munic)

  popbr
}