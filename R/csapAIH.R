#' Classificar Condições Sensíveis à Atenção Primária
#' @aliases csapAIH
#'
#' @description Classifica códigos da 10ª Revisão da Classificação Internacional de Doenças (CID-10) segundo a Lista Brasileira de Internação por Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos "arquivos da AIH" (RD??????.DBC; BD-SIH/SUS).
#'
#' @param x alvo da função: um arquivo, banco de dados ou vetor com códigos da CID-10 (ver \code{detalhes});
#' @param lista Lista de causas a ser considerada (v. detalhes); pode ser \code{"MS"} (padrão) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.
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
#' \item{lista} A Lista Brasileira de ICSAP publicada pelo Ministério da Saúde (Brasil, 2008) se diferencia da lista publicada pelxs construtorxs da lista (Alfradique et al., 2009), em um único aspecto: a Portaria Ministerial uniu os dois primeiros grupos de causa da lista publicada por Alfradique et al. -- doenças evitáveis por vacinação e doenças evitáveis por outros meios (sífilis, tuberculose e febre reumática). Não há diferença no total de diagnósticos considerados, ou na distribuição dos diagnósticos entre os demais grupos.
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
#' Alfradique ME et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6): 1337-1349. https://doi.org/10.1590/S0102-311X2009000600016.
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
#' #
#' # Se o vetor for da classe 'character', deve-se transformá-lo em fator ou
#' # mudar o argumento 'arquivo' para 'FALSE':
#' # teste1 <- csapAIH(cids) # Erro
#' teste1 <- csapAIH(factor(cids)) ; class(teste1) ; teste1
#' teste1 <- csapAIH(cids, arquivo=FALSE) ; class(teste1) ; teste1
#' teste2 <- csapAIH(cids, arquivo=FALSE,  grupo=FALSE) ; class(teste2) ; teste2
#' teste2 <- csapAIH(factor(cids), grupo=FALSE) ; class(teste2) ; teste2
#' #

