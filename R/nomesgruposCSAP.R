#' @title Nomes dos grupos de causa da Lista Brasileira de Condições Sensíveis à Atenção Primária
#' @aliases nomesgruposCSAP
#'
#' @description Lista os 19 grupos de causa CSAP, em ordem crescente.
#'
#' @param lista Lista de causas a ser considerada (v. referências); pode ser \code{"MS"} (default) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.
#' @param lang idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.
#'
#' @return Um vetor da classe \code{character} com os nomes (abreviados) dos 19 grupos de causa segundo a Lista Brasileira.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}}
#'
#' @references
#'
#' Alfradique ME et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6):1337-1349. https://doi.org/10.1590/S0102-311X2009000600016.
#'
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' nomesgruposCSAP()
#' nomesgruposCSAP(lang = "pt.ca")
#' nomesgruposCSAP(lang = "en")
#' nomesgruposCSAP(lang = "es")
#'
#' @export
#'
nomesgruposCSAP <- function(lista = "MS", lang = "pt.ca") {
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

  # Nomes em Português com códigos UTF para os acentos
  # ---------------------------------------------------

  nomes.pt.ca.MS <- c(" 1. Prev. vacina\U00E7\U00E3o e cond. evit\U00E1veis",
                      " 2. Gastroenterite",
                      " 3. Anemia",
                      " 4. Defic. nutricionais",
                      " 5. Infec. ouvido, nariz e garganta",
                      " 6. Pneumonias bacterianas",
                      " 7. Asma",
                      " 8. Pulmonares (DPOC)",
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
                      " 2. Gastroenterite",
                      " 3. Anemia",
                      " 4. Def. nutricion.",
                      " 5. Infec. ouvido, nariz e garganta",
                      " 6. Pneumonias bacterianas",
                      " 7. Asma",
                      " 8. Pulmonares (DPOC)",
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
                     " 8. Pulmonary (COPD)",
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
  #               "8.Pulmonary diseases (COPD)",
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
    if(lista == "MS") return(nomes.pt.ca.MS)
    else if(lista == "Alfradique") return(nomes.pt.ca.Alfradique)
  }
  if(lang == "pt.sa") {
    if(lista == "MS") return(nomes.pt.sa.MS)
    else if(lista == "Alfradique") return(nomes.pt.sa.Alfradique)
  }
  if(lang == "es") {
    if(lista == "MS") return(nomes.es.MS)
    else if(lista == "Alfradique") return(nomes.es.Alfradique)
  }
  if(lang == "en") {
    if(lista == "MS") return(nomes.en.MS)
    else if(lista == "Alfradique") return(nomes.en.Alfradique)
  }
}
