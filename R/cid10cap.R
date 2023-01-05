#' @title Função para classificar códigos da CID-10 em Capítulos
#'
#' @description Tomando um vetor com códigos da CID-10, acrescenta uma variável com os capítulos da CID-10 correspondentes
#' @param cid Nome do vetor com os códigos da CID-10
#' @param droplevels Se TRUE, desconsidera os capítulos sem nenhuma ocorrência de casos. O padrão é FALSE, o que retorna uma tabela com zeros nos capítulos sem ocorrência de casos.
#'
#' @examples
#' cid10cap(aih500$DIAG_PRINC) |> table()
#' cid10cap(aih500$DIAG_PRINC, droplevels = TRUE) |> table()
#' \dontrun{
#'   cid10cap(Rcoisas::obitosRS2019$CAUSABAS) |> table()
#' }
#'
#' @importFrom dplyr case_when %>%
#'
#' @export
#'

cid10cap <- function(cid, droplevels = FALSE) {
  cids <- cid |>
    as.character() |>
    substr(1, 3)

  caps <- c(
    "I.     Algumas doen\u00E7as infecciosas e parasit\U00e1rias",
    "II.    Neoplasias (tumores)",
    "III.   Doen\u00e7as sangue \U00F3rg\U00E3os hemat e transt imunit\U00e1r",
    "IV.    Doen\u00e7as end\u00F3crinas nutricionais e metab\U00F3licas",
    "V.     Transtornos mentais e comportamentais",
    "VI.    Doen\u00e7as do sistema nervoso",
    "VII.   Doen\u00e7as do olho e anexos",
    "VIII.  Doen\u00e7as do ouvido e da ap\u00f3fise mast\U00F3ide",
    "IX.    Doen\u00e7as do aparelho circulat\U00F3rio",
    "X.     Doen\u00e7as do aparelho respirat\U00F3rio",
    "XI.    Doen\u00e7as do aparelho digestivo",
    "XII.   Doen\u00e7as da pele e do tecido subcut\U00e2neo",
    "XIII.  Doen\u00e7as sist osteomuscular e tec conjuntivo",
    "XIV.   Doen\u00e7as do aparelho geniturin\U00e1rio",
    "XV.    Gravidez parto e puerp\u00E9rio",
    "XVI.   Algumas afec originadas no per\U00EDodo perinatal",
    "XVII.  Malf cong deformid e anomalias cromoss\U00F4micas",
    "XVIII. Sint sinais e achad anorm ex cl\U00EDn e laborat",
    "XIX.   Les\u00F5es, envenenamentos e algumas outras consequ\u00EAncias de causas externas",
    "XX.    Causas externas de morbidade e mortalidade",
    "XXI.   Fatores que exercem influ\u00EAncia sobre o estado de sa\u00FAde e o contato com servi\u00E7os de sa\u00FAde"
  )

  capcid <- case_when(cids <= "B99" ~ 1,
                      cids >= "C00" & cids <= "D48" ~ 2,
                      cids >= "D50" & cids <= "D89" ~ 3,
                      cids >= "E00" & cids <= "E90" ~ 4,
                      cids >= "F00" & cids <= "F99" ~ 5,
                      cids >= "G00" & cids <= "G99" ~ 6,
                      cids >= "H00" & cids <= "H59" ~ 7,
                      cids >= "H60" & cids <= "H95" ~ 8,
                      cids >= "I00" & cids <= "I99" ~ 9,
                      cids >= "J00" & cids <= "J99" ~ 10,
                      cids >= "K00" & cids <= "K93" ~ 11,
                      cids >= "L00" & cids <= "L99" ~ 12,
                      cids >= "M00" & cids <= "M99" ~ 13,
                      cids >= "N00" & cids <= "N99" ~ 14,
                      cids >= "O00" & cids <= "O99" ~ 15,
                      cids >= "P00" & cids <= "P96" ~ 16,
                      cids >= "Q00" & cids <= "Q99" ~ 17,
                      cids >= "R00" & cids <= "R99" ~ 18,
                      cids >= "S00" & cids <= "T98" ~ 19,
                      cids >= "V01" & cids <= "Y98" ~ 20,
                      cids >= "Z00" & cids <= "Z99" ~ 21) %>%
    factor(levels = 1:21, labels = caps)
  if(droplevels == TRUE) droplevels(capcid)
  else capcid
}
