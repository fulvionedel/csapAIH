#  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
#               Portaria MS nº 221, de 17 de abril de 2008
#            --- --- --- --- --- --- --- --- --- --- --- ---
#
listaBR <- function(cid){
  if(!is.character(cid)) cid <- as.character(cid)
# GRUPO 01 - Doenças preveníveis por imunização e condições sensíveis
g01 <- ifelse(cid >= "A33" & cid < "A38" | cid >= "B26" & cid < "B27" | cid >= "B05" & cid < "B07" |
                cid >= "A95" & cid < "A96" | cid >= "B16" & cid < "B17" | cid == "G000"              |
                cid >= "A15" & cid < "A20" | cid >= "I00" & cid < "I03" | cid >= "A51" & cid < "A54" |
                cid >= "B50" & cid < "B55" | cid >= "B77" & cid < "B78", 1, 2)
#GRUPO 02 - Gastrenterites
g02 <- ifelse(substr(cid, 1,2)=="A0" | substr(cid, 1,3)=="E86", 1, 2)
#GRUPO 03 - Anemia
g03 <- ifelse(substr(cid, 1,3)=="D50", 1, 2)
#GRUPO 04 - Deficiências nutricionais
g04 <- ifelse(cid >= "E40" & cid < "E47" | cid >= "E50" & cid < "E65", 1, 2)
#GRUPO 05 - Infec. ouvido, nariz e garganta
g05 <- ifelse(substr(cid, 1,3)=="H66" | cid >= "J0" & cid < "J04" | substr(cid, 1,3)=="J06" |
                substr(cid, 1,3)=="J31", 1, 2)
#GRUPO 06 - Pneumonias bacterianas
g06 <- ifelse(cid >= "J13"  & cid < "J15" | cid >= "J153" & cid <= "J154" |
                cid >= "J158" & cid <= "J159" | cid == "J181", 1, 2)
#GRUPO 07 - Asma
g07 <- ifelse(cid >= "J45" & cid < "J47", 1, 2)
#GRUPO 08 - DPOC
g08 <- ifelse(cid >= "J20" & cid < "J22" | cid >= "J40" & cid < "J45" | substr(cid, 1,3) == "J47", 1, 2)
#GRUPO 09 - Hipertensão
g09 <- ifelse(cid >= "I10" & cid < "I12", 1, 2)
#GRUPO 10 - Angina pectoris
g10 <- ifelse(substr(cid, 1,3)=="I20", 1, 2)
#GRUPO 11 - Insuficiência cardíaca
g11 <- ifelse(substr(cid, 1,3)=="I50" | substr(cid, 1,3)=="J81", 1, 2)
#GRUPO 12 - D. cerebrovasculares
g12 <- ifelse(cid >= "I63" & cid < "I68" | substr(cid, 1,3)=="I69" | cid >= "G45" & cid < "G47", 1, 2)
#GRUPO 13 - Diabete mellitus
g13 <- ifelse(cid >= "E10" & cid < "E15", 1, 2)
#GRUPO 14 - Epilepsias
g14 <- ifelse(cid >= "G40" & cid < "G42", 1, 2)
#GRUPO 15 - Inf. rim e trato urinário
g15 <- ifelse(cid >= "N10" & cid < "N13" | cid == "N390" | substr(cid, 1,3) == "N34" |
                substr(cid, 1,3) == "N30", 1, 2)
#GRUPO 16 - Inf. pele e tec. cel. subcutâneo
g16 <- ifelse(substr(cid, 1,3) == "A46" | cid >= "L01" & cid < "L05" | substr(cid, 1,3) == "L08", 1, 2)
#GRUPO 17 - D. infl. órgãos pélvicos femininos
g17 <- ifelse(cid >= "N70" & cid < "N74" | cid >= "N75" & cid < "N77", 1, 2)
#GRUPO 18 - Úlcera gastroint. com hemorr. ou perf.
g18 <- ifelse(cid >= "K25" & cid < "K29" | cid >= "K920" & cid <= "K922", 1, 2)
#GRUPO 19 - D. relacionadas ao pré-natal e parto
g19 <- ifelse(substr(cid, 1,3)=="O23" | substr(cid, 1,3)=="A50" | substr(cid, 1,4)=="P350", 1, 2)

csap <- factor(ifelse(g01==1 | g02==1 | g03==1 | g04==1 | g05==1 | g06==1 | g07==1 |
                        g08==1 | g09==1 | g10==1 | g11==1 | g12==1 | g13==1 | g14==1 |
                        g15==1 | g16==1 | g17==1 | g18==1 | g19==1, 1, 2), labels=c('sim', "n\u00E3o"))

grupo <- ifelse(g01==1, "g01", ifelse(g02==1, "g02", ifelse(g03==1, "g03", ifelse(g04==1, "g04",
                                                                                  ifelse(g05==1, "g05", ifelse(g06==1, "g06", ifelse(g07==1, "g07", ifelse(g08==1, "g08",
                                                                                                                                                           ifelse(g09==1, "g09", ifelse(g10==1, "g10", ifelse(g11==1, "g11", ifelse(g12==1, "g12",
                                                                                                                                                                                                                                    ifelse(g13==1, "g13", ifelse(g14==1, "g14", ifelse(g15==1, "g15", ifelse(g16==1, "g16",
                                                                                                                                                                                                                                                                                                             ifelse(g17==1, "g17", ifelse(g18==1, "g18", ifelse(g19==1, "g19", "n\u00E3o-CSAP")))))))))))))))))))

### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
niveis = c(paste0("g0", 1:9), paste0("g1", 0:9), "n\u00E3o-CSAP")
grupo = factor(grupo, levels = niveis)
return(grupo)
}
