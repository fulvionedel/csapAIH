#  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
#               Alfradique et al., https://doi.org/10.1590/S0102-311X2009000600016
#            --- --- --- --- --- --- --- --- --- --- --- ---
#
#' @importFrom dplyr case_when
#'
listaBRAlfradique <- function(cid){
  if(!is.character(cid)) cid <- as.character(cid)
  grupo <- dplyr::case_when(
# GRUPO 01 - Doenças preveníveis por imunização
    grepl(x = cid, pattern = "A170|^A19|^A3[3-7]|^A95|^B0[5-6]|^B16|^B26|G000") ~ "g01",
# GRUPO 02 - Condições evitáveis
    grepl(x = cid, pattern = "^A1[5-6]|A17[1-9]|^A18|^I0[0-2]|^A5[1-3]|^B5[0-4]|^B77") ~ "g02",
# GRUPO 03 - Gastrenterites
    grepl(x = cid, pattern = "^A0[0-9]|^E86") ~ "g03",
# GRUPO 04 - Anemia
    grepl(x = cid, pattern = "^D50") ~ "g04",
# GRUPO 05 - Deficiências nutricionais
    grepl(x = cid, pattern = "^E4[0-6]|^E5[0-9]|^E6[0-4]") ~ "g05",
# GRUPO 06 - Infec. ouvido, nariz e garganta
    grepl(x = cid, pattern = "^H66|^J0[0-3]|^J06|^J31") ~ "g06",
# GRUPO 07 - Pneumonias bacterianas
    grepl(x = cid, pattern = "^J1[3-4]|J15[3-4]|J15[8-9]|J181") ~ "g07",
# GRUPO 08 - Asma
    grepl(x = cid, pattern = "^J4[5-6]") ~ "g08",
# GRUPO 09 - DPOC
    grepl(x = cid, pattern = "^J2[0-1]|^J4[0-4]|^J47") ~ "g09",
# GRUPO 10 - Hipertensão
    grepl(x = cid, pattern = "^I1[0-1]") ~ "g10",
# GRUPO 11 - Angina pectoris
    grepl(x = cid, pattern = "^I20") ~ "g11",
# GRUPO 12 - Insuficiência cardíaca
    grepl(x = cid, pattern = "^I50|^J81") ~ "g12",
# GRUPO 13 - D. cerebrovasculares
    grepl(x = cid, pattern = "^I6[3-7]|^I69|^G4[5-6]") ~ "g13",
# GRUPO 14 - Diabete mellitus
    grepl(x = cid, pattern = "^E1[0-4]") ~ "g14",
# GRUPO 15 - Epilepsias
    grepl(x = cid, pattern = "^G4[0-1]") ~ "g15",
# GRUPO 16 - Inf. rim e trato urinário
    grepl(x = cid, pattern = "^N1[0-2]|^N30|^N34|N390") ~ "g16",
# GRUPO 17 - Inf. pele e tec. cel. subcutâneo
    grepl(x = cid, pattern = "^A46|^L0[1-4]|^L08") ~ "g17",
# GRUPO 18 - D. infl. órgãos pélvicos femininos
    grepl(x = cid, pattern = "^N7[0-3]|^N7[5-6]") ~ "g18",
# GRUPO 19 - Úlcera gastroint. com hemorr. ou perf.
    grepl(x = cid, pattern = "^K2[5-8]|K920|K921|K922") ~ "g19",
# GRUPO 20 - D. relacionadas ao pré-natal e parto
    grepl(x = cid, pattern = "^O23|^A50|P350") ~ "g20",
# Demais causas
    TRUE ~ "g00")

  csap <- ifelse(cid %in% grupo, "sim", "n\u00E3o")
#
#                        g08==1 | g09==1 | g10==1 | g11==1 | g12==1 | g13==1 | g14==1 |
#                        g15==1 | g16==1 | g17==1 | g18==1 | g19==1 | g20==1, 1, 2),
#                labels=c('sim', "n\u00E3o"))
#
#
### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
niveis <- c(paste0("g0", 1:9), paste0("g1", 0:9), "g20", "g00")
grupo <- factor(grupo, levels = niveis, labels = c(niveis[1:20], "no-CSAP"))

data.frame(csap, grupo)
}
