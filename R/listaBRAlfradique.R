#  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
#               Alfradique et al., https://doi.org/10.1590/S0102-311X2009000600016
#            --- --- --- --- --- --- --- --- --- --- --- ---
#
#' @importFrom dplyr if_else
#'
listaBRAlfradique <- function(cid){
  if(!is.character(cid)) cid <- as.character(cid)
  cid3 <- substr(cid, 1, 3)

# GRUPO 01 - Doenças preveníveis por imunização
g01 <- if_else(cid3 >= "A33" & cid3 < "A38" | cid3 == "A95" | cid3 == "B16" |
               cid3 >= "B05" & cid3 < "B07" | cid3 == "B26" | cid == "G000" |
               cid == "A170"  | cid3 == "A19", 1, 2)
# GRUPO 02 - Condições evitáveis
g02 <- if_else(cid3 >= "A15" & cid3 < "A17" | cid >= "A171" & cid3 <= "A19" |
              cid >= "I00" & cid < "I03" | cid >= "A51" & cid < "A54" |
              cid >= "B50" & cid < "B55" | cid3 == "B77", 1, 2)
# GRUPO 03 - Gastrenterites
g03 <- if_else(substr(cid, 1,2)=="A0" | cid3=="E86", 1, 2)
#GRUPO 04 - Anemia
g04 <- if_else(cid3=="D50", 1, 2)
#GRUPO 05 - Deficiências nutricionais
g05 <- if_else(cid >= "E40" & cid < "E47" | cid >= "E50" & cid < "E65", 1, 2)
#GRUPO 06 - Infec. ouvido, nariz e garganta
g06 <- if_else(cid3=="H66" | cid >= "J0" & cid < "J04" | cid3=="J06" |
                cid3=="J31", 1, 2)
#GRUPO 07 - Pneumonias bacterianas
g07 <- if_else(cid >= "J13"  & cid < "J15" | cid >= "J153" & cid <= "J154" |
                cid >= "J158" & cid <= "J159" | cid == "J181", 1, 2)
#GRUPO 08 - Asma
g08 <- if_else(cid >= "J45" & cid < "J47", 1, 2)
#GRUPO 09 - DPOC
g09 <- if_else(cid >= "J20" & cid < "J22" | cid >= "J40" & cid < "J45" | cid3 == "J47", 1, 2)
#GRUPO 10 - Hipertensão
g10 <- if_else(cid >= "I10" & cid < "I12", 1, 2)
#GRUPO 11 - Angina pectoris
g11 <- if_else(cid3=="I20", 1, 2)
#GRUPO 12 - Insuficiência cardíaca
g12 <- if_else(cid3=="I50" | cid3=="J81", 1, 2)
#GRUPO 13 - D. cerebrovasculares
g13 <- if_else(cid >= "I63" & cid < "I68" | cid3=="I69" | cid >= "G45" & cid < "G47", 1, 2)
#GRUPO 14 - Diabete mellitus
g14 <- if_else(cid >= "E10" & cid < "E15", 1, 2)
#GRUPO 15 - Epilepsias
g15 <- if_else(cid >= "G40" & cid < "G42", 1, 2)
#GRUPO 16 - Inf. rim e trato urinário
g16 <- if_else(cid >= "N10" & cid < "N13" | cid == "N390" | cid3 == "N34" |
                cid3 == "N30", 1, 2)
#GRUPO 17 - Inf. pele e tec. cel. subcutâneo
g17 <- if_else(cid3 == "A46" | cid >= "L01" & cid < "L05" | cid3 == "L08", 1, 2)
#GRUPO 18 - D. infl. órgãos pélvicos femininos
g18 <- if_else(cid >= "N70" & cid < "N74" | cid >= "N75" & cid < "N77", 1, 2)
#GRUPO 19 - Úlcera gastroint. com hemorr. ou perf.
g19 <- if_else(cid >= "K25" & cid < "K29" | cid >= "K920" & cid <= "K922", 1, 2)
#GRUPO 20 - D. relacionadas ao pré-natal e parto
g20 <- if_else(cid3=="O23" | cid3=="A50" | cid=="P350", 1, 2)

csap <- factor(if_else(g01==1 | g02==1 | g03==1 | g04==1 | g05==1 | g06==1 | g07==1 |
                       g08==1 | g09==1 | g10==1 | g11==1 | g12==1 | g13==1 | g14==1 |
                       g15==1 | g16==1 | g17==1 | g18==1 | g19==1 | g20==1, 1, 2),
               labels=c('sim', "n\u00E3o"))

grupo <- if_else(g01==1, "g01",
          if_else(g02==1, "g02",
           if_else(g03==1, "g03",
            if_else(g04==1, "g04",
             if_else(g05==1, "g05",
              if_else(g06==1, "g06",
               if_else(g07==1, "g07",
                if_else(g08==1, "g08",
                 if_else(g09==1, "g09",
                  if_else(g10==1, "g10",
                   if_else(g11==1, "g11",
                    if_else(g12==1, "g12",
                     if_else(g13==1, "g13",
                      if_else(g14==1, "g14",
                       if_else(g15==1, "g15",
                        if_else(g16==1, "g16",
                         if_else(g17==1, "g17",
                          if_else(g18==1, "g18",
                           if_else(g19==1, "g19",
                            if_else(g20==1, "g20",
                             "n\u00E3o-CSAP"))))))))))))))))))))

### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
niveis = c(paste0("g0", 1:9), paste0("g1", 0:9), "g20", "n\u00E3o-CSAP")
grupo = factor(grupo, levels = niveis)
return(data.frame(csap, grupo))
}
