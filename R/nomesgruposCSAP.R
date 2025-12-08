#' @title Nomes dos grupos de causa da Lista Brasileira de Condições Sensíveis à Atenção Primária
#' @aliases nomesgruposCSAP
#'
#' @description Lista os grupos de causa da Lista Brasileira de Condições Sensíveis à Atenção Primária, segundo a Portaria do Ministério da Saúde do Brasil, com 19 grupos, ou segundo a publicação em Alfradique et al. (2009), com 20 grupos. Facilita a inclusão ddo grupo de causa como uma variável de um banco de dados. O texto pode ser apresentado em português, espanhol ou inglês.
#'
#' @param lista Lista de causas a ser considerada; pode ser \code{"MS"} (default) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.
#' @param lang idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.
#' @param classe O output da função deve ser (1) um vetor com a lista dos nomes (padrão, definido por \code{"vetor"}, \code{"v"} ou \code{1}) ou (2) um "data frame" com uma variável com o código do grupo ("g01", etc.) e outra com o nome (definido por \code{"data.frame"}, \code{"df"} ou \code{2})?
#' @param numgrupo No caso de se definir um "data frame" no parâmetro \code{classe}, a variável com o nome do grupo deve iniciar com o número do grupo? (v. exemplos).
#'
#' @return Um vetor da classe \code{character} ou uma tabela na classe \code{data frame} com os nomes (abreviados) dos grupos de causa segundo a lista definida pelo usuário.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}} \code{\link{adinomes}}
#'
#' @references
#'
#' Alfradique ME et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6):1337-1349. https://doi.org/10.1590/S0102-311X2009000600016.
#'
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' nomesgruposCSAP()
#' nomesgruposCSAP(classe = "df")
#' nomesgruposCSAP(classe = "df", numgrupo = TRUE)
#' nomesgruposCSAP(lang = "pt.sa")
#' nomesgruposCSAP(lang = "en")
#' nomesgruposCSAP(lang = "es")
#' nomesgruposCSAP(lista = 'Alfradique')
#' nomesgruposCSAP(lista = 'Alfradique', classe = "df")

