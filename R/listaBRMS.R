#  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
#               Portaria MS nº 221, de 17 de abril de 2008
#            --- --- --- --- --- --- --- --- --- --- --- ---
#
#
listaBRMS <- function(cid){
  if(!is.character(cid)) cid <- as.character(cid)
  grupo <- dplyr::case_when(
    # GRUPO 01 - Doenças preveníveis por imunização e [outras] condições evitáveis
    grepl(x = cid, pattern = "^A1[5-9]|^I0[0-2]|^A5[1-3]|^B5[0-6]|^B77 |^A3[3-7]|^A95|^B16|^B26|G000") ~ "g01",
    # GRUPO 02 - Gastrenterites
    grepl(x = cid, pattern = "^A0[0-9]|^E86") ~ "g02",
    # GRUPO 03 - Anemia
    grepl(x = cid, pattern = "^D50") ~ "g03",
    # GRUPO 04 - Deficiências nutricionais
    grepl(x = cid, pattern = "^E4[0-6]|^E5[0-9]|^E6[0-4]") ~ "g04",
    # GRUPO 05 - Infec. ouvido, nariz e garganta
    grepl(x = cid, pattern = "^H66|^J0[0-3]|^J06|^J31") ~ "g05",
    # GRUPO 06 - Pneumonias bacterianas
    grepl(x = cid, pattern = "^J1[3-4]|J15[3-4]|J15[8-9]|J181") ~ "g06",
    # GRUPO 07 - Asma
    grepl(x = cid, pattern = "^J4[5-6]") ~ "g07",
    # GRUPO 08 - Pulmonares
    grepl(x = cid, pattern = "^J2[0-1]|^J4[0-4]|^J47") ~ "g08",
    # GRUPO 09 - Hipertensão
    grepl(x = cid, pattern = "^I1[0-1]") ~ "g09",
    # GRUPO 10 - Angina pectoris
    grepl(x = cid, pattern = "^I20") ~ "g10",
    # GRUPO 11 - Insuficiência cardíaca
    grepl(x = cid, pattern = "^I50|^J81") ~ "g11",
    # GRUPO 12 - D. cerebrovasculares
    grepl(x = cid, pattern = "^I6[3-7]|^I69|^G4[5-6]") ~ "g12",
    # GRUPO 13 - Diabete mellitus
    grepl(x = cid, pattern = "^E1[0-4]") ~ "g13",
    # GRUPO 14 - Epilepsias
    grepl(x = cid, pattern = "^G4[0-1]") ~ "g14",
    # GRUPO 15 - Inf. rim e trato urinário
    grepl(x = cid, pattern = "^N1[0-2]|^N30|^N34|N390") ~ "g15",
    # GRUPO 16 - Inf. pele e tec. cel. subcutâneo
    grepl(x = cid, pattern = "^A46|^L0[1-4]|^L08") ~ "g16",
    # GRUPO 17 - D. infl. órgãos pélvicos femininos
    grepl(x = cid, pattern = "^N7[0-3]|^N7[5-6]") ~ "g17",
    # GRUPO 18 - Úlcera gastroint. com hemorr. ou perf.
    grepl(x = cid, pattern = "^K2[5-8]|K920|K921|K922") ~ "g18",
    # GRUPO 19 - D. relacionadas ao pré-natal e parto
    grepl(x = cid, pattern = "^O23|^A50|P350") ~ "g19",
    # Demais causas
    TRUE ~ "g00")

  csap <- ifelse(grupo %in% "g00", "n\u00E3o", "sim") |> factor(levels = c("sim", "n\u00E3o"))
  #
  ### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
  niveis <- c(paste0("g0", 1:9), paste0("g1", 0:9), "g00")
  grupo <- factor(grupo, levels = niveis, labels = c(niveis[1:19], "nao-CSAP"))

  data.frame(csap, grupo)
}
