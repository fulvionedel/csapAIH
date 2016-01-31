\name{csapAIH}
\alias{csapAIH}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
% \packageTitle{csapAIH}
Classificar Condicoes Sensiveis a Atencao Primaria
}
\description{
% \section{Descrição}{ 
Classifica códigos da 10ª Revisão da Classificação Internacional de Doenças (CID-10) segundo a Lista Brasileira de Internação por Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos "arquivos da AIH" (RD??????.DBF; BD-SIH/SUS). 
% }
}

\section{Uso}{
csapAIH(x, grupos = TRUE, sihsus = TRUE, x.procobst = TRUE, longa = FALSE, 
        cep = TRUE, cnes = TRUE, arquivo = TRUE, ...)
}
\section{Argumentos}{
\itemize{
  \item{\code{x}  }{alvo da função: um arquivo, banco de dados ou vetor com códigos da CID-10 (ver \code{detalhes}); }
  \item{\code{grupos}  }{argumento lógico, obrigatório; \code{TRUE} (padrão) indica que as internações serão classificadas também em grupos de CSAP; }
  \item{\code{sihsus}  }{argumento lógico, obrigatório se \code{x} for um arquivo; \code{TRUE} (padrão) indica que o arquivo ou banco de dados a ser tabulado tem minimamente os seguintes campos dos arquivos da AIH: **ref** 
\itemize{
\item{DIAG_PRINC }{diagnóstico principal da internação;}
\item NASC {data de nascimento; }
\item DT_INTER {	data da internação; }
\item DT_SAIDA {	data da alta hospitalar; }
\item COD_IDADE {	código indicando a faixa etária a que se refere o valor registrado no campo idade; }
\item IDADE	{idade (tempo de vida acumulado) do paciente, na unidade indicada no campo COD_IDADE;}
\item MUNIC_RES	{município de residência do paciente;}
\item SEXO { sexo do paciente; }
\item N_AIH	{ número da AIH; }
\item { PROC_REA	procedimento realizado, segundo a tabela do SIH/SUS; }
} }
  \item{\code{x.procobst}:  }{argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) exclui as internações por procedimentos relacionados ao parto ou abortamento (\code{ver detalhes}); }
  \item{\code{longa}: }{argumento lógico; \code{FALSE} (padrão) exclui as AIH de longa permanência, retornando uma mensagem com o número e proporção de registros excluídos e o total de registros importados; argumento válido apenas se \code{sihsus=TRUE}; }
  \item{\code{cep}:  }{argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) inclui no banco o Código de Endereçamento Postal do indivíduo; argumento válido apenas se \code{sihsus=TRUE}; }
  \item{\code{cnes}:  }{argumento lógico, obrigatório se \code{sihsus=TRUE}; \code{TRUE} (padrão) inclui no banco o nº do hospital no Cadastro Nacional de Estabelecimentos de Saúde; argumento válido apenas se \code{sihsus=TRUE}; }
  \item{\code{arquivo}:  }{argumento lógico, obrigatório; \code{TRUE} (padrão) indica que o alvo da função (\code{x}) é um arquivo; FALSE indica que \code{x} é um objeto no espaço de trabalho; é automaticamente marcado como \code{FALSE} quando \code{x} é um \code{fator}; }
  \item{\code{\dots}: }{ permite a inclusão de argumentos da função \code{\link{read.table}}, para a leitura de arquivos em outros formatos. }
}
}

\section{Detalhes}{
\itemize{  
  \item{x pode ser:}{ 
  \enumerate{ \item{ }{um arquivo de dados armazenado num diretório; } 
              \item{ }{um banco de dados, ou um vetor da classe \code{character} ou \code{factor} presente como objeto no espaço de trabalho do R, em que uma das variáveis, ou o vetor, contenha códigos da CID-10. }
              }

  Se for um __arquivo__, o nome deve ser escrito entre aspas e com a extensão do arquivo (DBF ou dbf). Se não estiver no diretório de trabalho ativo, seu nome deve ser precedido pelo caminho (path) até o diretório de armazenamento. Se estiver em outro formato, podem-se usar os argumentos da função \code{\link{read.table}} para leitura dos dados.
  
  Se a função for dirigida a um objeto no espaço de trabalho da classe \code{factor} ou \code{data.frame}, estes também são reconhecidos e o comando é o mesmo: \code{csapAIH(<objeto>)}. Se o objeto for de outra classe, como \code{character} ou \code{matrix}, é necessário definir o argumento "arquivo" como FALSE: \code{csapAIH(<objeto>, arquivo = FALSE)}, ou, para vetores isolados, defini-lo como fator: \code{csapAIH(as.factor(<objeto>))}.
  
  É retornada uma mensagem informando o número de registros lidos.
  }
\item{x.procbst } {= TRUE (padrão) exclui as internações pelos seguintes procedimentos obstétricos:
\itemize{
\item{0310010020 } ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO
\item{0310010039 } PARTO NORMAL
\item{0310010047 } PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO 
\item{0411010018 } DESCOLAMENTO MANUAL DE PLACENTA
\item{0411010026 } PARTO CESARIANO EM GESTAÇÃO ALTO RISCO
\item{0411010034 } PARTO CESARIANO
\item{0411010042 } PARTO CESARIANO C/ LAQUEADURA TUBÁRIA
\item{0411020013 } CURETAGEM PÓS-ABORTAMENTO / PUERPERAL
\item{0411020021 } EMBRIOTOMIA
}
 É retornada uma mensagem informando o número e proporção de registros excluídos e o total de registros importados.
 }
}
}