#'
#' ## Um 'arquivo da AIH' armazenado no diretório de trabalho:
#' ##---------------------------------------------------------
#' \dontrun{
#'  teste3.dbf <- csapAIH("RDRS1201.dbf")
#'  str(teste3.dbf)
#'  teste4.dbc <- csapAIH("data-raw/RDRS1801.dbc")
#'  str(teste4.dbc)
#' }
#'
#' ## Um 'data.frame' com a estrutura dos 'arquivos da AIH':
#' ##-------------------------------------------------------
#' data("aih500")
#' str(aih500)
#' teste5 <- csapAIH(aih500)
#' str(teste5)
#' levels(teste5$grupo)
#'
#' # Com a lista de 20 grupos de causa (Alfradique et al.)
#' teste6 <- csapAIH(aih500, lista = "Alfradique")
#' str(teste6)
#' levels(teste6$grupo)
#'
#' ## Uma base de dados com a estrutura dos "arquivos da AIH"
#' ## mas sem as variáveis CEP ou CNES:
#' ##--------------------------------------------------------
#' aih <- subset(aih500, select = -c(CEP, CNES))
#' teste7 <- csapAIH(aih, cep = FALSE, cnes = FALSE)
#' str(teste7)
#'
#' ## Uma base de dados sem a estrutura dos arquivos RD*.dbc:
#' ##--------------------------------------------------------
#' teste8 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10)
#' str(teste8)
#' teste9 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10, parto.rm = FALSE)
#' str(teste9)
#'
#' ## Uma base de dados com a estrutura dos "arquivos da AIH" mantendo
#' ## todas suas variáveis
#' ##-----------------------------------------------------------------
#' ## Trate como se não fosse um arquivo da AIH e apenas acrescente
#' ## a classificação ao banco:
#' teste10 <- csapAIH(aih500, sihsus = FALSE, cid = DIAG_PRINC)
#'
#' ## Acrescentar variáveis da AIH ao banco com as CSAP
#' ##---------------------------------------------------------
#' ## É necessário unir o banco da AIH com as variáveis de interesse
#' ## ao banco resultante da função 'csapAIH':
#' vars <- c('N_AIH', 'RACA_COR', 'INSTRU')
#' teste11 <- csapAIH(aih500)
#' teste11 <- merge(teste11, aih500[, vars], by.x = "n.aih", by.y = "N_AIH")
#' names(teste11)
#' ## Ou, usando o encadeamento ("piping") de funções,
#' teste12 <- csapAIH(aih500) |>
#' merge(aih100[, vars], by.x = "n.aih", by.y = "N_AIH")
#' names(teste12)
#'
#' @importFrom dplyr is.tbl
#'
#' @export
#'
csapAIH <- function(x, lista = "MS", grupos=TRUE, sihsus=TRUE, procobst.rm=TRUE, parto.rm=TRUE, longa.rm=TRUE, cep=TRUE, cnes=TRUE, arquivo=TRUE, sep, cid = NULL, ...)
  {
    # Preparar os dados
    #
    if (is.factor(x)) {
      # x <- as.character(x)
      cid <- as.character(x)
      arquivo     <- FALSE
      sihsus      <- FALSE
      procobst.rm <- FALSE
      parto.rm    <- FALSE
      longa.rm    <- FALSE
      cep         <- FALSE
      cnes        <- FALSE
    }
    if (is.character(x) & arquivo == FALSE) {
      cid <- x
      sihsus      <- FALSE
      procobst.rm <- FALSE
      parto.rm    <- FALSE
      longa.rm    <- FALSE
      cep         <- FALSE
      cnes        <- FALSE
    }
    if (is.data.frame(x)) {
      arquivo <- FALSE
      if(is.tbl(x)) x <- as.data.frame(x)
    }
    if (sihsus == FALSE) {
      if (is.data.frame(x)) {
        cid <- x[,deparse(substitute(cid))]
        # cid <- x[,cid]
        juntar <- x
        }
    }
    #
    # Leitura do arquivo de dados
    #
    if (arquivo == TRUE) {
      if (grepl('dbf', x, ignore.case = TRUE) == TRUE) {
        x <- foreign::read.dbf(x, as.is = TRUE, ...)
      } else
        if (grepl('dbc', x, ignore.case = TRUE) == TRUE) {
          x <- read.dbc::read.dbc(x, ...)
          } else
            if (grepl('csv', x, ignore.case=T)==T) {
              if (sep == ';') x = utils::read.csv2(x, colClasses=c('PROC_REA'='character'), ...)
              if (sep == ',') x = utils::read.csv(x, colClasses=c('PROC_REA'='character'), ...)
            }
      else
        warning('------------------------------------------------------\n
                  ERRO DE LEITURA em ', deparse(substitute(x)), ' \n
                  O objeto deve ser da classe "factor" ou "data.frame", \n
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
      if (sihsus==FALSE) {
        if(!is.character(cid)) cid <- as.character(cid)
        # if(is.labelled(cid)) cid <- zap_labels(cid)
      }

      #-------------------------------------------------------------------------#
      #   Organização e seleção de variáveis de bancos com estrutura do SIHSUS  #
      #-------------------------------------------------------------------------#
        # Contagem de registros excluídos ---- início da função
      #
      freqs <- function(tamini, tamfin, digits = 1, tipo = "proc") {
        fr <- tamini - tamfin
        pfr <- round(fr / tamini * 100, digits)
        fr.form <- suppressWarnings(format(fr, big.mark = "."))
        pfr.form <- format(pfr, decimal.mark = ",")
        if (tipo == "proc") {
          excluidos.obst <- c("Exclu\u00EDdos \t",
                              fr, pfr,
                              "registros de procedimentos obst\u00E9tricos.")
          message( c("Exclu\u00EDdos ",
                     fr.form, " (", pfr.form, "\u0025) "),
                   "registros de procedimentos obst\u00E9tricos." )
        } else if (tipo == "diag") {
          excluidos.obst <- c("Exclu\u00EDdos",
                              fr, pfr,
                              "registros de parto.")
          message(c("Exclu\u00EDdos ",
                    fr.form, " (", pfr.form, "\u0025) "),
                  "registros de parto.")
        }
        excluidos.obst
      }
      # ----------------------- fim da função
      #
      if (sihsus==TRUE) {
        tamini <- nrow(x)
        x$DIAG_PRINC <- as.character(x$DIAG_PRINC)
        if (procobst.rm == TRUE) {
          x <- suppressMessages( proc.obst(x) )
          if (parto.rm == TRUE) {
            x <- subset(x, subset = x$DIAG_PRINC < "O80" | x$DIAG_PRINC >= "O85")
          }
          x <- droplevels(x)
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
          excluidos.lp <- c("Exclu\u00EDdos \t", fr, pfr,
                            "registros de AIH de longa perman\u00EAncia.")
          message("Exclu\u00EDdos ", fr.form, " (", pfr.form, "\u0025) registros de AIH de longa perman\u00EAncia.")
        }
        #   Construção da tabela com o resumo das importações
        #   (isso tem de melhorar, tem código repetido e mistura
        #   mensagem com valor, não sei se é legal!)
        #
        exportados <- paste(c("Exportados",
                              nrow(x),
                              pexportados <- round((1-(nlidos-nrow(x))/nlidos)*100,1), "registros."))
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
        munres   <- x$MUNIC_RES
        munint   <- x$MUNIC_MOV
        sexo     <- factor(x$SEXO, levels=c(1,3), labels=c("masc", "fem"))
        n.aih    <- as.character(x$N_AIH)
        proc.rea <- x$PROC_REA
        # proc.obst <- ifelse(proc.rea %in% procobst, 1, 2)
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
      ################################################################################
      #  LISTA BRASILEIRA DE INTERNAÇÕES POR CONDIÇÕES SENSÍVEIS À ATENÇÃO PRIMÁRIA  #
      ################################################################################
      if(lista == "MS") {
        #  Portaria MS nº 221, de 17 de abril de 2008
        csap  <- listaBRMS(cid)[,'csap']
        grupo <- listaBRMS(cid)[,'grupo']
      } else if (lista == "Alfradique") {
        # Alfradique et al.
        csap  <- listaBRAlfradique(cid)[,'csap']
        grupo <- listaBRAlfradique(cid)[,'grupo']
      }

      ###########################
      ### Montar o objeto final #
      ###########################
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

      if ( sihsus == FALSE & grupos == TRUE ) {
        banco <- data.frame(cid, csap, grupo)
      }
      if ( sihsus == FALSE & grupos == FALSE ) {
        banco <- data.frame(cid, csap)
      }

      if (is.data.frame(x) & sihsus == FALSE) {
        if (grupos == FALSE) {
          banco <- data.frame(juntar, csap)
        }
        else if (grupos == TRUE) {
          banco <- data.frame(juntar, csap, grupo)
        }
      }

      ## Exclusão de partos em bancos sem a estrutura do SIH/SUS
      if (sihsus == FALSE) {
        if(parto.rm == TRUE) {
          nlidos <- nrow(banco)
          banco <- subset(banco, subset = cid < "O80" | cid >= "O85", drop = T)
          pexcluidos <- round((1-(nrow(banco)/nlidos))*100,1)
          message(paste0(c("Exclu\u00EDdos ",
                           suppressWarnings(formatC(nlidos-nrow(banco),
                                                    big.mark = ".")),
                           " registros de parto",
                           " (", formatC(pexcluidos, decimal.mark = ","), "\u0025 do total).")))
        }
      }

      rownames(banco) <-  NULL

      if(!is.data.frame(x) & sihsus == FALSE & grupos == FALSE) {
        banco <- banco[['csap']]
        }

      return(banco)
}
