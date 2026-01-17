# Pacote csapAIH

Classifica um vetor com códigos da CID-10 segundo a Lista Brasileira de
Condições Sensíveis à Atenção Primária e oferece outras funcionalidades,
especialmente para o manejo dos \`arquivos da AIH' (arquivos
RD??????.DBC das Bases de Dados do Sistema de Informações Hospitalares
do SUS – BD-SIH/SUS).

A principal função do pacote,
[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
classifica os códigos da CID-10 segundo a Lista Brasileira de CSAP.
[`descreveCSAP`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md)
constrói uma tabela com frequências absolutas e relativas dos casos por
grupos de causa.
[`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)
constrói um gráfico de barras por grupos de causa.
[`idadeSUS`](https://fulvionedel.github.io/csapAIH/reference/idadeSUS.md)
calcula a idade do paciente na internação, nos "arquivos da AIH", ou
idade do óbito, nos arquivos do Sistema de Informações sobre Mortalidade
(SIM).

## Details

- `v0.0.4`

  A função `listaBR` foi renomeada para `listaBRMS` e foi criada a
  função `listaBRAlfradique` para a classificação das ICSAP em 20 grupos
  de causa, conforme publicado em [Alfradique et al.
  (2009)](https://doi.org/10.1590/S0102-311X2009000600016) – ambas são
  funções internas invocadas pela função
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md).
  Incluído o argumento `lista` na função
  [`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md)
  para adequar-se à lista com 20 grupos. O argumento `tipo` da função
  [`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md)
  (e utilizado em
  [`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)
  e
  [`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md))
  foi renomeado para `lang`. O argumento `parto.rm` em
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
  agora se vale da função
  [`partos`](https://fulvionedel.github.io/csapAIH/reference/partos.md),
  criada para permtir a identificação e exclusão dos partos a partir da
  causa principal de internação e, assim, com qualquer base de dados.
  Criadas as funções
  [`fxetar_quinq`](https://fulvionedel.github.io/csapAIH/reference/fxetar_quinq.md),
  para transformar um vetor numérico com a idade em faixas etárias
  quinquenais, e
  [`fxetar3g`](https://fulvionedel.github.io/csapAIH/reference/fxetar3g.md),
  para transformar um vetor numérico com a idade ou categórico com
  faixas etárias quinquenais em três grandes grupos etários: 0 a 14, 15
  a 59 e 60 e + anos de idade. Criada a função
  [`cid10cap`](https://fulvionedel.github.io/csapAIH/reference/cid10cap.md),
  para classificar códigos da CID-10 segundo seus capítulos. Criadas as
  funções
  [`ler_popbr`](https://fulvionedel.github.io/csapAIH/reference/ler_popbr.md),
  para leitura dos dados de população de 2008 a 2012 do DATASUS,
  armazenados no computador ou importados no site FTP (do DATASUS) e
  [`popbr2000_2021`](https://fulvionedel.github.io/csapAIH/reference/popbr2000_2021.md),
  com estimativas populacionais para os municípios brasileiros de 2000
  a 2021. Incluído um banco de dados com a população dos municípios
  brasileiros por sexo e faixa etária, contada no Censo 2010
  ([`POPBR10`](https://fulvionedel.github.io/csapAIH/reference/POPBR10.md)),
  e outro com uma amostra de mil registros da *Encuesta de Egresos
  Hospitalarios* do Equador, ano 2020
  ([`eeh20`](https://fulvionedel.github.io/csapAIH/reference/eeh20.md)).
  Criada a função
  [`fetchcsap`](https://fulvionedel.github.io/csapAIH/reference/fetchcsap.md),
  uma forma abreviada da função `fetchdatasus` do pacote `microdatasus`,
  para o download dos arquivos da AIH e classificação das CSAP. Com o
  retorno à disponibilização dos arquivos de estimativa populacional
  pelo DATASUS, a função
  [`ler_popbr`](https://fulvionedel.github.io/csapAIH/reference/ler_popbr.md)
  agora lê os arquivos de 1980 a 2024. Criada ainda a função
  [`popbr`](https://fulvionedel.github.io/csapAIH/reference/popbr.md)
  para facilitar a leitura e unificação de arquivos até 2012 e daquele
  ano em diante, que têm diferente estrutura. Criada a função
  [`adinomes`](https://fulvionedel.github.io/csapAIH/reference/adinomes.md),
  para incluir o nome do crupo CSAP como uma variável do banco de dados.
  O nome do Grupo 8 foi modificado de "DPOC" para "Pulmonares".

- `v0.0.3.3`

  Criado o argumento `parto.rm` em
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
  para excluir pelo CID eventuais partos com código de procedimento
  (`PROCREA`) não-obstétrico, além de facilitar a exclusão de partos em
  bases de dados sem a estrutura do SUS. As CSAP agora são classificadas
  por uma função interna separada, `listaBR`, invocada por
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md).
  Incluído um banco de dados de exemplo com estrutura diferente da AIH,
  uma amostra das hospitalizações no Equador, publicada pelo [*Instituto
  Nacional de Estadística y Censos
  (INEC)*](https://www.ecuadorencifras.gob.ec/camas-y-egresos-hospitalarios/)
  daquele país. Criada a função
  [`ufbr`](https://fulvionedel.github.io/csapAIH/reference/ufbr.md),
  para a classificação dos municípios por UF. Incluído o argumento
  `tipo` na função
  [`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md),
  permitindo listar os grupos de causa em português com ou sem acentos,
  em inglês ou em castelhano. Criada a função
  [`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md),
  para substituir `descreveCSAP`, que será descontinuada.
  [`descreveCSAP`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md)
  imprime uma tabela pronta para publicação com separação de milhar e
  decimal no formato latino, mas os valores são transformados em
  caractere, o que dificulta muito a edição da tabela em pacotes
  especializados (como `knitr, kableExtra, formattable, ...`), sobretudo
  para a apresentação em painéis interativos;
  [`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md),
  por sua vez, imprime uma tabela sem formatação, em que os valores são
  da classe `numeric`, com um argumento para apresentação da tabela já
  formatada; aceita o argumento `tipo` de
  [`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md).

- `v0.0.3.2`

  Criada a função
  [`proc.obst`](https://fulvionedel.github.io/csapAIH/reference/proc.obst.md),
  para a identificação dos procedimentos obstétricos pela tabela do
  SIH/SUS, com três possíveis resultados: (1) exclusão dos registros de
  procedimento obstétrico (padrão); (2) criação de nova variável com
  identificação (sim/não) do caso; e (3) exclusão dos demais registros.
  A exclusão dos procedimentos obstétricos (argumento
  `procobst.rm = TRUE`) na função
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
  agora é feita invocando a função
  [`proc.obst`](https://fulvionedel.github.io/csapAIH/reference/proc.obst.md).
  O argumento `parto.rm` agora funciona em data frames sem a estrutura
  do SIH/SUS. Algumas melhoras na documentação do pacote.

- `v0.0.3.1`

  - a função
    [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
    passa a ter um argumento `cid = NULL`, para identificar colunas com
    o CID em um `data.frame`;

  - a função
    [`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)
    recebe os argumentos `val.dig = 0`, para definir o nº de decimais
    nas porcentagens apresentadas nas barras do gráfico, e
    `val.size = 2.5`, para definir o tamanho das letras dos valores das
    barras;

  - criado o argumento `sis` com as opções `"SIH"` (padrão) e `"SIM"` em
    [`idadeSUS`](https://fulvionedel.github.io/csapAIH/reference/idadeSUS.md);
    finalmente a função pode ser utilizada para computar a idade nas
    bases da Declaração de Óbito no Sistema de Informações sobre
    Mortalidade

- `v0.0.3`

  As funções acrescentadas na versão 0.0.2 foram ampliadas: podem ser
  tabulados vetores sem todos os grupos de causa; grupos com frequência
  zero são excluídos do gráfico; o gráfico pode ser gerado com funções
  básicas, por demanda do usuário ou se
  [`ggplot2`](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)
  não estiver instalado no sistema; quando gerado a partir de um banco
  de dados, o gráfico em
  [`ggplot`](https://ggplot2.tidyverse.org/reference/ggplot.html) pode
  ser estratificado segundo categorias de outras variáveis do banco. O
  cálculo da idade não é mais feito na função
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
  mas por uma nova função,
  [`idadeSUS`](https://fulvionedel.github.io/csapAIH/reference/idadeSUS.md),
  invocada por
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
  e que também pode ser chamada independentemente sobre um "arquivo da
  AIH".

- `v0.0.2`

  Foram acrescentadas três funções ao pacote:
  [`descreveCSAP`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md),
  [`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)
  e
  [`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md),
  para a realização de tabelas e gráficos com qualidade de impressão
  para artigos e apresentação de relatórios. Acrescentada dependência do
  pacote [`read.dbc`](https://rdrr.io/pkg/read.dbc/man/read.dbc.html)
  para a leitura de arquivos comprimidos do DATASUS, em formato DBC.

- `v0.0.1`

  O pacote tem apenas uma função,
  [`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
  que permite trabalhar com um objeto no espaço de trabalho ou ler um
  arquivo com os dados. Se os dados tiverem a estrutura dos "arquivos da
  AIH" com uma definição mínima de variáveis, a função, com suas opções
  padrão, além de classificar a internação em CSAP, computa a idade em
  anos completos e em duas classificações etárias e permite a exclusão
  das AIHs de "longa permanência" e internações por alguns procedimentos
  obstétricos definidos.

## References

Alfradique, Maria Elmira et al. Internações por condições sensíveis à
atenção primária: a construção da lista brasileira como ferramenta para
medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil).
Cadernos de Saúde Pública. 2009; 25(6): 1337-1349. Disponível em:
<https://doi.org/10.1590/S0102-311X2009000600016>.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No.
221, de 17 de abril de 2008.
[http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html](http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.md)

Nedel FB. Pacote csapAIH: a Lista Brasileira de Internações por
Condições Sensíveis à Atenção Primária no programa R. Epidemiol. Serv.
Saúde. 2019; 28(2):e2019084. Disponível em:
<https://scielosp.org/article/ress/2019.v28n2/e2019084/pt/#>

Nedel FB. csapAIH: uma função para a classificação das condições
sensíveis à atenção primária no programa estatístico R. Epidemiol. Serv.
Saúde. 2017; 26(1):199-209. Disponível em:
<http://scielo.iec.gov.br/scielo.php?script=sci_arttext&pid=S1679-49742017000100199&lng=pt>.

## See also

Useful links:

- <https://github.com/fulvionedel/csapAIH>

- <https://fulvionedel.github.io/csapAIH/>
