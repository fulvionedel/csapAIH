#' @title Função para classificar códigos da CID-10 em Capítulos
#' 
#' @description Tomando um banco de dados com uma variável com códigos da CID-10, acrescenta uma variável com os capítulos da CID-10 correspondentes
#' @param cid nome da variável com os códigos da CID-10
#' @param data nome do banco de dados
#' @examples 
#' \dontrun{
#'  require(microdatasus)
#'  DORS19 <- fetch_datasus(2019, 01, 2019, 12, "RS", "SIM-DO")
#'  DORS19 <- cid10cap("CAUSABAS", DORS19)
#'  tabuleiro(DORS19$capcid)
#'  par(mar= c(5, 15, 1, 1))
#'  barplot(rev(table(DORS19$capcid)), horiz = T, las = 1, cex.names = .7, )
#' }
#' 
#' @importFrom data.table `:=` setDT
#' @export

cid10cap <- function(cid, data) {
   capcid <- NULL
   cid <- data[, cid]
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
      "XX.    Causas externas de morbidade e mortalidade"
   )
   data <- setDT(data)
   data <- data[, capcid := substr(cid, 1, 3),][capcid <= "B99", capcid := "01"][capcid >= "C00" & capcid <= "D48", capcid := "02"][capcid >= "D50" & capcid <= "D89", capcid := "03"][capcid >= "E00" & capcid <= "E90", capcid := "04"][capcid >= "F00" & capcid <= "F99", capcid := "05"][capcid >= "G00" & capcid <= "G99", capcid := "06"][capcid >= "H00" & capcid <= "H59", capcid := "07"][capcid >= "H60" & capcid <= "H95", capcid := "08"][capcid >= "I00" & capcid <= "I99", capcid := "09"][capcid >= "J00" & capcid <= "J99", capcid := "10"][capcid >= "K00" & capcid <= "K93", capcid := "11"][capcid >= "L00" & capcid <= "L99", capcid := "12"][capcid >= "M00" & capcid <= "M99", capcid := "13"][capcid >= "N00" & capcid <= "N99", capcid := "14"][capcid >= "O00" & capcid <= "O99", capcid := "15"][capcid >= "P00" & capcid <= "P96", capcid := "16"][capcid >= "Q00" & capcid <= "Q99", capcid := "17"][capcid >= "R00" & capcid <= "R99", capcid := "18"][capcid >= "V01" & capcid <= "Y98", capcid := "20"][, capcid := factor(capcid, labels = caps)]
   data[]
}