#' nomesgruposCSAP(lista = 'Alfradique', lang = 'es',
#'                 classe = 'df', numgrupo = TRUE)
#'
#' # Uso de `classe = 'df'`
#' require(dplyr)
#' ## Inclui o nome do grupo como uma variável no banco de dados:
#' aih100 %>%
#'   csapAIH() %>%
#'   filter(csap == "sim") %>%
#'   select(c(4, 6, 9:11)) %>%
#'   left_join(nomesgruposCSAP(classe = 'df'))
#'
#' left_join(
#'   csapAIH(aih500, lista = "Alfradique"),
#'   nomesgruposCSAP(classe = 2, lista = "Alfradique", lang = "en", numgrupo = TRUE)) %>%
#'   group_by(csap, grupo, nomegrupo) %>%
#'   reframe(n()) %>%
#'   print(n = 21)
#'
#' @export
#'
nomesgruposCSAP <- function(lista = "MS", lang = "pt.ca", classe = "vetor", numgrupo = FALSE) {
  # Nuntius errorum
  # ----------------
  if( !any(lista == "MS" | lista == "Alfradique") ) {
    stop('lista must be one of "MS" or "Alfradique"')
  }
  if( !any(lang == "pt.ca" |
           lang != "pt.sa" |
           lang != "en" |
           lang != "es") ) {
    stop('lang must be one of "pt.ca", "pt.sa", "en" or "es"')
  }
  if(lista == "MS") {
    grupo <-  c(paste0("g0", 1:9), paste0("g1", 0:9))
  } else if(lista == "Alfradique") {
    grupo <- c(paste0("g0", 1:9), paste0("g1", 0:9), "g20")
  }

  # Nomes em Português com códigos UTF para os acentos
  # ---------------------------------------------------

  nomes.pt.ca.MS <- c(" 1. Prev. vacina\U00E7\U00E3o e cond. evit\U00E1veis",
                      " 2. Gastroenterites",
                      " 3. Anemia",
                      " 4. Defic. nutricionais",
                      " 5. Infec. ouvido, nariz e garganta",
                      " 6. Pneumonias bacterianas",
                      " 7. Asma",
                      " 8. Pulmonares",
                      " 9. Hipertens\U00E3o",
                      "10. Angina",
                      "11. Insuf. card\u00EDaca",
                      "12. Cerebrovasculares",
                      "13. Diabetes mellitus",
                      "14. Epilepsias",
                      "15. Infec. urin\U00E1ria",
                      "16. Infec. pele e subcut\U00E2neo",
                      "17. D. infl. \U00F3rg\U00E3os p\U00E9lvicos fem.",
                      "18. \U00DAlcera gastrointestinal",
                      "19. Pr\U00E9-natal e parto"
                      )

  nomes.pt.ca.Alfradique <- c(" 1. Prev. por vacina\U00E7\U00E3o",
                              " 2. Outras cond. evit\U00E1veis",
                              nomes.pt.ca.MS[2:19])
  substr(nomes.pt.ca.Alfradique[3:20], 1, 2) <-
    c(paste0(" ", as.character(as.numeric(paste0(2:8)) + 1)),
      as.character(as.numeric(paste0(9:19)) + 1))
  # nomes.pt.ca.Alfradique


  # Nomes em Português sem acentos
  # -------------------------------
  nomes.pt.sa.MS <- c(" 1. Prev. vacinacao e cond. evitaveis",
                      " 2. Gastroenterites",
                      " 3. Anemia",
                      " 4. Def. nutricion.",
                      " 5. Infec. ouvido, nariz e garganta",
                      " 6. Pneumonias bacterianas",
                      " 7. Asma",
                      " 8. Pulmonares",
                      " 9. Hipertensao",
                      "10. Angina",
                      "11. Insuf. cardiaca",
                      "12. Cerebrovasculares",
                      "13. Diabetes mellitus",
                      "14. Epilepsias",
                      "15. Infec. urinaria",
                      "16. Infec. pele e subcutaneo",
                      "17. D. infl. Orgaos pelvicos fem.",
                      "18. Ulcera gastrointestinal",
                      "19. Pre-natal e parto"
                      )

  nomes.pt.sa.Alfradique <- c(" 1. Prev. por vacinacao",
                              " 2. Outras cond. evitaveis",
                              nomes.pt.sa.MS[2:19])
  substr(nomes.pt.sa.Alfradique[3:20], 1, 2) <-
    c(paste0(" ", as.character(as.numeric(paste0(2:8)) + 1)),
      as.character(as.numeric(paste0(9:19)) + 1))
  # nomes.pt.sa.Alfradique


  # Nomes em inglês
  # -----------------
  nomes.en.MS <-   c(" 1. Vaccine prev. and amenable cond.",
                     " 2. Gastroenteritis",
                     " 3. Anemia",
                     " 4. Nutritional deficiency",
                     " 5. Ear, nose and throat infec.",
                     " 6. Bacterial pneumonia",
                     " 7. Asthma",
                     " 8. Pulmonary",
                     " 9. Hypertension",
                     "10. Angina",
                     "11. Heart failure",
                     "12. Cerebrovascular",
                     "13. Diabetes mellitus",
                     "14. Convulsions and epilepsy",
                     "15. Urinary infection",
                     "16. Skin and subcutaneous infec.",
                     "17. Pelvic inflammatory disease",
                     "18. Gastrointestinal ulcers",
                     "19. Pre-natal and childbirth"
                     )

  nomes.en.Alfradique <- c(" 1. Vaccine preventable",
                           " 2. Other amenable conditions",
                              nomes.en.MS[2:19])
  substr(nomes.en.Alfradique[3:20], 1, 2) <-
    c(paste0(" ", as.character(as.numeric(paste0(2:8)) + 1)),
      as.character(as.numeric(paste0(9:19)) + 1))
  # nomes.en.Alfradique


  # nomes.en <- c("1.Prev. vaccination",
  #               "2.Gastroenteritis",
  #               "3.Anaemia",
  #               "4.Nutricion. deficiency",
  #               "5.Ear, nose and throat infections",
  #               "6.Bacterial pneumonia",
  #               "7.Asthma",
  #               "8.Pulmonary diseases",
  #               "9.Hypertension",
  #               "10.Angina pectoris",
  #               "11.Heart failure",
  #               "12.Cerebrovascular diseases",
  #               "13.Diabetes mellitus",
  #               "14.Epilepsy",
  #               "15.Kidney and urin. infections",
  #               "16.Skin and subcut. tissue infections",
  #               "17.Infl. disease female pelvic organs",
  #               "18.Gastrointestinal ulcer",
  #               "19.Prenatal and childbirth diseases"
  # )

  # Nomes em castelhano
  # --------------------
  nomes.es.MS <- c(" 1. Prev. vacunaci\U00F3n y otros medios",
                   " 2. Gastroenteritis",
                   " 3. Anemia",
                   " 4. Def. nutricionales",
                   " 5. Infec. o\u00EDdo, nariz y garganta",
                   " 6. Neumon\u00EDa bacteriana",
                   " 7. Asma",
                   " 8. Enf. v\u00EDas respiratorias inferiores",
                   " 9. Hipertensi\U00F3n",
                   "10. Angina de pecho",
                   "11. Insuf. card\u00EDaca congestiva",
                   "12. Enf. cerebrovasculares",
                   "13. Diabetes mellitus",
                   "14. Epilepsias",
                   "15. Infecci\U00F3n urinaria",
                   "16. Infec. piel y subcut\U00E1neo",
                   "17. Enf infl \U00F3rganos p\U00E9lvicos femeninos",
                   "18. \U00DAlcera gastrointestinal",
                   "19. Enf. del embarazo, parto y puerperio"
                   )

  nomes.es.Alfradique <- c(" 1. Prev. por vacunaci\U00F3n",
                           " 2. Afec. prev. incluidas FR, s\u00EDfilis, TB",
                              nomes.es.MS[2:19])
  substr(nomes.es.Alfradique[3:20], 1, 2) <-
    c(paste0(" ", as.character(as.numeric(paste0(2:8)) + 1)),
      as.character(as.numeric(paste0(9:19)) + 1))
  nomes.es.Alfradique


  if(lang == "pt.ca") {
    if(lista == "MS") {
      nomegrupo <- nomes.pt.ca.MS
    } else if(lista == "Alfradique") {
      nomegrupo <- nomes.pt.ca.Alfradique
    }
  }
  if(lang == "pt.sa") {
    if(lista == "MS") {
      nomegrupo <- nomes.pt.sa.MS
    } else if(lista == "Alfradique") nomegrupo <- nomes.pt.sa.Alfradique
  }
  if(lang == "es") {
    if(lista == "MS") {
      nomegrupo <- nomes.es.MS
    } else if(lista == "Alfradique") nomegrupo <- nomes.es.Alfradique
  }
  if(lang == "en") {
    if(lista == "MS") {
      nomegrupo <- nomes.en.MS
    } else if(lista == "Alfradique") nomegrupo <- nomes.en.Alfradique
  }

  if(classe %in% c("data.frame", "df", "2")) {
    if(isFALSE(numgrupo)) {
      nomegrupo <- substr(nomegrupo, 5, nchar(nomegrupo))
    }
    nomegrupo <- data.frame(grupo, nomegrupo)
  } else if(classe %in% c("vetor", "v", "1")) return(nomegrupo)
  nomegrupo
}

#'
#' Adiciona o nome dos grupos
#'
#' Acrescenta uma variável com o nome dos grupos de causa segundo a lista selecionada ("MS" ou "Alfradique") a um banco de dados resultante da função \code{\link{csapAIH}} ou que contenha uma variável de nome "grupo" com os grupos nomeados segundo aquela função ("g01", ...)
#' @param x Banco de dados.
#' @param lista Lista CSAP a ser utilizada. O padrão é "MS" (v. \code{\link{nomesgruposCSAP}}).
#' @param classe Classe do objeto retornado pela função. O padrão é "df".
#' @details
#' Define como missing os não-CSAP
#' @examples
#' data("aih100")
#' adinomes(csapAIH(aih100))[1:5, 9:11]
#
# @importFrom dplyr left_join
#' @export
adinomes <- function(x, lista = "MS", classe = "df") {
  nomegrupo <- grupo <- NULL
  lista = lista
  x <- dplyr::left_join(x, nomesgruposCSAP(lista = lista, classe = classe)) |>
    dplyr::relocate(nomegrupo, .after = grupo)
  x
}
