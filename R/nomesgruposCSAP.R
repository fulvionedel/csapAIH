#' @title Nomes dos grupos de causa da Lista Brasileira de Condicoes Sensiveis a Atencao Primaria
#' @aliases nomesgruposCSAP
#'
#' @description Lista os 19 grupos de causa CSAP, em ordem crescente.
#'
#' @param tipo Vetor de caracteres indicando o idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.
#'
#' @return Um vetor da classe \code{character} com os nomes (abreviados) dos 19 grupos de causa segundo a Lista Brasileira.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}}
#'
#' @references
#' Alfradique et al., Internações por Condições Sensíveis à Atenção Primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cad Saúde Pública 25(6):1337-49.
#'
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' nomesgruposCSAP()
#' nomesgruposCSAP(tipo = "pt.ca")
#' nomesgruposCSAP(tipo = "en")
#' nomesgruposCSAP(tipo = "es")
#'
#' @export
#'
nomesgruposCSAP <- function(tipo = "pt.ca") {
  # Nuntius errorum
  # ----------------
  if( !any(tipo == "pt.ca" |
           tipo != "pt.sa" |
           tipo != "en" |
           tipo != "es") ) {
    stop('tipo must be one of "pt.ca", "pt.sa", "en" or "es"')
  }

  # Nomes em Português com códigos UTF para os acentos
  # ---------------------------------------------------

  nomes.pt.ca <- c("01. Prev. vacina\U00E7\U00E3o",
                   "02. Gastroenterite",
                   "03. Anemia",
                   "04. Defic. nutricionais",
                   "05. Infec. ouvido, nariz e garganta",
                   "06. Pneumonias bacterianas",
                   "07. Asma",
                   "08. Pulmonares (DPOC)",
                   "09. Hipertens\U00E3o",
                   "10. Angina",
                   "11. Insuf. card\u00EDaca",
                   "12. Cerebrovasculares",
                   "13. Diabetes mellitus",
                   "14. Epilepsias",
                   "15. Infec. urin\U00E1ria",
                   "16. Infec. pele e subcut\U00E2neo",
                   "17. D. infl. \U00F3rg\U00E3os p\U00E9lvicos femininos",
                   "18. \U00DAlcera gastrointestinal",
                   "19. Pr\U00E9-natal e parto"
                   )

  # Names in Portuguese with no accents
  # ------------------------------------
  nomes.pt.sa <- c("1.Prev. vacinacao",
                   "2.Gastroenterite",
                   "3.Anemia",
                   "4.Def. nutricion.",
                   "5.Infec. ouvido, nariz e garganta",
                   "6.Pneumonias bacterianas",
                   "7.Asma",
                   "8.Pulmonares (DPOC)",
                   "9.Hipertensao",
                   "10.Angina",
                   "11.Insuf. cardiaca",
                   "12.Cerebrovasculares",
                   "13.Diabetes mellitus",
                   "14.Epilepsias",
                   "15.Infec. urinaria",
                   "16.Infec. pele e subcutaneo",
                   "17.D. infl. Orgaos pelvicos femininos",
                   "18.Ulcera gastrointestinal",
                   "19.Pre-natal e parto"
  )

  # Nomes em inglês
  # -----------------
  nomes.en <-   c("1.Vaccine preventable",
                  "2.Gastroenteritis",
                  "3.Anemia",
                  "4.Nutritional deficiency",
                  "5.Ear, nose and throat infections",
                  "6.Bacterial pneumonia",
                  "7.Asthma",
                  "8.Pulmonary (COPD)",
                  "9.Hypertension",
                  "10.Angina",
                  "11.Heart failure",
                  "12.Cerebrovascular",
                  "13.Diabetes mellitus",
                  "14.Convulsions and epilepsy",
                  "15.Urinary infection",
                  "16.Skin and subcutaneous infections",
                  "17.Pelvic inflammatory disease",
                  "18.Gastrointestinal ulcers",
                  "19.Pre-natal and childbirth"
  )

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
  nomes.es <- c("1.Inmunoprevenibles",
                "2.Gastroenterites",
                "3.Anemia",
                "4.Def. nutricionales",
                "5.Otitis, nariz y garganta",
                "6.Pneumon\u00EDas bacterianas",
                "7.Asma",
                "8.Pulmonares (EPOC)",
                "9.Hipertensi\U00F3n",
                "10.Angina",
                "11.Insuf. card\u00EDaca",
                "12.Cerebrovasculares",
                "13.Diabetes melitus",
                "14.Epilepsias",
                "15.Infecci\U00F3n urinaria",
                "16.Infec. piel y subcut\U00E1neo",
                "17.Enf infl \U00F3rganos p\U00E9lvicos femeninos",
                "18.\U00DAlcera gastrointestinal",
                "19.Enf del prenatal y parto"
  )

  if(tipo == "es")    return(nomes.es)
  if(tipo == "en")    return(nomes.en)
  if(tipo == "pt.sa") return(nomes.pt.sa)
  if(tipo == "pt.ca") return(nomes.pt.ca)
}
