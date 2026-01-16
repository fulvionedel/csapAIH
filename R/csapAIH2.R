#' Classificar Condições Sensíveis à Atenção Primária
#' @aliases csapAIH2
#'
#' @description Classifica códigos da 10ª Revisão da Classificação Internacional de Doenças (CID-10) segundo a Lista Brasileira de Internação por Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos "arquivos da AIH" (RD??????.DBC; BD-SIH/SUS).
#' Função em teste. Amplia o uso de \code{\link{csapAIH}} permitindo a seleção de variáveis da AIH.
#'
#' @param x alvo da função: um arquivo, banco de dados ou vetor com códigos da CID-10 (ver \code{detalhes});
#' @param lista Lista de causas a ser considerada (v. detalhes); pode ser \code{"MS"} (padrão) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.
#' @param grupos argumento lógico, obrigatório; \code{TRUE} (padrão) indica que as internações serão classificadas também em grupos de causas CSAP;
#' @param sihsus argumento lógico, obrigatório se \code{x} for um arquivo; \code{TRUE} (padrão) indica que o arquivo ou banco de dados a ser tabulado tem minimamente os seguintes campos dos arquivos da AIH:
#'   \itemize{
#'     \item DIAG_PRINC: diagnóstico principal da internação;
#'     \item NASC: data de nascimento;
#'     \item DT_INTER: data da internação;
#'     \item DT_SAIDA: data da alta hospitalar;
#'     \item COD_IDADE: código indicando a faixa etária a que se refere o valor registrado no campo idade;
#'     \item IDADE: idade (tempo de vida acumulado) do paciente, na unidade indicada no campo COD_IDADE;
#'     \item MUNIC_RES: município de residência do paciente;
#'     \item MUNIC_MOV: município de internação do paciente;
#'     \item SEXO: sexo do paciente;
#'     \item N_AIH: número da AIH;
#'     \item PROC_REA: procedimento realizado, segundo a tabela do SIH/SUS.
#'     }
#' @param procobst.rm argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por procedimento obstétrico (ver detalhes em \code{\link{leraih}});
#' @param parto.rm argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por parto (ver detalhes em \code{\link{leraih}});
#' @param longa.rm argumento lógico; \code{TRUE} (padrão) exclui as AIH de longa permanência (AIH tipo 5), retornando uma mensagem com o número e proporção de registros excluídos e o total de registros importados; argumento válido apenas se \code{sihsus=TRUE} (ver detalhes em \code{\link{leraih}});
#' @param arquivo argumento lógico, obrigatório; \code{TRUE} (padrão) indica que o alvo da função (\code{x}) é um arquivo; \code{FALSE} indica que \code{x} é um objeto no espaço de trabalho; é automaticamente marcado como \code{FALSE} quando \code{x} é um \code{factor} ou \code{data frame}; deve ser definido pelo usuário como \code{FALSE} apenas quando \code{x} contiver em seu nome as sequências "dbc", "dbf" ou "csv" sem que isso seja a extensão do arquivo; apenas arquivos com esses formatos podem ser lidos;
#' @param sep usado para a leitura de arquivos da AIH em formato CSV; pode ser ";" para arquivos separados por ponto-e-vírgula e com vírgula como separador decimal, ou "," para arquivos separados por vírgula e com ponto como separador decimal;
#' @param cid identifica a varivável contendo os códigos da CID-10, em bancos de dados sem a estrutura do SIHSUS; argumento obrigatório nesses casos;
#' @param vars lista de variáveis da AIH a serem selecionadas (ver detalhes em \code{\link{leraih}});
#' @param ... permite a inclusão de argumentos das funções \code{\link{read.table}} e suas derivadas e de \code{\link{leraih}}.
#'
#' @details
#'  \itemize{
#'   \item x pode ser:
#'    \enumerate{
#'     \item um arquivo de dados armazenado num diretório;
#'     \item um banco de dados, ou um vetor da classe \code{factor} presente como objeto no espaço de trabalho do R, em que uma das variáveis, ou o vetor, contenha códigos da CID-10.
#'    }
#'
#' Se for um arquivo, o nome deve ser escrito entre aspas e com a extensão do arquivo (DBC, DBF ou CSV, em minúsculas ou maiúsculas). Se não estiver no diretório de trabalho ativo, seu nome deve ser precedido pelo caminho (path) até o diretório de armazenamento. Se estiver em outro formato, podem-se usar os argumentos da função \code{\link{read.table}} para leitura dos dados.
#'
#' Se a função for dirigida a um objeto no espaço de trabalho da classe \code{factor} ou \code{data.frame}, estes também são reconhecidos e o comando é o mesmo: \code{csapAIH(x)}. Se o objeto for de outra classe, como \code{character} ou \code{matrix}, é necessário definir o argumento "arquivo" como FALSE: \code{csapAIH(x, arquivo = FALSE)}, ou, para vetores isolados, defini-lo como fator: \code{csapAIH(as.factor(x))}.
#'
#' \item \code{lista} A Lista Brasileira de ICSAP publicada pelo Ministério da Saúde (Brasil, 2008) se diferencia da lista publicada pelxs construtorxs da lista (Alfradique et al., 2009), em um único aspecto: a Portaria Ministerial uniu os dois primeiros grupos de causa da lista publicada por Alfradique et al. -- doenças evitáveis por vacinação e doenças evitáveis por outros meios (sífilis, tuberculose e febre reumática). Não há diferença no total de diagnósticos considerados, ou na distribuição dos diagnósticos entre os demais grupos.
#'
#' \item \code{procbst.rm} TRUE (padrão) exclui as internações por procedimentos relacionados ao parto ou abortamento. São excluídas as internações pelos seguintes procedimentos obstétricos, independente do diagnóstico principal de internação (variável `DIAGPRINC`):
#'   \itemize{
#'    \item 0310010012  ASSISTENCIA AO PARTO S/ DISTOCIA
#'    \item 0310010020  ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO
#'    \item 0310010039  PARTO NORMAL
#'    \item 0310010047  PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO
#'    \item 0411010018  DESCOLAMENTO MANUAL DE PLACENTA
#'    \item 0411010026  PARTO CESARIANO EM GESTAÇÃO ALTO RISCO
#'    \item 0411010034  PARTO CESARIANO
#'    \item 0411010042  PARTO CESARIANO C/ LAQUEADURA TUBÁRIA
#'    \item 0411020013  CURETAGEM PÓS-ABORTAMENTO / PUERPERAL
#'    \item 0411020021  EMBRIOTOMIA
#'    }
#' \item \code{parto.rm } TRUE (padrão) exclui as internações por parto pelo campo diagnóstico, independente do procedimento. São excluídas as internações com os seguintes diagnósticos (CID-10):
#'  \itemize{
#'   \item O80 Parto único espontâneo
#'   \item O81 Parto único por fórceps ou vácuo-extrator
#'   \item O82 Parto único por cesariana
#'   \item O83 Outros tipos de parto único assistido
#'   \item O84 Parto múltiplo
#'  }
#'
#' É retornada uma mensagem informando o número de registros lidos, o número e proporção de registros excluídos e o total de registros importados.
#'
#' \item \code{sihsus}  A própria função define este argumento como \code{FALSE} quando "x" (o alvo da função) é um fator. Quando o alvo é um objeto da clase \code{data frame} sem a estrutura dos arquivos da AIH, a variável com os códigos da CID-10 deve ser trabalhada como um \code{factor}.
#' }
#'
#' @return
#' A função tem diferentes possibilidades de retorno, segundo a estrutura dos dados lidos e as opções de leitura:
#' \itemize{
#'  \item Se for um arquivo ou \code{data frame} com a estrutura dos arquivos da AIH:
#'    \itemize{
#'      \item um \code{data frame} com as variáveis nº da AIH, município de residência, município de internação, sexo, data de nascimento, idade em anos completos, faixa etária detalhada, faixa etária quinquenal, data da internação, data da saída, procedimento realizado, cid, CSAP, grupo csap, CEP e CNES do hospital
#'        \itemize{
#'          \item Nesse caso, o banco resultante tem um argumento "resumo" com o resumo da importação de dados, segundo as opções de seleção
#'          \item Se os argumentos \code{grupo}, \code{cep} ou \code{cnes} forem definidos como \code{FALSE}, o banco é construído sem essas variáveis
#'      }
#'      \item Se um fator ou data frame sem a estrutura dos arquivos da AIH:}
#'  \itemize{
#'    \item Se \code{grupos = TRUE}: um banco de dados com as variáveis \code{csap} (sim ou não), \code{grupo} (subgrupo CSAP) e \code{cid} (código da CID-10);
#'    \item Se \code{factor} e \code{grupos = FALSE}: um fator com as observações classificadas como CSAP ou não-CSAP.
#'   }
#'  }
#'
#' @note
#' A função \code{\link[foreign]{read.dbf}}, do pacote \code{foreign}, não lê arquivos em formato DBF em que uma das variáveis tenha todos os valores ausentes ('missings'); essas variáveis devem ser excluídas antes da leitura do arquivo pela função \code{csapAIH} ou mesmo pela função \code{\link[foreign]{read.dbf}}.
#'
#' @references
#' Alfradique ME et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6): 1337-1349. \url{https://doi.org/10.1590/S0102-311X2009000600016}.
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
#' # Ao contrário de csapAIH, o vetor pode ser da classe 'character'
#' csapAIH2(cids)
#' csapAIH2(factor(cids))
#' csapAIH2(cids,  grupo=FALSE)
#'
#' ## Um 'arquivo da AIH' armazenado no diretório de trabalho:
#' ##---------------------------------------------------------
#' \dontrun{
#'  teste.dbf <- csapAIH2("data-raw/RDRS1801.dbf")
#'  str(teste.dbf)
#'  teste.dbc <- csapAIH2("data-raw/RDRS1801.dbc")
#'  str(teste.dbc)
#'  }
#'
#' ## Um 'data.frame' com a estrutura dos 'arquivos da AIH':
#' ##-------------------------------------------------------
#' data("aih500")
#' str(aih500)
#' teste5 <- csapAIH2(aih500)
#' attributes(teste5)$resumo
#' str(teste5)
#' levels(teste5$grupo)
#'
#' # Sem excluir registros
#' teste6 <- csapAIH2(aih500, procobst.rm = FALSE, parto.rm = FALSE, longa.rm = FALSE)
#' str(teste6)
#' attributes(teste6)$resumo
#'
#' # Com a lista de 20 grupos de causa (Alfradique et al.)
#' teste7 <- csapAIH2(aih500, lista = "Alfradique")
#' str(teste7)
#' levels(teste7$grupo)
#'
#' ## Uma base de dados sem a estrutura dos arquivos RD*.dbc:
#' ##--------------------------------------------------------
#' teste9 <- csapAIH2(eeh20, sihsus = FALSE, cid = cau_cie10)
#' str(teste9)
#' teste10 <- csapAIH2(eeh20, sihsus = FALSE, cid = cau_cie10, parto.rm = FALSE)
#' str(teste10)
#'
#' ## Uma base de dados com a estrutura dos "arquivos da AIH" mantendo
#' ## todas suas variáveis
#' ##-----------------------------------------------------------------
#' ## Trate como se não fosse um arquivo da AIH e apenas acrescente
#' ## a classificação ao banco:
#' teste11 <- csapAIH2(aih500, sihsus = FALSE, cid = DIAG_PRINC)
#' str(teste11)
#'
#' ## Selecionar variáveis da AIH
#' ##---------------------------------------------------------
#' teste12 <- csapAIH2(aih500, vars = c('DIAG_PRINC', 'RACA_COR', 'INSTRU'))
#' head(teste12)
#'
#' @importFrom dplyr is.tbl
#'
#' @export
#'
csapAIH2 <- function(x, lista = "MS", grupos=TRUE, sihsus=TRUE, procobst.rm=TRUE, parto.rm=TRUE, longa.rm=TRUE, arquivo=TRUE, sep, cid = NULL, vars = NULL, ...) {
  # Lista de causas a ser usada
  if(lista == "MS") {
    lista <- listaBRMS
    } else if (lista == "Alfradique") {
      lista <- listaBRAlfradique
    }

  # ## Se for fator ou caractere já resolve agora
  if ( is.factor(x) | is.character(x) ) {
    banco <- lista(x)
    if(isFALSE(grupos)) { banco <- banco[[1]] }
    return(banco)
  } #else
  if (is.data.frame(x)) {
    arquivo <- FALSE
    if(is.tbl(x)) { x <- as.data.frame(x) }
  }
  if (isFALSE(sihsus)) {
  # # Garantir o trabalho com operadores mais tarde, no CID
  #   if(!is.character(cid)) cid <- as.character(cid)
  # if(haven::is.labelled(cid)) cid <- haven::zap_labels(cid)
    # if (is.data.frame(x)) {
      cid <- x[, deparse(substitute(cid))]
      juntar <- x
      banco <- cbind(x, lista(cid))
  }
#
  #   Bancos com estrutura do SIHSUS  usam a função 'leraih'         #
  if( isTRUE(sihsus) ) {
    x <- leraih(x, vars = vars, ...)
    banco <- cbind(x, lista(x$DIAG_PRINC))
  }
  banco$csap <- factor(banco$csap, levels = c("sim", "n\u00E3o"))
  attr(banco, "resumo") <- attr(x, "resumo")
  # cid[cid==""] <- NA

  ###########################
  ### Montar o objeto final #
  ###########################
  if (grupos==FALSE ) { banco$grupo <- NULL }

  ## Exclusão de partos em bancos sem a estrutura do SIH/SUS
  if (sihsus == FALSE) {
    if(parto.rm == TRUE) {
      if(is.factor(cid)) { cid <- as.character(cid) }
      nlidos <- nrow(banco)
      banco <- subset(banco, subset = cid < "O80" | cid >= "O85", drop = TRUE)
      pexcluidos <- round((1-(nrow(banco)/nlidos))*100,1)
      message(paste0(c("Exclu\u00EDdos ",
                       suppressWarnings(formatC(nlidos-nrow(banco), big.mark = ".")),
                       " registros de parto",
                       " (", formatC(pexcluidos, decimal.mark = ","), "\u0025 do total).")))
    }
  }

  rownames(banco) <-  NULL

  if( !is.data.frame(x) & isFALSE(sihsus) & isFALSE(grupos) ) {
    banco <- banco[['csap']]
  }

  banco

}
