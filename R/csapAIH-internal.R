#' @title Pacote csapAIH
#' @name csapAIH-package
#' @aliases csapAIH-package
#' @docType package
#' @description
#' Classifica um vetor com códigos da CID-10 segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária e oferece outras funcionalidades, especialmente para o manejo dos `arquivos da AIH' (arquivos RD??????.DBC das Bases de Dados do Sistema de Informações Hospitalares do SUS -- BD-SIH/SUS).
#'
#' A principal função do pacote, \code{\link{csapAIH}}, classifica os códigos da CID-10 segundo a Lista Brasileira de CSAP. \code{\link{descreveCSAP}} constrói uma tabela com frequências absolutas e relativas dos casos por grupos de causa. \code{\link{desenhaCSAP}} constrói um gráfico de barras por grupos de causa. \code{\link{idadeSUS}} calcula a idade do paciente na internação, nos "arquivos da AIH", ou idade do óbito, nos arquivos do Sistema de Informações sobre Mortalidade (SIM).
#'
#' @details
#'  \itemize{
#'    \item \code{v0.0.4}
#'
#'    A função \code{listaBR} foi renomeada para \code{listaBRMS} e foi criada a função \code{listaBRAlfradique} para a classificação das ICSAP em 20 grupos de causa, conforme publicado em \href{https://doi.org/10.1590/S0102-311X2009000600016}{Alfradique et al. (2009)} -- ambas são funções internas invocadas pela função \code{\link{csapAIH}}.
#'    Incluído o argumento \code{lista} na função \code{\link{nomesgruposCSAP}} para adequar-se à lista com 20 grupos. O argumento \code{tipo} da função \code{\link{nomesgruposCSAP}} (e utilizado em \code{\link{desenhaCSAP}} e \code{\link{tabCSAP}}) foi renomeado para \code{lang}.
#'    O argumento \code{parto.rm} em \code{\link{csapAIH}} agora se vale da função \code{\link{partos}}, criada para permtir a identificação e exclusão dos partos a partir da causa principal de internação e, assim, com qualquer base de dados.
#'    Criadas as funções \code{\link{fxetar_quinq}}, para transformar um vetor numérico com a idade em faixas etárias quinquenais, e \code{\link{fxetar3g}}, para transformar um vetor numérico com a idade ou categórico com faixas etárias quinquenais em três grandes grupos etários: 0 a 14, 15 a 59 e 60 e + anos de idade.
#'    Criada a função \code{\link{cid10cap}}, para classificar códigos da CID-10 segundo seus capítulos.
#'    Criadas as funções \code{\link{ler_popbr}}, para leitura dos dados de população de 2008 a 2012 do DATASUS, armazenados no computador ou importados no site FTP (do DATASUS) e \code{\link{popbr2000_2021}}, com estimativas populacionais para os municípios brasileiros de 2000 a 2021.
#'    Incluído um banco de dados com a população dos municípios brasileiros por sexo e faixa etária, contada no Censo 2010 (\code{\link{POPBR10}}), e outro com uma amostra de mil registros da \emph{Encuesta de Egresos Hospitalarios} do Equador, ano 2020 (\code{\link{eeh20}}).
#'    Criada a função \code{\link{fetchcsap}}, uma forma abreviada da função \code{fetchdatasus} do pacote \code{microdatasus}, para o download dos arquivos da AIH e classificação das CSAP.
#'    Com o retorno à disponibilização dos arquivos de estimativa populacional pelo DATASUS, a função \code{\link{ler_popbr}} agora lê os arquivos de 1980 a 2024.
#'
#'    \item \code{v0.0.3.3}
#'
#'    Criado o argumento \code{parto.rm} em \code{\link{csapAIH}}, para excluir pelo CID eventuais partos com código de procedimento (\code{PROCREA}) não-obstétrico, além de facilitar a exclusão de partos em bases de dados sem a estrutura do SUS. As CSAP agora são classificadas por uma função interna separada, \code{listaBR}, invocada por \code{\link{csapAIH}}. Incluído um banco de dados de exemplo com estrutura diferente da AIH, uma amostra das hospitalizações no Equador, publicada pelo \href{https://www.ecuadorencifras.gob.ec/camas-y-egresos-hospitalarios/}{\emph{Instituto Nacional de Estadística y Censos (INEC)}} daquele país. Criada a função \code{\link{ufbr}}, para a classificação dos municípios por UF. Incluído o argumento \code{tipo} na função \code{\link{nomesgruposCSAP}}, permitindo listar os grupos de causa em português com ou sem acentos, em inglês ou em castelhano. Criada a função \code{\link{tabCSAP}}, para substituir \code{descreveCSAP}, que será descontinuada. \code{\link{descreveCSAP}} imprime uma tabela pronta para publicação com separação de milhar e decimal no formato latino, mas os valores são transformados em caractere, o que dificulta muito a edição da tabela em pacotes especializados (como \code{knitr, kableExtra, formattable, ...}), sobretudo para a apresentação em painéis interativos; \code{\link{tabCSAP}}, por sua vez, imprime uma tabela sem formatação, em que os valores são da classe \code{numeric}, com um argumento para apresentação da tabela já formatada; aceita o argumento \code{tipo} de \code{\link{nomesgruposCSAP}}.
#'
#'    \item \code{v0.0.3.2}
#'
#'    Criada a função \code{\link{proc.obst}}, para a identificação dos procedimentos obstétricos pela tabela do SIH/SUS, com três possíveis resultados: (1) exclusão dos registros de procedimento obstétrico (padrão); (2) criação de nova variável com identificação (sim/não) do caso; e (3) exclusão dos demais registros. A exclusão dos procedimentos obstétricos (argumento \code{procobst.rm = TRUE}) na função \code{\link{csapAIH}} agora é feita invocando a função \code{\link{proc.obst}}. O argumento \code{parto.rm} agora funciona em data frames sem a estrutura do SIH/SUS. Algumas melhoras na documentação do pacote.
#'    \item \code{v0.0.3.1}
#'      \itemize{
#'        \item a função \code{\link{csapAIH}} passa a ter um argumento \code{cid = NULL}, para identificar colunas com o CID em um \code{data.frame};
#'        \item a função \code{\link{desenhaCSAP}} recebe os argumentos \code{val.dig = 0}, para definir o nº de decimais nas porcentagens apresentadas nas barras do gráfico, e \code{val.size = 2.5}, para definir o tamanho das letras dos valores das barras;
#'        \item criado o argumento \code{sis} com as opções \code{"SIH"} (padrão) e \code{"SIM"} em \code{\link{idadeSUS}}; finalmente a função pode ser utilizada para computar a idade nas bases da Declaração de Óbito no Sistema de Informações sobre Mortalidade
#'          }
#'
#'    \item \code{v0.0.3}
#'
#'    As funções acrescentadas na versão 0.0.2 foram ampliadas: podem ser tabulados vetores sem todos os grupos de causa; grupos com frequência zero são excluídos do gráfico; o gráfico pode ser gerado com funções básicas, por demanda do usuário ou se \code{\link[ggplot2]{ggplot2}} não estiver instalado no sistema; quando gerado a partir de um banco de dados, o gráfico em \code{\link[ggplot2]{ggplot}} pode ser estratificado segundo categorias de outras variáveis do banco. O cálculo da idade não é mais feito na função \code{\link{csapAIH}}, mas por uma nova função, \code{\link{idadeSUS}}, invocada por \code{\link{csapAIH}} e que também pode ser chamada independentemente sobre um "arquivo da AIH".
#'
#'    \item \code{v0.0.2}
#'
#'    Foram acrescentadas três funções ao pacote: \code{\link{descreveCSAP}}, \code{\link{desenhaCSAP}} e \code{\link{nomesgruposCSAP}}, para a realização de tabelas e gráficos com qualidade de impressão para artigos e apresentação de relatórios. Acrescentada dependência do pacote \code{\link[read.dbc]{read.dbc}} para a leitura de arquivos comprimidos do DATASUS, em formato DBC.
#'
#'    \item \code{v0.0.1}
#'
#'    O pacote tem apenas uma função, \code{csapAIH()}, que permite trabalhar com um objeto no espaço de trabalho ou ler um arquivo com os dados. Se os dados tiverem a estrutura dos "arquivos da AIH" com uma definição mínima de variáveis, a função, com suas opções padrão, além de classificar a internação em CSAP, computa a idade em anos completos e em duas classificações etárias e permite a exclusão das AIHs de "longa permanência" e internações por alguns procedimentos obstétricos definidos.
#'    }
#'
#' @references
#' Alfradique, Maria Elmira et al. Internações por condições sensíveis à atenção primária: a construção da lista brasileira como ferramenta para medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de Saúde Pública. 2009; 25(6): 1337-1349. Disponível em: \url{https://doi.org/10.1590/S0102-311X2009000600016}.
#'
#' Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No. 221, de 17 de abril de 2008. \url{http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html}
#'
#' Nedel FB. Pacote csapAIH: a Lista Brasileira de Internações por Condições Sensíveis à Atenção Primária no programa R. Epidemiol. Serv. Saúde. 2019; 28(2):e2019084. Disponível em: \url{https://scielosp.org/article/ress/2019.v28n2/e2019084/pt/#}
#'
#' Nedel FB. csapAIH: uma função para a classificação das condições sensíveis à atenção primária no programa estatístico R. Epidemiol. Serv. Saúde. 2017; 26(1):199-209. Disponível em: \url{http://scielo.iec.gov.br/scielo.php?script=sci_arttext&pid=S1679-49742017000100199&lng=pt}.
#'
#' @keywords package
#' @keywords CSAP, ACSC, PHCSC
#' @keywords AIH-SUS

"_PACKAGE"
