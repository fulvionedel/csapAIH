#  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
#               Portaria MS nº 221, de 17 de abril de 2008
#            --- --- --- --- --- --- --- --- --- --- --- ---
#
#' @importFrom haven zap_labels is.labelled
#
listaBRMS <- function(cid){
  cid_2 <- substr(cid, 1, 2)
  cid_3 <- substr(cid, 1, 3)

  if(!is.character(cid)) cid <- as.character(cid)
  # if(is.labelled(cid)) cid <- zap_labels(cid)
  # GRUPO 01 - Doenças preveníveis por imunização e condições sensíveis
  g01 <- rep(2, length(cid))
  g01[cid_3 >= "A33" & cid_3 < "A38" | cid_3 == "B26" | cid_3 >= "B05" & cid_3 == "B06" |
      cid_3 == "A95" | cid_3 == "B16" | cid == "G000" |
      cid_3 >= "A15" & cid_3 < "A20" | cid_3 >= "I00" & cid_3 < "I03" | cid_3 >= "A51" & cid_3 < "A54" |
      cid_3 >= "B50" & cid_3 < "B55" | cid_3 == "B77"] <- 1
# g01 <- ifelse(cid_3 >= "A33" & cid_3 < "A38" | cid_3 >= "B26" & cid_3 < "B27" | cid_3 >= "B05" & cid_3 < "B07" |
#               cid_3 >= "A95" & cid_3 < "A96" | cid_3 >= "B16" & cid_3 < "B17" | cid == "G000"              |
#               cid_3 >= "A15" & cid_3 < "A20" | cid_3 >= "I00" & cid_3 < "I03" | cid_3 >= "A51" & cid_3 < "A54" |
#               cid_3 >= "B50" & cid_3 < "B55" | cid_3 >= "B77" & cid_3 < "B78", 1, 2)
#GRUPO 02 - Gastrenterites
# g02 <- ifelse(substr(cid, 1,2)=="A0" | substr(cid, 1,3)=="E86", 1, 2)
# chatGPT
# g02 <- ifelse(cid_2 == "A0" | cid_3 == "E86", 1, 2)
g02 <- rep(2, length(cid))
g02[cid_2 == "A0" | cid_3 == "E86"] <- 1

#GRUPO 03 - Anemia
# g03 <- ifelse(cid_3=="D50", 1, 2)
g03 <- rep(2, length(cid))
g03[cid_3 == "D50"] <- 1

#GRUPO 04 - Deficiências nutricionais
# g04 <- ifelse(cid >= "E40" & cid < "E47" | cid >= "E50" & cid < "E65", 1, 2)
g04 <- rep(2, length(cid))
g04[(cid >= "E40" & cid < "E47") | (cid >= "E50" & cid < "E65")] <- 1
# if(nlevels(factor(g04)) < 2) {
#   g04 <- factor(g04, levels = c(1, 2))
# }
# g04 <- factor(g04, levels = c(1, 2))

#GRUPO 05 - Infec. ouvido, nariz e garganta
# g05 <- ifelse(cid_3=="H66" | cid >= "J0" & cid < "J04" | cid_3=="J06" |
#                 cid_3=="J31", 1, 2)
g05 <- rep(2, length(cid))
g05[cid_3 == "H66" | cid >= "J0" & cid < "J04" | cid_3 == "J06" | cid_3 == "J31"] <- 1

#GRUPO 06 - Pneumonias bacterianas
# g06 <- ifelse(cid >= "J13"  & cid < "J15" | cid >= "J153" & cid <= "J154" |
#                 cid >= "J158" & cid <= "J159" | cid == "J181", 1, 2)
g06 <- rep(2, length(cid))
g06[cid >= "J13" & cid < "J15" |
    cid >= "J153" & cid <= "J154" |
    cid >= "J158" & cid <= "J159" |
    cid == "J181"] <- 1

#GRUPO 07 - Asma
# g07 <- ifelse(cid >= "J45" & cid < "J47", 1, 2)
g07 <- rep(2, length(cid))
# g07[cid >= "J45" & cid < "J47"] <- 1
# g07[cid_3 == "J45" | cid_3 == "J46"] <- 1
g07[grep("J45", cid)] <- 1
g07[grep("J46", cid)] <- 1

#GRUPO 08 - DPOC
g08 <- ifelse(cid >= "J20" & cid < "J22" | cid >= "J40" & cid < "J45" | cid_3 == "J47", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 09 - Hipertensão
g09 <- ifelse(cid >= "I10" & cid < "I12", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 10 - Angina pectoris
g10 <- ifelse(cid_3=="I20", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 11 - Insuficiência cardíaca
g11 <- ifelse(cid_3=="I50" | cid_3=="J81", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 12 - D. cerebrovasculares
g12 <- ifelse(cid >= "I63" & cid < "I68" | cid_3=="I69" | cid >= "G45" & cid < "G47", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 13 - Diabete mellitus
g13 <- ifelse(cid >= "E10" & cid < "E15", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 14 - Epilepsias
g14 <- ifelse(cid >= "G40" & cid < "G42", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 15 - Inf. rim e trato urinário
g15 <- ifelse(cid >= "N10" & cid < "N13" | cid == "N390" | cid_3 == "N34" |
                cid_3 == "N30", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 16 - Inf. pele e tec. cel. subcutâneo
g16 <- ifelse(cid_3 == "A46" | cid >= "L01" & cid < "L05" | cid_3 == "L08", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 17 - D. infl. órgãos pélvicos femininos
g17 <- ifelse(cid >= "N70" & cid < "N74" | cid >= "N75" & cid < "N77", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 18 - Úlcera gastroint. com hemorr. ou perf.
g18 <- ifelse(cid >= "K25" & cid < "K29" | cid >= "K920" & cid <= "K922", 1, 2)
# g04 <- rep(2, length(cid))

#GRUPO 19 - D. relacionadas ao pré-natal e parto
g19 <- ifelse(cid_3=="O23" | cid_3=="A50" | substr(cid, 1,4)=="P350", 1, 2)
# g04 <- rep(2, length(cid))



# csap <- factor(ifelse(g01==1 | g02==1 | g03==1 | g04==1 | g05==1 | g06==1 | g07==1 |
#                       g08==1 | g09==1 | g10==1 | g11==1 | g12==1 | g13==1 | g14==1 |
#                       g15==1 | g16==1 | g17==1 | g18==1 | g19==1, 1, 2), labels=c('sim', "n\u00E3o"))

csap <- rep(2, length(cid))
csap[g01==1 | g02==1 | g03==1 | g04==1 | g05==1 | g06==1 | g07==1 | g08==1 |
     g09==1 | g10==1 | g11==1 | g12==1 | g13==1 | g14==1 | g15==1 | g16==1 |
     g17==1 | g18==1 | g19==1] <- 1
csap <- factor(csap, levels = 1:2, labels = c('sim', "n\u00E3o"))

grupo <- rep("n\u00E3o-CSAP", length(cid))
grupo[g01==1] <- "g01"
grupo[g02==1] <- "g02"
grupo[g03==1] <- "g03"
grupo[g04==1] <- "g04"
grupo[g05==1] <- "g05"
grupo[g06==1] <- "g06"
grupo[g07==1] <- "g07"
grupo[g08==1] <- "g08"
grupo[g09==1] <- "g09"
grupo[g10==1] <- "g10"
grupo[g11==1] <- "g11"
grupo[g12==1] <- "g12"
grupo[g13==1] <- "g13"
grupo[g14==1] <- "g14"
grupo[g15==1] <- "g15"
grupo[g16==1] <- "g16"
grupo[g17==1] <- "g17"
grupo[g18==1] <- "g18"
grupo[g19==1] <- "g19"
# grupo <- ifelse(g01==1, "g01",
#                 ifelse(g02==1, "g02",
#                  ifelse(g03==1, "g03",
#                   ifelse(g04==1, "g04",
#                    ifelse(g05==1, "g05",
#                     ifelse(g06==1, "g06",
#                      ifelse(g07==1, "g07",
#                       ifelse(g08==1, "g08",
#                        ifelse(g09==1, "g09",
#                         ifelse(g10==1, "g10",
#                          ifelse(g11==1, "g11",
#                           ifelse(g12==1, "g12",
#                            ifelse(g13==1, "g13",
#                             ifelse(g14==1, "g14",
#                              ifelse(g15==1, "g15",
#                               ifelse(g16==1, "g16",
#                                ifelse(g17==1, "g17",
#                                 ifelse(g18==1, "g18",
#                                  ifelse(g19==1, "g19",
#                                   "n\u00E3o-CSAP")))))))))))))))))))

### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
niveis <- c(paste0("g0", 1:9), paste0("g1", 0:9), "n\u00E3o-CSAP")
grupo <- factor(grupo, levels = niveis)

return(data.frame(csap, grupo))
}
