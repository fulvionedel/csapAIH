#' População dos municípios brasileiros, 2000-2021
#'
#' @aliases popbr2000_2021
#'
#' @description Estimativas populacionais anuais por sexo e faixa etária quinquenal para os municípios brasileiros, de 2000 a 2021, calculadas antes do Censo 2022. Modifica a tabela de dados resultante da função \code{\link[brpop]{mun_sex_pop}} do pacote \href{https://github.com/rfsaldanha/brpop}{brpop}, permitindo seu uso como um banco de dados, além de mudar o rótulo de faixas etárias e categorias de sexo (v. Value). Exige a instalação prévia dos pacotes \code{brpop} e \code{dplyr}. Essas estimativas foram posteriormente  atualizadas e são mantidas aqui apenas para fins de registro e comparação com as medidas e estimativas atuais. (V. Details)
#'
#' @param anoi Ano de início do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis, i.e., de 2000 a 2021 (v. Examples).
#' @param anof Ano de fim do período a ser considerado, de 2000 a 2021. Argumento opcional, se não for preenchido, são consideradas as estimativas para todos os anos disponíveis, i.e., de 2000 a 2021 (v. Examples).
#' @param uf Vetor com a(s) sigla(s) da(s) Unidade(s) da Federação de interesse.
#' @param munic Vetor com o código IBGE do(s) municípios(s) de interesse.
#' @param droplevels Vetor lógico. Se TRUE (padrão), exclui as categorias ("\code{levels}") sem observações em vetores da classe \code{factor}, comportamento normalmente desejável em seleções por município, UF ou região.
#'
#' @returns Um banco de dados de classes \code{data.table} e \code{data.frame} com oito variáveis: \code{CO_UF, UF_SIGLA, REGIAO, ano, mun, sexo, fxetar5, pop}. A variável sexo é um \code{factor} com dois \code{levels}: "masc" e "fem". A variável \code{fxetar5} representa a idade agrupada em 17 categorias -- 16 faixas quinquenais (0-4, ... 75-79) e a última aberta a partir dos 80 anos (80 e +).
#'
#' @details
#'
#' Até a recente publicação dos dados do Censo 2022 e após um hiato na publicação de estimativas populacionais, em que o último arquivo de dados publicado no DATASUS era da população em 2012, trabalhávamos com as "Estimativas populacionais anuais por sexo e faixa etária quinquenal para os municípios brasileiros, de 2000 a 2021", que podiam ser tabuladas no TABNET mas cujos arquivos de dados não estavam disponíveis.
#'
#' Em 2022 Raphael Saldanha dispôs-se ao trabalho de fazer as muitas tabulações necessárias e criou o pacote \code{brpop}, com as as estimativas da população por sexo e faixa etária para os municípios brasileiros, de 2000 a 2021. Entretanto, as tabelas em \emph{brpop} tinham (têm) o total (a soma da população nas diferentes faixas etárias), e os rótulos das faixas etárias são longos e estavam (estão) em inglês, por isso criei outra função (\code{popbr2000_2021}) que retornasse a população com os rótulos em português e apenas com a população estimada em cada faixa etária (sem o total).
#'
#' Com o Censo 2022 viu-se que os resultados estavam superestimados e as informações foram atualizadas e o período expandido até 2024. Essas novas informações voltaram a ser publicadas em arquivos no servidor FTP do DATASUS, facilitando seu uso como banco de dados, sem exigir a tabulação no TABNET.
#'
#' Assim, a função \code{popbr2000_2021} não é mais necessária e não deve ser usada em novos estudos, a não ser para análises metodológicas e comparação de resultados com as medidas atualizadas. Por esse motivo ela é mantida no pacote.
#'
#' @references
#' Nota técnica atualização: \url{http://tabnet.datasus.gov.br/cgi/IBGE/SEI_MS-0034745983-Nota_Tecnica_final.pdf}
#' Nota técnica do estudo original: http://tabnet.datasus.gov.br/cgi/IBGE/NT-POPULACAO-RESIDENTE-2000-2021.PDF
#' Essas informações podem ser tabuladas em \url{http://tabnet.datasus.gov.br/cgi/deftohtm.exe?ibge/cnv/popsvsbr.def}.
#'
#' @seealso \code{\link[brpop]{mun_sex_pop}}, \code{\link{popbr}}.
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' # Ano 2021, todos os municípios brasileiros:
#' popbr2000_2021(2021)
#' # Anos 2019 a 2021, RS:
#' popbr2000_2021(2019, 2021, uf = "RS") %>%
#'   dplyr::group_by(ano) %>%
#'   dplyr::summarise(pop = sum(pop))
#' # Anos 2000 a 2003, AC:
#' popbr2000_2021(anof = 2003, uf = "AC") %>%
#'   group_by(ano) %>%
#'   summarise(pop = sum(pop))
#' # Anos 2014 a 2016, Cerro Largo, RS:
#' popbr2000_2021(2014, 2016, munic = "430520") %>%
#'   group_by(sexo, fxetar5) %>%
#'   summarise(pop = sum(pop))
#' }
#'
#' @export

 popbr2000_2021 <- function(anoi = NULL, anof = NULL, uf = NULL, munic = NULL, droplevels = TRUE) {

   . <- UF_SIGLA <- age_group <- ano <- mun <- code_muni <- fxetar5 <- pop <- sex <- sexo <- year <- NULL

   if( !is.null(anoi) & is.null(anof)) {
     anof = anoi
   }

   niveis <- c(  "From 0 to 4 years",   "From 5 to 9 years", "From 10 to 14 years",
               "From 15 to 19 years", "From 20 to 24 years", "From 25 to 29 years",
               "From 30 to 34 years", "From 35 to 39 years", "From 40 to 44 years",
               "From 45 to 49 years", "From 50 to 54 years", "From 55 to 59 years",
               "From 60 to 64 years", "From 65 to 69 years", "From 70 to 74 years",
               "From 75 to 79 years", "From 80 years or more")

   # popbr <- brpop::mun_sex_pop() |>
   #   data.table::setDT(key = c("year", "code_muni"))
   popbr <- data.table::setDT(brpop::mun_sex_pop(), key = c("year", "code_muni"))

   if(!is.null(anoi)) popbr <- popbr[year >= anoi]
   if(!is.null(anof)) popbr <- popbr[year <= anof]

   popbr <- popbr[age_group != "Total" & substr(code_muni, 3, 6) != "0000",
                  .(ano = year,
                    code_muni = as.character(code_muni),
                    CO_UF = substr(code_muni, 1, 2),
                    sexo = factor(sex, levels = c("Male", "Female"),
                                  labels = c("masc", "fem")),
                    fxetar5 = factor(age_group,
                                     levels = niveis,
                                     labels = csapAIH::fxetar_quinq()),
                    pop = pop)]

   popbr <- data.table::merge.data.table(data.table::setDT(csapAIH::ufbr()), popbr)

   if(!is.null(uf)) {
     data.table::setkeyv(popbr, "UF_SIGLA")
     popbr <- popbr[UF_SIGLA == uf]
   }
   if(!is.null(munic)) popbr <- popbr[code_muni == munic]

  if(droplevels == TRUE) {
    popbr <- droplevels(popbr)
  } #else if(droplevels == FALSE)

  popbr
}