\section{Valor}{
A função tem diferentes possibilidades de retorno, segundo a estrutura dos dados lidos e as opções de leitura:
\itemize{
  \item{Se \code{sihsus = FALSE}:}
   \itemize{
    \item{Se \code{factor} e \code{grupos = FALSE}: }{ um fator com as observações classificadas como CSAP ou não-CSAP};
    \item{Se \code{factor} e \code{grupos = TRUE}: }{ um banco de dados com as variáveis \code{csap} (sim ou não), \code{grupo} (subgrupo CSAP) e \code{cid} (código da CID-10)};
    }
    \item{Se \code{data.frame} ou um arquivo: }{
  \itemize{
  \item{ }{ Se \code{sihsus=TRUE}: um banco de dados com as variáveis selecionadas da AIH (listadas acima) e as variáveis \code{csap} e, se \code{grupos=TRUE}, \code{grupo} ;}
  \item{ }{  
  } } }
} } 

\section{Autor}{
Fúlvio B. Nedel \email{fulvio.nedel@ufsc.br}
\itemize{\item Departamento de Saúde Pública, CCS/UFSC
          \url{http://spb.ufsc.br/}
         \item Grups de Recerca d'Amèrica i Àfrica Llatines, GRAAL-UAB
          \url{http://graal.uab.cat}
         }
}

\section{Referências}{
Alfradique et al., Internações por Condições Sensíveis à Atenção Primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cad Saúde Pública 25(6):1337-49.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}

__________. Departamento de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de Informação - 2010. Manual técnico operacional do Sistema de Informação Hospitalar: orientações técnicas. Versão 01.2013. Ministério da Saúde: Brasília, 2013.
}

\note{
A leitura de arquivos tem os limites das funções que usa, \code{\link{read.table}} e sua derivada \code{\link{read.dbf}}, do pacote \code{foreign}. 

Assim, arquivos em formato DBF ou DTA contendo uma variável com todos os valores ausentes ('missings') retornará erro de leitura; essas variáveis devem ser excluídas antes da leitura do arquivo pela função \code{csapAIH} ou mesmo pelas função \code{\link{read.dbf}}.
}

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\code{\link{read.table}}
}

\examples{
## Uma lista de códigos da CID-10:
##---------------------------------
cids <- c("I200", "K929", "T16", "I509", "I10",  "I509", "S068")
teste1 <- csapAIH(as.factor(cids)) ; class(teste1) ; teste1
teste2 <- csapAIH(as.factor(cids),  grupo=FALSE) ; class(teste2) ; teste2

## Um 'arquivo da AIH' armazenado no diretório de trabalho:
##---------------------------------------------------------
\dontrun{
teste3 <- csapAIH("RDRS1301.dbf")
str(teste3)
}

## Um 'data.frame' com a estrutura dos 'arquivos da AIH':
##-------------------------------------------------------
data("aih100")
str(aih100)
teste4 <- csapAIH(aih100)
str(teste4)

## Uma base de dados com a estrutura dos 'arquivos da AIH' 
## mas sem as variáveis CEP ou CNES:
##--------------------------------------------------------
aih <- subset(aih100, select = -c(CEP, CNES))
teste5 <- csapAIH(aih, cep = FALSE, cnes = FALSE)
str(teste5)

## Para uma base de dados sem a estrutura dos BD-SIH/SUS, apenas 
## trabalhe a variável com os CIDs, como nos primeiros exemplos
##--------------------------------------------------------------
## teste6 <- csapAIH(BaseDeDados$VariavelcomCID)

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ CSAP }
\keyword{ AIH-SUS }
\keyword{ package }
\keyword{ function }% __ONLY ONE__ keyword per line
