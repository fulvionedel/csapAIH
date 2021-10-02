<<<<<<< HEAD
#' Classificar Condições Sensíveis à Atenção Primária
#' @aliases csapAIH
#'
#' @description Classifica códigos da 10ª Revisão da Classificação Internacional de Doenças (CID-10) segundo a Lista Brasileira de Internação por Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos "arquivos da AIH" (RD??????.DBC; BD-SIH/SUS).
#'
#' @param x alvo da função: um arquivo, banco de dados ou vetor com códigos da CID-10 (ver \code{detalhes});
#' @param grupos argumento lógico, obrigatório; \code{TRUE} (padrão) indica que as internações serão classificadas também em grupos de causas CSAP;
#' @param sihsus argumento lógico, obrigatório se \code{x} for um arquivo; \code{TRUE} (padrão) indica que o arquivo ou banco de dados a ser tabulado tem minimamente os seguintes campos dos arquivos da AIH:
#'   \itemize{
#'     \item{DIAG_PRINC }{diagnóstico principal da internação;}
#'     \item NASC {data de nascimento; }
#'     \item DT_INTER {	data da internação; }
#'     \item DT_SAIDA {	data da alta hospitalar; }
#'     \item COD_IDADE {	código indicando a faixa etária a que se refere o valor registrado no campo idade; }
#'     \item IDADE	{idade (tempo de vida acumulado) do paciente, na unidade indicada no campo COD_IDADE;}
#'     \item MUNIC_RES	{município de residência do paciente; }
#'     \item MUNIC_MOV {município de internação do paciente; }
#'     \item SEXO { sexo do paciente; }
#'     \item N_AIH	{ número da AIH; }
#'     \item {PROC_REA} { procedimento realizado, segundo a tabela do SIH/SUS.}
#'     }
#' @param procobst.rm argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por procedimento obstétrico (\code{ver detalhes});
#' @param parto.rm argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por parto (\code{ver detalhes});
#' @param longa.rm argumento lógico; \code{TRUE} (padrão) exclui as AIH de longa permanência (AIH tipo 5), retornando uma mensagem com o número e proporção de registros excluídos e o total de registros importados; argumento válido apenas se \code{sihsus=TRUE};
#' @param cep argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) inclui no banco o Código de Endereçamento Postal do indivíduo; argumento válido apenas se \code{sihsus=TRUE};
#' @param cnes argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) inclui no banco o nº do hospital no Cadastro Nacional de Estabelecimentos de Saúde; argumento válido apenas se \code{sihsus=TRUE};
#' @param arquivo argumento lógico, obrigatório; \code{TRUE} (padrão) indica que o alvo da função (\code{x}) é um arquivo; \code{FALSE} indica que \code{x} é um objeto no espaço de trabalho; é automaticamente marcado como \code{FALSE} quando \code{x} é um \code{factor} ou \code{data frame}; deve ser definido pelo usuário como \code{FALSE} apenas quando \code{x} contiver em seu nome as sequências "dbc", "dbf" ou "csv" sem que isso seja a extensão do arquivo; apenas arquivos com esses formatos podem ser lidos;
#' @param sep usado para a leitura de arquivos da AIH em formato CSV; pode ser ";" para arquivos separados por ponto-e-vírgula e com vírgula como separador decimal, ou "," para arquivos separados por vírgula e com ponto como separador decimal;
#' @param cid identifica a varivável contendo os códigos da CID-10, em bancos de dados sem a estrutura do SIHSUS; argumento obrigatório nesses casos;
#' @param ... permite a inclusão de argumentos das funções \code{\link{read.table}} e suas derivadas.
#'
#' @details
#'  \itemize{
#'   \item{x pode ser:}{
#'    \enumerate{
#'     \item{ }{um arquivo de dados armazenado num diretório; }
#'     \item{ }{um banco de dados, ou um vetor da classe \code{factor} presente como objeto no espaço de trabalho do R, em que uma das variáveis, ou o vetor, contenha códigos da CID-10. }
#'    }
#'
#' Se for um arquivo, o nome deve ser escrito entre aspas e com a extensão do arquivo (DBC, DBF ou CSV, em minúsculas ou maíusculas). Se não estiver no diretório de trabalho ativo, seu nome deve ser precedido pelo caminho (path) até o diretório de armazenamento. Se estiver em outro formato, podem-se usar os argumentos da função \code{\link{read.table}} para leitura dos dados.
#'
#' Se a função for dirigida a um objeto no espaço de trabalho da classe \code{factor} ou \code{data.frame}, estes também são reconhecidos e o comando é o mesmo: \code{csapAIH(<objeto>)}. Se o objeto for de outra classe, como \code{character} ou \code{matrix}, é necessário definir o argumento "arquivo" como FALSE: \code{csapAIH(<objeto>, arquivo = FALSE)}, ou, para vetores isolados, defini-lo como fator: \code{csapAIH(as.factor(<objeto>))}.
#' }
#'
#' \item{procbst.rm } {= TRUE (padrão) exclui as internações por procedimentos relacionados ao parto ou abortamento. São excluídas as internações pelos seguintes procedimentos obstétricos, independente do diagnóstico:
#'   \itemize{
#'    \item{0310010012 } ASSISTENCIA AO PARTO S/ DISTOCIA
#'    \item{0310010020 } ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO
#'    \item{0310010039 } PARTO NORMAL
#'    \item{0310010047 } PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO
#'    \item{0411010018 } DESCOLAMENTO MANUAL DE PLACENTA
#'    \item{0411010026 } PARTO CESARIANO EM GESTAÇÃO ALTO RISCO
#'    \item{0411010034 } PARTO CESARIANO
#'    \item{0411010042 } PARTO CESARIANO C/ LAQUEADURA TUBÁRIA
#'    \item{0411020013 } CURETAGEM PÓS-ABORTAMENTO / PUERPERAL
#'    \item{0411020021 } EMBRIOTOMIA
#'    } }
#' \item{parto.rm } {= TRUE (padrão) exclui as internações por parto pelo campo diagnóstico, independente do procedimento. São excluídas as internações com os seguintes diagnósticos (CID-10):
#'  \itemize{
#'   \item{O80} Parto único espontâneo
#'   \item{O81} Parto único por fórceps ou vácuo-extrator
#'   \item{O82} Parto único por cesariana
#'   \item{O83} Outros tipos de parto único assistido
#'   \item{O84} Parto múltiplo
#'  }
#' }
#'
#' É retornada uma mensagem informando o número de registros lidos, o número e proporção de registros excluídos e o total de registros importados.
#'
#' \item{\code{sihsus}  }{ A própria função define este argumento como \code{FALSE} quando "x" (o alvo da função) é um fator. Quando o alvo é um objeto da clase \code{data frame} sem a estrutura dos arquivos da AIH, a variável com os códigos da CID-10 deve ser trabalhada como um \code{factor}. }
#' }
#'
#' @return
#' A função tem diferentes possibilidades de retorno, segundo a estrutura dos dados lidos e as opções de leitura:
#' \itemize{
#'  \item{ Se for um arquivo ou \code{data frame} com a estrutura dos arquivos da AIH:
#'    \itemize{
#'      \item um \code{data frame} com as variáveis nº da AIH, município de residência, município de internação, sexo, data de nascimento, idade em anos completos, faixa etária detalhada, faixa etária quinquenal, data da internação, data da saída, procedimento realizado, cid, CSAP, grupo csap, CEP e CNES do hospital
#'        \itemize{
#'          \item Nesse caso, o banco resultante tem um argumento "resumo" com o resumo da importação de dados, segundo as opções de seleção
#'          \item{ Se os argumentos \code{grupo}, \code{cep} ou \code{cnes} forem definidos como \code{FALSE}, o banco é construído sem essas variáveis}
#'      }}}
#'    \item{Se um fator ou data frame sem a estrutura dos arquivos da AIH:}
#'  \itemize{
#'  \item{Se \code{grupos = TRUE}: }{ um banco de dados com as variáveis \code{csap} (sim ou não), \code{grupo} (subgrupo CSAP) e \code{cid} (código da CID-10)};
#'  \item{Se \code{factor} e \code{grupos = FALSE}: }{ um fator com as observações classificadas como CSAP ou não-CSAP}.    }
#'  }
#'
#' @note
#' A função \code{\link{read.dbf}}, do pacote \code{foreign}, não lê arquivos em formato DBF em que uma das variáveis tenha todos os valores ausentes ('missings'); essas variáveis devem ser excluídas antes da leitura do arquivo pela função \code{csapAIH} ou mesmo pelas função \code{\link{read.dbf}}.
#'
#' @references
#' Alfradique et al., Internações por Condições Sensíveis à Atenção Primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cad Saúde Pública 25(6):1337-49.
#'
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' __________. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2010. Manual técnico operacional do Sistema de Informação Hospitalar: orientações técnicas. Versão 01.2013. Ministério da Saúde: Brasília, 2013.
#'
#' @keywords CSAP; AIH-SUS; package
#'
#' @seealso
#' \code{\link{read.table}}, \code{\link{read.csv}}, \code{\link[read.dbc]{read.dbc}},
#' \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}}, \code{\link{nomesgruposCSAP}}
#'
#' @examples
#' ## Uma lista de códigos da CID-10:
#' ##---------------------------------
#' cids <- c("I200", "K929", "T16", "I509", "I10",  "I509", "S068")
#' teste1 <- csapAIH(as.factor(cids)) ; class(teste1) ; teste1
#' teste2 <- csapAIH(as.factor(cids),  grupo=FALSE) ; class(teste2) ; teste2
#'
#' ## Um 'arquivo da AIH' armazenado no diretório de trabalho:
#' ##---------------------------------------------------------
#' \dontrun{
#'  teste3.dbf <- csapAIH("RDRS1301.dbf")
#'  str(teste3.dbf)
#'  teste3.dbc <- csapAIH("RDRS1301.dbc")
#'  str(teste3.dbc)
#' }
#'
#' ## Um 'data.frame' com a estrutura dos 'arquivos da AIH':
#' ##-------------------------------------------------------
#' data("aih100")
#' str(aih100)
#' teste4 <- csapAIH(aih100)
#' str(teste4)
#'
#' ## Uma base de dados com a estrutura dos 'arquivos da AIH'
#' ## mas sem as variáveis CEP ou CNES:
#' ##--------------------------------------------------------
#' aih <- subset(aih100, select = -c(CEP, CNES))
#' teste5 <- csapAIH(aih, cep = FALSE, cnes = FALSE)
#' str(teste5)
#'
#' ## Para uma base de dados sem a estrutura dos BD-SIH/SUS, apenas trabalhe
#' ## a variável com os CIDs, como nos primeiros exemplos (teste1 e teste2)
#' ##-----------------------------------------------------------------------
#' ## teste6 <- csapAIH(BaseDeDados$VariavelcomCID)
#'
#' @export
#'
csapAIH <- function(x, grupos=TRUE, sihsus=TRUE, procobst.rm=TRUE, parto.rm=TRUE, longa.rm=TRUE, cep=TRUE, cnes=TRUE, arquivo=TRUE, sep, cid = NULL, ...)
  {
    # Lego data ===================
    ## Preparar os dados
    ##
    if (class(x)=='factor') {
      cid <- x
      arquivo <- FALSE
      sihsus <- FALSE
    }
    if (class(x)=='data.frame') arquivo <- FALSE
    if (sihsus == FALSE) {
      if (class(x)=='data.frame') {
        cid <- x[,deparse(substitute(cid))]
        juntar <- x
        }
      # if (class(x)!='data.frame') { cid <- x }
      # cid = as.character(cid)
    }
    #
    # Leitura do arquivo de dados
    #
    if (arquivo==TRUE) {
      if (grepl('dbf', x, ignore.case=TRUE)==TRUE) {
        x <- foreign::read.dbf(x, as.is=TRUE, ...)
      } else
        if (grepl('dbc', x, ignore.case=TRUE)==TRUE) {
          x <- read.dbc::read.dbc(x, ...)
          } else
            if (grepl('csv', x, ignore.case=T)==T) {
              if (sep == ';') x = utils::read.csv2(x, colClasses=c('PROC_REA'='character'), ...)
              if (sep == ',') x = utils::read.csv(x, colClasses=c('PROC_REA'='character'), ...)
            }
=======
csapAIH <-
function(x, grupos=TRUE, sihsus=TRUE, x.procobst=TRUE, longa=FALSE, cep=TRUE, cnes=TRUE,
         arquivo=TRUE, sep, ...) 
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
      if (grepl('dbf', x, ignore.case=TRUE)==TRUE) { 
        x <- foreign::read.dbf(x, as.is=TRUE, ...) 
      }
      else
        if (grepl('csv', x, ignore.case=T)==T) {
          if (sep == ';') x = read.csv2(x, colClasses=c('PROC_REA'='character'), ...) 
          if (sep == ',') x = read.csv(x, colClasses=c('PROC_REA'='character'), ...)
        }
>>>>>>> 29c50c2708d01f4a9cb0381092092311f11ae1c9
      else
        warning('------------------------------------------------------\n
                  ERRO DE LEITURA em ', deparse(substitute(x)), ' \n
                  O objeto deve ser da classe "factor" ou "data.frame", \n
<<<<<<< HEAD
                  ou um arquivo no formato .dbc, .dbf ou .csv. \n
                  -----------------------------------------------------\n ')
}
    # Total de registros importados
      nlidos <- nrow(x)
      if (is.data.frame(x)) {
        message(paste(c("Importados ",
                        suppressWarnings(formatC(nlidos <- nrow(x), big.mark = ".")),
                        " registros.")))
        importados <- paste(c("Importados",
                              nlidos,
                              100,
                              "registros."))
      }

    # Garantir o trabalho com operadores mais tarde, no CID
    if (sihsus==FALSE) cid=as.character(cid)
      #--------------------------------------------------------------------------#
      #   Organização e seleção de variáveis de bancos com estrutura do SIHSUS   #
      #----------------------------------------------------------------------#
      # munus enim nuntius ad deletionem per modum obstetrica ===========
      #
      freqs <- function(tamini, tamfin, digits = 1, tipo = "proc") {
        fr <- tamini - tamfin
        pfr <- round(fr / tamini * 100, digits)
        fr.form <- suppressWarnings(format(fr, big.mark = "."))
        pfr.form <- format(pfr, decimal.mark = ",")
        if (tipo == "proc") {
          excluidos.obst <- c("Exclu\u00EDdos", fr, pfr, "registros de procedimentos obst\u00E9tricos.")
          message( c("Exclu\u00EDdos ", fr.form, " (", pfr.form, "\u0025) "), "registros de procedimentos obst\u00E9tricos." )
        } else if (tipo == "diag") {
          excluidos.obst <- c("Exclu\u00EDdos", fr, pfr, "registros de parto.")
          message(c("Exclu\u00EDdos ", fr.form, " (", pfr.form, "\u0025) "), "registros de parto.")
        }
        excluidos.obst
      }
      # ----------------------- fim da função
      #
      if (sihsus==TRUE) {
        #   Exclusão dos procedimentos obstétricos
        #
        #   0310010012 ASSISTENCIA AO PARTO S/ DISTOCIA
        #   0310010020 ATEND AO RECEM-NASCIDO EM SALA DE PARTO
        #   0310010039 PARTO NORMAL
        #   0310010047 PARTO NORMAL EM GESTACAO DE ALTO RISCO
        #   0411010018 DESCOLAMENTO MANUAL DE PLACENTA
        #   0411010026 PARTO CESARIANO EM GESTACAO ALTO RISCO
        #   0411010034 PARTO CESARIANO
        #   0411010042 PARTO CESARIANO C/ LAQUEADURA TUBARIA
        #   0411020013 CURETAGEM POS-ABORTAMENTO / PUERPERAL
        #   0411020021 EMBRIOTOMIA
        procobst <- c('0310010012', '0310010020', '0310010039', '0310010047', '0411010018', '0411010026',
                      '0411010034', '0411010042', '0411020013', '0411020021')
        tamini <- nrow(x)
        x$DIAG_PRINC <- as.character(x$DIAG_PRINC)
        if (procobst.rm == TRUE) {
          if (parto.rm == TRUE) {
            x <- subset(x, subset = x$PROC_REA %in% procobst==FALSE)
            x <- subset(x, subset = x$DIAG_PRINC < "O80" | x$DIAG_PRINC >= "O85")
            x <- droplevels(x)
          } else if (parto.rm == FALSE) {
            x <- subset(x, subset = x$PROC_REA %in% procobst==FALSE, drop = TRUE)
          }
          excluidos.obst <- freqs(nlidos, nrow(x))
        } else if (procobst.rm == FALSE) {
          if (parto.rm == TRUE) {
            x <- subset(x, subset = x$DIAG_PRINC < "O80" | x$DIAG_PRINC >= "O85", drop = TRUE)
            excluidos.obst <- freqs(nlidos, nrow(x), tipo = "diag")
          }
        }
        #
        # longa permanência ----
        # Exclusão das AIHs de longa permanência
        #
        if (longa.rm == TRUE) {
          fr <- table(x$IDENT)[2]
          pfr <- round((fr/nlidos)*100,1)
          # pfr <- round(prop.table(table(x$IDENT))[2]*100,1)
          fr.form <- suppressWarnings(format(fr, big.mark = "."))
          pfr.form <- format(pfr, decimal.mark = ",")
          x <- subset(x, x$IDENT==1)
          excluidos.lp <- c("Exclu\u00EDdos", fr, pfr,
                            "registros de AIH de longa perman\u00EAncia.")
          message("Exclu\u00EDdos ", fr.form, " (", pfr.form, "\u0025) registros de AIH de longa perman\u00EAncia.")
        }
        #   Construção da tabela com o resumo das importações
        #   (isso tem de melhorar, tem código repetido e mistura
        #   mensagem com valor, não sei se é legal!)
        #
        exportados <- paste(c("Exportados", nrow(x), pexportados <- round((1-(nlidos-nrow(x))/nlidos)*100,1), "registros."))
        message(paste(c("Exportados ", suppressWarnings(formatC(length(x[,1]), big.mark = ".")), " (", formatC(pexportados, decimal.mark = ","), "\u0025) registros.")))
        resumo <- rbind(importados, exportados)
        colnames(resumo) = c("acao", "freq", "perc", "objeto")
        if (longa.rm == TRUE) {
          if (exists('excluidos.obst')) {
            resumo <- rbind(resumo[1,],
                            excluidos.obst,
                            excluidos.lp,
                            resumo[2,])
          } else
            resumo <- rbind(resumo[1,],
                            excluidos.lp,
                            resumo[2,])
        } else if (longa.rm == FALSE) {
          if (exists('excluidos.obst')) {
            resumo <- rbind(resumo[1,],
                            suppressWarnings(excluidos.obst),
                            resumo[2,])
          } else
            resumo <- resumo
        }
        rownames(resumo) <- NULL
        resumo <- as.data.frame(resumo)
        resumo$freq <- as.numeric(as.character(resumo$freq))
        resumo$perc <- as.numeric(as.character(resumo$perc))
        #
        # banco final ----
        # Criar as variáveis do banco final
        #
        cid <- as.character(x$DIAG_PRINC)
        nasc <- as.Date(format(x$NASC), format="%Y%m%d")
        data.inter <- as.Date(format(x$DT_INTER), format="%Y%m%d")
        data.saida <- as.Date(format(x$DT_SAIDA), format="%Y%m%d")
        COD_IDADE <- as.character(x$COD_IDADE)
        idade <- csapAIH::idadeSUS(x)["idade"]
        fxetar <- csapAIH::idadeSUS(x)["fxetar.det"]
        fxetar5 <- csapAIH::idadeSUS(x)["fxetar5"]
=======
                  ou um arquivo no formato .dbf ou .csv (ou DBF, CSV). \n
                  -----------------------------------------------------\n ')
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
>>>>>>> 29c50c2708d01f4a9cb0381092092311f11ae1c9
        munres   <- x$MUNIC_RES
        munint   <- x$MUNIC_MOV
        sexo     <- factor(x$SEXO, levels=c(1,3), labels=c("masc", "fem"))
        n.aih    <- as.character(x$N_AIH)
        proc.rea <- x$PROC_REA
        proc.obst <- ifelse(proc.rea %in% procobst, 1, 2)
<<<<<<< HEAD
        #, labels=c('sim', 'nao'))
#     Hmisc::label(munres)   <- 'Munic\u00EDpio de resid\u00EAncia'
#     Hmisc::label(munint)   <- 'Munic\u00EDpio de interna\u00E7\u00E3o'
#     Hmisc::label(n.aih)    <- 'N\u00B0 da AIH'
#     Hmisc::label(proc.rea) <- 'Procedimento realizado'
#     Hmisc::label(nasc)     <- 'Data de nascimento'
#     Hmisc::label(fxetar)   <- 'Faixa et\u00E1ria detalhada'
#     Hmisc::label(fxetar5)  <- 'Faixa et\u00E1ria quinquenal'
#   if(procobst.rm==TRUE) Hmisc::label(proc.obst) <- 'Procedimento obst\u00E9trico'
#
      }
      #
      ## Criar as variáveis 'CSAP' e 'grupo' ====
      ##
      # Definir missings no cid:
      cid[is.na(cid)] <- NA
      cid[cid==""] <- NA
      #
      #  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA ----
      #               Portaria MS nº 221, de 17 de abril de 2008
      #            --- --- --- --- --- --- --- --- --- --- --- ---
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

      grupo <- ifelse(g01==1, "g01", ifelse(g02==1, "g02", ifelse(g03==1, "g03", ifelse(g04==1, "g04",
                                                                                        ifelse(g05==1, "g05", ifelse(g06==1, "g06", ifelse(g07==1, "g07", ifelse(g08==1, "g08",
                                                                                                                                                                 ifelse(g09==1, "g09", ifelse(g10==1, "g10", ifelse(g11==1, "g11", ifelse(g12==1, "g12",
                                                                                                                                                                                                                                          ifelse(g13==1, "g13", ifelse(g14==1, "g14", ifelse(g15==1, "g15", ifelse(g16==1, "g16",
                                                                                                                                                                                                                                                                                                                   ifelse(g17==1, "g17", ifelse(g18==1, "g18", ifelse(g19==1, "g19", "n\u00E3o-CSAP")))))))))))))))))))

      ### Garantir todos os grupos de causa, mesmo com frequência zero, como "level" do fator.
      niveis = c(paste0("g0", 1:9), paste0("g1", 0:9), "n\u00E3o-CSAP")
      grupo = factor(grupo, levels = niveis)

      ############################-
      ### Montar o objeto final ----
      ############################-
      ## Se for uma base do SIH/SUS:
      if (sihsus==TRUE) {
        banco <- data.frame(n.aih, munres, munint,
                            sexo, nasc, idade, fxetar, fxetar5,
                            csap, grupo, cid, proc.rea,
                            data.inter, data.saida)
        attr(banco$n.aih, which = "label") <- "No. da AIH"
        attr(banco$munres, which = "label") <- "Municipio de residencia"
        attr(banco$munint, which = "label") <- "Municipio de internacao"
        attr(banco$sexo, which = "label") <- "Sexo"
        attr(banco$nasc, which = "label") <- "Data de nascimento"
        attr(banco$idade, which = "label") <- "Idade"
        attr(banco$fxetar.det, which = "label") <- "Faixa etaria detalhada"
        attr(banco$fxetar5, which = "label") <- "Faixa etaria quinquenal"
        attr(banco$csap, which = "label") <- "CSAP"
        attr(banco$grupo, which = "label") <- "Grupo de causa CSAP"
        attr(banco$cid, which = "label") <- "CID-10"
        banco$cid <- as.character(banco$cid)
        attr(banco$proc.rea, which = "label") <- "Procedimento realizado"
        attr(banco$data.inter, which = "label") <- "Data de internacao"
        attr(banco$data.saida, which = "label") <- "Data de saida"
        attr(banco, which = "resumo") <- resumo
        if (cep==TRUE) {
          banco$cep <- x$CEP
          # Hmisc::label(banco$cep) <- 'C\u00F3digo de Endere\u00E7amento Postal'
          attr(banco$cep, which = "label") <- "Codigo de Enderecamento Postal"
        }
        if (cnes==TRUE) {
          banco$cnes <- x$CNES
          # Hmisc::label(banco$cnes) <- 'N\u00B0 do hospital no CNES'
          attr(banco$cnes, which = "label") <- "No. do hospital no CNES"
        }
        if (procobst.rm==FALSE )  {
          banco$proc.obst <- proc.obst
          attr(banco$proc.obst, which = "label") <- "Procedimento obstetrico"
        }
        if (grupos==FALSE ) {
          banco <- subset(banco, select = - grupo)
          attr(banco, which = "resumo") <- resumo
          attr(banco, which = "excluidos.obst") <- excluidos.obst
        }
      }
      ## Se não for uma base do SIH/SUS:
      if ( sihsus == FALSE & grupos == TRUE ) { banco <- data.frame(csap, grupo, cid) }
      if ( sihsus == FALSE & grupos == FALSE ) {
        banco <- csap
        class(banco) <- 'factor'
      }
      if (class(x)=='data.frame' & sihsus == FALSE) {
        banco <- cbind(juntar, banco)
      }

      return(banco)
=======
                           #, labels=c('sim', 'nao'))  
#         Hmisc::label(munres)   <- 'Munic\u00EDpio de resid\u00EAncia'
#         Hmisc::label(munint)   <- 'Munic\u00EDpio de interna\u00E7\u00E3o'
#         Hmisc::label(n.aih)    <- 'N\u00B0 da AIH'
#         Hmisc::label(proc.rea) <- 'Procedimento realizado'
#         Hmisc::label(nasc)     <- 'Data de nascimento'
#         Hmisc::label(fxetar)   <- 'Faixa et\u00E1ria detalhada'
#         Hmisc::label(fxetar5)  <- 'Faixa et\u00E1ria quinquenal'
#         if(x.procobst==TRUE) Hmisc::label(proc.obst) <- 'Procedimento obst\u00E9trico'
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

    grupo <- ifelse(g01==1, "g01", ifelse(g02==1, "g02", ifelse(g03==1, "g03", ifelse(g04==1, "g04", 
             ifelse(g05==1, "g05", ifelse(g06==1, "g06", ifelse(g07==1, "g07", ifelse(g08==1, "g08", 
             ifelse(g09==1, "g09", ifelse(g10==1, "g10", ifelse(g11==1, "g11", ifelse(g12==1, "g12",
             ifelse(g13==1, "g13", ifelse(g14==1, "g14", ifelse(g15==1, "g15", ifelse(g16==1, "g16", 
             ifelse(g17==1, "g17", ifelse(g18==1, "g18", ifelse(g19==1, "g19", "n\u00E3o-CSAP")))))))))))))))))))

############################
### Montar o objeto final
############################
## Se for uma base do SIH/SUS:
    if (sihsus==TRUE) {
      banco <- data.frame(n.aih, munres, munint, sexo, nasc, idade, fxetar, fxetar5, 
                          csap, grupo, cid, proc.rea, data.inter, data.saida) 
         attr(banco$n.aih, which = "label") <- "No. da AIH"
         attr(banco$munres, which = "label") <- "Municipio de residencia"
         attr(banco$munint, which = "label") <- "Municipio de internacao"
         attr(banco$sexo, which = "label") <- "Sexo"
         attr(banco$nasc, which = "label") <- "Data de nascimento"
         attr(banco$idade, which = "label") <- "Idade"
         attr(banco$fxetar, which = "label") <- "Faixa etaria detalhada"
         attr(banco$fxetar5, which = "label") <- "Faixa etaria quinquenal"
         attr(banco$csap, which = "label") <- "CSAP"
         attr(banco$grupo, which = "label") <- "Grupo de causa CSAP"
         attr(banco$cid, which = "label") <- "CID-10"
         attr(banco$proc.rea, which = "label") <- "Procedimento realizado"
         attr(banco$data.inter, which = "label") <- "Data de internacao"
         attr(banco$data.saida, which = "label") <- "Data de saida"
      if (cep==TRUE) {  
        banco$cep <- x$CEP 
        # Hmisc::label(banco$cep) <- 'C\u00F3digo de Endere\u00E7amento Postal'
         attr(banco$cep, which = "label") <- "Codigo de Enderecamento Postal"
        }
      if (cnes==TRUE) {
        banco$cnes <- x$CNES 
        # Hmisc::label(banco$cnes) <- 'N\u00B0 do hospital no CNES'
         attr(banco$cnes, which = "label") <- "No. do hospital no CNES"
      }
      if (x.procobst==FALSE )  {
        banco$proc.obst <- proc.obst
         attr(banco$proc.obst, which = "label") <- "Procedimento obstetrico"
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
>>>>>>> 29c50c2708d01f4a9cb0381092092311f11ae1c9
}
