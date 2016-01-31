\name{aih100}
\alias{aih100}
\docType{data}
\title{
Banco com 100 registros de um 'arquivo da AIH' (RD??????.DBF).
}
\description{
Contém todas as variáveis dos arquivos atualmente disponibilizados no DATASUS.
}
\usage{data("aih100")}
\format{
  A data frame with 100 observations on the following 93 variables.
  \describe{
    \code{UF_ZI}, \code{ANO_CMPT}, \code{MES_CMPT}, \code{ESPEC}, \code{CGC_HOSP}, \code{N_AIH}, \code{IDENT}, \code{CEP}, \code{MUNIC_RES}, \code{NASC}, \code{SEXO}, \code{UTI_MES_IN}, \code{UTI_MES_AN}, \code{UTI_MES_AL}, \code{UTI_MES_TO}, \code{MARCA_UTI}, \code{UTI_INT_IN}, \code{UTI_INT_AN}, \code{UTI_INT_AL}, \code{UTI_INT_TO}, \code{DIAR_ACOM}, \code{QT_DIARIAS}, \code{PROC_SOLIC}, \code{PROC_REA}, \code{VAL_SH}, \code{VAL_SP}, \code{VAL_SADT}, \code{VAL_RN}, \code{VAL_ACOMP}, \code{VAL_ORTP}, \code{VAL_SANGUE}, \code{VAL_SADTSR}, 
\code{VAL_TRANSP},
\code{VAL_OBSANG},
\code{VAL_PED1AC},
\code{VAL_TOT},
\code{VAL_UTI},
\code{US_TOT},
\code{DT_INTER},
\code{DT_SAIDA},
\code{DIAG_PRINC},
\code{DIAG_SECUN},
\code{COBRANCA},
\code{NATUREZA}, 
\code{NAT_JUR},
\code{GESTAO},
\code{RUBRICA},
\code{IND_VDRL},
\code{MUNIC_MOV},
\code{COD_IDADE},
\code{IDADE},
\code{DIAS_PERM},
\code{MORTE},
\code{NACIONAL},
\code{NUM_PROC},
\code{CAR_INT},
\code{TOT_PT_SP},
\code{CPF_AUT},
\code{HOMONIMO},
\code{NUM_FILHOS},
\code{INSTRU},
\code{CID_NOTIF},
\code{CONTRACEP1},
\code{CONTRACEP2},
\code{GESTRISCO},
\code{INSC_PN},
\code{SEQ_AIH5},
\code{CBOR},
\code{CNAER},
\code{VINCPREV},
\code{GESTOR_COD},
\code{GESTOR_TP},
\code{GESTOR_CPF},
\code{GESTOR_DT},
\code{CNES},
\code{CNPJ_MANT},
\code{INFEHOSP},
\code{CID_ASSO},
\code{CID_MORTE},
\code{COMPLEX},
\code{FINANC},
\code{FAEC_TP},
\code{REGCT},
\code{RACA_COR},
\code{ETNIA},
\code{SEQUENCIA},
\code{REMESSA},
\code{AUD_JUST},
\code{SIS_JUST},
\code{VAL_SH_FED},
\code{VAL_SP_FED},
\code{VAL_SH_GES},
\code{VAL_SP_GES}
} } 
%\details{
%%  ~~ If necessary, more details than the __description__ above ~~
%}
\source{
\url{http://www2.datasus.gov.br/DATASUS/index.php?area=0901}
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
}
\examples{
data(aih100)
str(aih100)
}
\keyword{datasets}
