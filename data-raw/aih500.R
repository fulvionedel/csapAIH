#' @title Data frame with selected records from an 'AIH file'
#' @name aih500
#' @aliases aih500
#' @docType data
#'
#' @description A data frame with 500 records and all variables in actual files for the hospital admission form (Autorização de Internação Hospitalar - AIH), the "AIH files" (RD??????.DBC or RD??????.DBF) from DATASUS (Brazil, Ministry of Health).
#'
#' @usage data(aih500)
#'
#' @format
#' A data frame with 500 observations on the following 93 variables:
#' \code{UF_ZI}, \code{ANO_CMPT}, \code{MES_CMPT}, \code{ESPEC}, \code{CGC_HOSP}, \code{N_AIH}, \code{IDENT}, \code{CEP}, \code{MUNIC_RES}, \code{NASC}, \code{SEXO}, \code{UTI_MES_IN}, \code{UTI_MES_AN}, \code{UTI_MES_AL}, \code{UTI_MES_TO}, \code{MARCA_UTI}, \code{UTI_INT_IN}, \code{UTI_INT_AN}, \code{UTI_INT_AL}, \code{UTI_INT_TO}, \code{DIAR_ACOM}, \code{QT_DIARIAS}, \code{PROC_SOLIC}, \code{PROC_REA}, \code{VAL_SH}, \code{VAL_SP}, \code{VAL_SADT}, \code{VAL_RN}, \code{VAL_ACOMP}, \code{VAL_ORTP}, \code{VAL_SANGUE}, \code{VAL_SADTSR}, \code{VAL_TRANSP}, \code{VAL_OBSANG}, \code{VAL_PED1AC}, \code{VAL_TOT}, \code{VAL_UTI}, \code{US_TOT}, \code{DT_INTER}, \code{DT_SAIDA}, \code{DIAG_PRINC}, \code{DIAG_SECUN}, \code{COBRANCA}, \code{NATUREZA}, \code{NAT_JUR}, \code{GESTAO}, \code{RUBRICA}, \code{IND_VDRL}, \code{MUNIC_MOV}, \code{COD_IDADE}, \code{IDADE}, \code{DIAS_PERM}, \code{MORTE}, \code{NACIONAL}, \code{NUM_PROC}, \code{CAR_INT}, \code{TOT_PT_SP}, \code{CPF_AUT}, \code{HOMONIMO}, \code{NUM_FILHOS}, \code{INSTRU}, \code{CID_NOTIF}, \code{CONTRACEP1}, \code{CONTRACEP2}, \code{GESTRISCO}, \code{INSC_PN}, \code{SEQ_AIH5}, \code{CBOR}, \code{CNAER}, \code{VINCPREV}, \code{GESTOR_COD}, \code{GESTOR_TP}, \code{GESTOR_CPF}, \code{GESTOR_DT}, \code{CNES}, \code{CNPJ_MANT}, \code{INFEHOSP}, \code{CID_ASSO}, \code{CID_MORTE}, \code{COMPLEX}, \code{FINANC}, \code{FAEC_TP}, \code{REGCT}, \code{RACA_COR}, \code{ETNIA}, \code{SEQUENCIA}, \code{REMESSA}, \code{AUD_JUST}, \code{SIS_JUST}, \code{VAL_SH_FED}, \code{VAL_SP_FED}, \code{VAL_SH_GES}, \code{VAL_SP_GES}
#'
#' @source \url{http://www2.datasus.gov.br/DATASUS/index.php?area=0901}
#' @references
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015. 87p.
#'
#' @examples
#' data("aih500")
#' str(aih500)
#' @keywords datasets
"aih500"
