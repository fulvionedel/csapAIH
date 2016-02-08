csapAIH <-
function(x, grupos=TRUE, sihsus=TRUE, x.procobst=TRUE, longa=FALSE, cep=TRUE, cnes=TRUE,
         arquivo=TRUE, ...) 
  {
    #===================
    ## Preparar os dados
    #===================
    if (class(x)=='factor') arquivo=FALSE
    if (class(x)=='data.frame') arquivo=FALSE
    if (arquivo==FALSE & class(x)!='data.frame') {
        cid = as.character(x)
        sihsus=FALSE }
    # Leitura do arquivo de dados
    if (arquivo==TRUE) {
        if (grepl('dbf', x, ignore.case=TRUE)==TRUE) { x <- foreign::read.dbf(x, as.is=TRUE, ...) }
        else
            warning('---------------------------------------------------------------------\n
        ERRO DE LEITURA em ', deparse(substitute(x)), ' \n
  O objeto deve ser da classe "factor"ou "data.frame", \n
  ou um arquivo formato DBF (ou dbf). \n
-----------------------------------------------------------------------\n ')    #}
#
    # Total de registros importados
    suppressWarnings(message("Importados ", format(length(x[,1]), big.mark = "."), " registros."))
}
    # Garantir o trabalho com operadores mais tarde, no CID    
    if (sihsus==FALSE) cid=as.character(cid)
#--------------------------------------------------------------------------#
#   Organização e seleção de variáveis de bancos com estrutura do SIHSUS   #
#--------------------------------------------------------------------------#
    if (sihsus==TRUE) {
        #   Exclusão dos procedimentos obstétricos 
        #--------------------------------------------
#        0310010012 ASSISTENCIA AO PARTO S/ DISTOCIA
#        0310010020 ATEND AO RECEM-NASCIDO EM SALA DE PARTO
#        0310010039 PARTO NORMAL                           
#        0310010047 PARTO NORMAL EM GESTACAO DE ALTO RISCO 
#        0411010018 DESCOLAMENTO MANUAL DE PLACENTA        
#        0411010026 PARTO CESARIANO EM GESTACAO ALTO RISCO 
#        0411010034 PARTO CESARIANO                        
#        0411010042 PARTO CESARIANO C/ LAQUEADURA TUBARIA  
#        0411020013 CURETAGEM POS-ABORTAMENTO / PUERPERAL  
#        0411020021 EMBRIOTOMIA
        procobst <- c('0310010012', '0310010020', '0310010039', '0310010047', '0411010018', '0411010026', 
                      '0411010034', '0411010042', '0411020013', '0411020021')
        if (x.procobst==TRUE) {
            tamini <- length(x[,1])
            x <- subset(x, subset=x$PROC_REA %in% procobst==FALSE )
            x <- droplevels(x)
            tamfin <- length(x[,1])
            fr <- suppressWarnings( format(tamini-tamfin, big.mark = ".") )
            pfr <- format(round((tamini-tamfin)/tamini*100, 1), big.mark = ".", decimal.mark = ",")
            message("Exclu\u00EDdos  ", fr, " (", pfr,
                    "\u0025) registros de procedimentos obst\u00E9tricos.", sep="")
        }
        #   Exclusão das AIHs de longa permanência
        #--------------------------------------------
        if (longa==FALSE) {
          fr <- suppressWarnings(format(table(x$IDENT)[2], big.mark = "."))
          pfr <- format(round(prop.table(table(x$IDENT))[2]*100,1), big.mark = ".", decimal.mark = ",")
          x <- subset(x, x$IDENT==1)        
          message("Exclu\u00EDdos  ", fr, " (", pfr,
                  "\u0025) registros de AIH de longa perman\u00EAncia.", sep="")
        }
        suppressWarnings(message("Exportados ", formatC(length(x[,1]), big.mark = "."), " registros."))
        
        #   Criar as variáveis do banco final
        #--------------------------------------------
        cid = as.character(x$DIAG_PRINC)
        nasc <- as.Date(format(x$NASC), format="%Y%m%d")
        data.inter <- as.Date(format(x$DT_INTER), format="%Y%m%d")
        data.saida <- as.Date(format(x$DT_SAIDA), format="%Y%m%d") 
        COD_IDADE <- as.character(x$COD_IDADE)
        idade <- ifelse(COD_IDADE == 4, x$IDADE, 
                 ifelse(COD_IDADE  < 4, 0,
                 ifelse(COD_IDADE == 5, x$IDADE+100, NA)))
        comment(idade) <- "em anos completos"
        fxetar <- cut(idade, include.lowest=TRUE, right=FALSE, 
                      breaks=c(0:19,20,25,30,35,40,45,50,55,60,65,70,75,80, max(idade)), 
                      labels=c("<1ano", " 1ano", " 2anos", " 3anos", " 4anos", " 5anos", 
                               " 6anos", " 7anos", " 8anos", " 9anos", "10anos", "11anos", 
                               "12anos", "13anos", "14anos", "15anos", "16anos", "17anos",
                               "18anos", "19anos", "20-24", "25-29", "30-34", "35-39", 
                               "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74",
                               "75-79", "80 +")        
                        )
        fxetar5 <- cut(idade, right=FALSE, include.lowest=TRUE, 
                       breaks=c(0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80, max(idade)), 
                       labels=c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34","35-39",
                                "40-44","45-49","50-54", "55-59", "60-64", "65-69", "70-74", "75-79",
                                "80 +")
                         )
        munres   <- x$MUNIC_RES
        munint   <- x$MUNIC_MOV
        sexo     <- factor(x$SEXO, levels=c(1,3), labels=c("masc", "fem"))
        n.aih    <- as.character(x$N_AIH)
        proc.rea <- x$PROC_REA
        proc.obst <- ifelse(proc.rea %in% procobst, 1, 2)
                           #, labels=c('sim', 'nao'))  
#         Hmisc::label(munres)   <- 'Munic\u00EDpio de resid\u00EAncia'
#         Hmisc::label(munint)   <- 'Munic\u00EDpio de interna\u00E7\u00E3o'
#         Hmisc::label(n.aih)    <- 'N\u00B0 da AIH'
#         Hmisc::label(proc.rea) <- 'Procedimento realizado'
#         Hmisc::label(nasc)     <- 'Data de nascimento'
#         Hmisc::label(fxetar)   <- 'Faixa et\u00E1ria detalhada'
#         Hmisc::label(fxetar5)  <- 'Faixa et\u00E1ria quinquenal'
#         if(x.procobst==TRUE) Hmisc::label(proc.obst) <- 'Procedimento obst\u00E9trico'
        Hmisc::label(munres)   <- 'Municipio de residencia'
        Hmisc::label(munint)   <- 'Municipio de internacao'
        attr(sexo, which="label") <- "Sexo"
        Hmisc::label(n.aih)    <- 'No. da AIH'
        Hmisc::label(proc.rea) <- 'Procedimento realizado'
        Hmisc::label(nasc)     <- 'Data de nascimento'
        attr(idade, which="label") <- "Idade"
        Hmisc::label(fxetar)   <- 'Faixa etaria detalhada'
        Hmisc::label(fxetar5)  <- 'Faixa etaria quinquenal'
        attr(cid, which="label") <- "CID-10"
        if(x.procobst==TRUE) Hmisc::label(proc.obst) <- 'Procedimento obstetrico'
    }
# 
    #=====================================
    ## Criar as variáveis 'CSAP' e 'grupo'
    #=====================================
    # Definir missings no cid:
    cid[is.na(cid)] <- NA
    cid[cid==""] <- NA
    #----------------------------------------------------------------------------
    #  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA
    #               Portaria MS nº 221, de 17 de abril de 2008
    #----------------------------------------------------------------------------
    #
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
    attr(csap, which="label") <- "CSAP"
    
    grupo <- ifelse(g01==1, "g01", ifelse(g02==1, "g02", ifelse(g03==1, "g03", ifelse(g04==1, "g04", 
             ifelse(g05==1, "g05", ifelse(g06==1, "g06", ifelse(g07==1, "g07", ifelse(g08==1, "g08", 
             ifelse(g09==1, "g09", ifelse(g10==1, "g10", ifelse(g11==1, "g11", ifelse(g12==1, "g12",
             ifelse(g13==1, "g13", ifelse(g14==1, "g14", ifelse(g15==1, "g15", ifelse(g16==1, "g16", 
             ifelse(g17==1, "g17", ifelse(g18==1, "g18", ifelse(g19==1, "g19", "n\u00E3o-CSAP")))))))))))))))))))
    attr(grupo, which="label") <- "Grupo de causa CSAP"
    
############################
### Montar o objeto final
############################
## Se for uma base do SIH/SUS:
    if (sihsus==TRUE) {
      banco <- data.frame(n.aih, munres, munint, sexo, nasc, idade, fxetar, fxetar5, 
                          csap, grupo, cid, proc.rea, data.inter, data.saida) 
      if (cep==TRUE) {  
        banco$cep <- x$CEP 
        # Hmisc::label(banco$cep) <- 'C\u00F3digo de Endere\u00E7amento Postal'
        Hmisc::label(banco$cep) <- 'Codigo de Enderecamento Postal'
      }
      if (cnes==TRUE) {
        banco$cnes <- x$CNES 
        # Hmisc::label(banco$cnes) <- 'N\u00B0 do hospital no CNES'
        Hmisc::label(banco$cnes) <- 'No. do hospital no CNES'
      }
      if (x.procobst==FALSE )  {
        banco$proc.obst <- proc.obst
        Hmisc::label(banco$proc.obst) <- 'Procedimento obstetrico'
      }
      if (grupos==FALSE ) { banco <- subset(banco, select = - grupo) } 
    }
## Se não for uma base do SIH/SUS:
    if ( sihsus==FALSE & grupos==TRUE ) { banco <- data.frame(csap, grupo, cid) } 
    if ( sihsus ==FALSE & grupos==FALSE ) { 
      banco <- csap 
      class(banco) <- 'factor'
    }

    return(banco)
}
