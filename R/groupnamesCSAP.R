#' @title Names of Brazilian Primary Health Care Sensitive Conditions groups of cause
#' @aliases groupnamesCSAP
#'
#' @description List the 19 groups of cause from the Brazilian list of Primary Health Care Sensitive Conditions (PHCSC, CSAP).
#'
#' @param idioma Character vector indicating how to type the names; may be "pt.ca" (default) for names in Portuguese with accents, "pt.sa" for names in Portuguese without accents, "en", for names in English, or "es", for names in Spanish.
#' @param nomes Allows a personalized list of group names.
#'
#' @references
#' #' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' @examples
#' groupnamesCSAP()
#' groupnamesCSAP(idioma = "pt.sa")
#' groupnamesCSAP(idioma = "en")
#' groupnamesCSAP(idioma = "es")
#'
#' @export
groupnamesCSAP <- function(idioma = "pt.ca", nomes = NULL)
{
  # Nuntius errorum
  # ----------------
  if( !any(idioma == "pt.ca" |
           idioma != "pt.sa" |
           idioma != "en" |
           idioma != "es")
      &
      is.null(nomes)) {
    stop('idioma must be one of "pt.ca", "pt.sa", "en" or "es",
         or nomes must be a vector with the group names')
  }
  #
  #
  # Names in Portuguese with UTF code for accents
  # ----------------------------------------------
  nomes.pt.ca <- c("1.Prev. vacina\U00E7\U00E3o",
                    "2.Gastroenterite",
                    "3.Anemia",
                    "4.Defs. nutricionais",
                    "5.Infec. ouvido, nariz e garganta",
                    "6.Pneumonias bacterianas",
                    "7.Asma",
                    "8.Pulmonares (DPOC)",
                    "9.Hipertens\U00E3o",
                    "10.Angina",
                    "11.Insuf. card\u00EDaca",
                    "12.Cerebrovasculares",
                    "13.Diabetes mellitus",
                    "14.Epilepsias",
                    "15.Infec. urin\U00E1ria",
                    "16.Infec. pele e subcut\U00E2neo",
                    "17.D. infl. \U00F3rg\U00E3os p\U00E9lvicos femininos",
                    "18.\U00DAlcera gastrointestinal",
                    "19.Pr\U00E9-natal e parto"
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

  # Names in English
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

  # Names in Spanish
  # ------------------
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

  if(!is.null(nomes))   return(nomes)
  if(idioma == "es")    return(nomes.es)
  if(idioma == "en")    return(nomes.en)
  if(idioma == "pt.sa") return(nomes.pt.sa)
  if(idioma == "pt.ca") return(nomes.pt.ca)
}
