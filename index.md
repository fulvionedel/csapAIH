# csapAIH: Classificar Condições Sensíveis à Atenção Primária

26 de fevereiro de 2025

- [Apresentação](#apresenta%C3%A7%C3%A3o)
  - [Justificativa](#justificativa)
- [Instalação](#instala%C3%A7%C3%A3o)
- [Conteúdo (*timeline*)](#conte%C3%BAdo-timeline)
- [Dependências](#depend%C3%AAncias)
- [Agradecimentos](#agradecimentos)
- [Referências](#refer%C3%AAncias)

------------------------------------------------------------------------

No [SourceForge](https://sourceforge.net/projects/csapaih/): [![Download
csapAIH](https://img.shields.io/sourceforge/dt/csapaih.svg)](https://sourceforge.net/projects/csapaih/files/latest/download)
[![Download
csapAIH](https://img.shields.io/sourceforge/dm/csapaih.svg)](https://sourceforge.net/projects/csapaih/files/latest/download)

------------------------------------------------------------------------

# Apresentação

Pacote em **R** para a classificação de códigos da CID-10 (Classificação
Internacional de Doenças, 10ª Revisão) segundo a Lista Brasileira de
Internações por Condições Sensíveis à Atenção Primária (ICSAP). É
particularmente voltado ao trabalho com as bases de dados do Sistema de
Informações Hospitalares do SUS, o Sistema Único de Saúde brasileiro.
Tais bases (BD-SIH/SUS) contêm os “arquivos da AIH” (`RD??????.DBC`),
que podem ser expandidos para o formato DBF (`RD??????.DBF`), com as
informações de cada hospitalização ocorrida pelo SUS num período
determinado. Assim, embora o pacote permita a classificação de qualquer
listagem de códigos da CID-10, tem também algumas funcionalidades para
facilitar o trabalho com os “arquivos da AIH” e, atualmente, do Sistema
de Informações sobre Mortalidade (SIM). Inclui ainda as estimativas e
contagens populacionais por sexo e faixa etária para os municípios
brasileiros, de 2012 a 2024.

## Justificativa

A hospitalização por CSAP é um indicador da efetividade do sistema de
saúde em sua primeira instância de atenção, uma vez que a internação por
tais condições —pneumonia, infecção urinária, sarampo, diabetes etc.— só
acontecerá se houver uma falha do sistema nesse âmbito de atenção, seja
por não prevenir a ocorrência da doença (caso das doenças evitáveis por
vacinação, como o sarampo), não diagnosticá-la ou tratá-la a tempo (como
na pneumonia ou infeccão urinária) ou por falhar no seu controle clínico
(como é o caso da diabete). ([Nedel et al. 2011](#ref-Nedel2011))

O Ministério da Saúde brasileiro estabeleceu em 2008, após amplo
processo de validação, uma lista com várias causas de internação
hospitalar consideradas CSAP, definindo em portaria a Lista Brasileira.
([Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde
2008](#ref-MS2008lista); [Alfradique et al. 2009](#ref-Alfradique2009))
A Lista envolve vários códigos da CID-10 e classifica as CSAP em 19
subgrupos de causa, o que torna complexa e trabalhosa a sua
decodificação. Há alguns anos o Departamento de Informática do SUS
(DATASUS) incluiu em seu excelente programa de tabulação de dados
[TabWin](https://datasus.saude.gov.br/transferencia-de-arquivos/) a
opção de tabulação por essas causas, apresentando sua frequência segundo
a tabela definida pelo usuário.

Entretanto, muitas vezes a pesquisa exige a classificação de cada
internação individual como uma variável na base de dados. ([Nedel et al.
2008](#ref-Nedel2008))

# Instalação

A última versão lançada do pacote pode ser instalada no **R**:

- baixando o arquivo de instalação no
  [SourceForge](https://sourceforge.net/projects/csapaih/) e depois
  instalando, com a IDE de preferência ou com o comando
  `install.packages("csapAIH_<versão>.tar.gz")` (em Linux ou Mac) ou
  `install.packages("csapAIH_<versão>.zip")` (em Windows); ou

- com a função
  [`install.packages()`](https://rdrr.io/r/utils/install.packages.html)
  sobre o link da última versão no
  [SourceForge](https://sourceforge.net/projects/csapaih/files/):

``` r
install.packages("https://sourceforge.net/projects/csapaih/files/latest/download", type = "source", repos = NULL) 
```

A versão em desenvolvimento pode ser instalada através do pacote
`remotes` sobre os arquivos-fonte no
[GitHub](https://github.com/fulvionedel/csapAIH):

``` r
# install.packages("remotes") # desnecessário se o pacote já estiver instalado
remotes::install_github("fulvionedel/csapAIH")
```

# Conteúdo (*timeline*)

Na sua primeira versão ([Nedel 2017](#ref-Nedel2017)), o pacote
`csapAIH` continha apenas uma função, homônima: `csapAIH`.

Na versão 0.0.2, foram acrescentadas as funções `descreveCSAP`,
`desenhaCSAP` e `nomesgruposCSAP`, para a representação gráfica e
tabular das CSAP pela lista brasileira. Esta versão também permite a
leitura de arquivos da AIH em formato .DBC, sem necessidade de prévia
expansão a .DBF. Isso é possível pelo uso do pacote `read.dbc`, de
Daniela Petruzalek
(<https://cran.r-project.org/web/packages/read.dbc/index.html>).

A partir da versão 0.0.3 ([Nedel 2019](#ref-Nedel2019)), a função
`desenhaCSAP` permite o detalhamento do gráfico por categorias de outros
fatores do banco de dados, com o uso das funções `facet_wrap()` e
`facet_grid()`, de `ggplot2`, e permite ainda o desenho de gráficos com
as funções básicas, sem a instalação do pacote `ggplot2`. Foi ainda
criada uma função para o cálculo da idade nos arquivos da AIH: a função
`idadeSUS` é usada internamente por `csapAIH` e pode ser chamada pelo
usuário para calcular a idade sem a necessidade de classificar as CSAP.

Na versão 0.0.4, a função `csapAIH` oferece a opção de classificação das
CSAP em 20 grupos de causa, conforme proposto no processo de construção
da Lista Brasileira ([Alfradique et al. 2009](#ref-Alfradique2009)).
Essa é a lista sugerida pela Organização Panamericana da Saúde
([Organización Panamericana de la Salud (OPS) 2014](#ref-OPS2014)). As
funções `desenhaCSAP` e `tabCSAP` têm um argumento para seleção do
idioma dos nomes de grupos, em português (`pt`, padrão), espanhol (`es`)
ou inglês (`en`). Foram criadas as funções `ler_popbr` e
`popbr2000_2021` (esta sobre o pacote
[brpop](https://cran.r-project.org/package=brpop) de R. Saldanha
([2022](#ref-brpopref))) para acesso às estimativas populacionais
publicadas pelo DATASUS e funções para categorização da idade em faixas
etárias. Foi ainda criada uma função (`fetchcsap`) a partir da função
`fetchdatasus` do pacote `microdatasus`([R. de F. Saldanha, Bastos, and
Barcellos 2019](#ref-Saldanha2019)), para ler os arquivos no site FTP do
DATASUS e classificar as CSAP em um único comando. Foram criadas outras
funções para facilitar o manejo e apresentação de dados em estudos
ecológicos, como a categorização da idade em faixas etárias
(`fxetar_quinq` e `fxetar3g`) e a identificação dos diagnósticos de
parto (`partos`), particularmente para o Brasil e os arquivos do
DATASUS, como a listagem das Unidades da Federação do país (`ufbr`) e a
lista de procedimentos obstétricos em internações por eventos não
mórbidos (`procobst`). A v0.0.4.5 corrige um erro introduzido na
v0.0.4.4 em `csapAIH`, em que a variável `csap` registrava todos os
casos como “não” (embora estivessem classificados corretamente na
variável `grupo`). A v0.0.4.6 corrige um erro em
[`ler_popbr()`](https://fulvionedel.github.io/csapAIH/reference/ler_popbr.md)
e, principalmente, acrescenta a possibilidade de leitura dos arquivos
com as estimativas populacionais atualizadas após o Censo 2022 do IBGE,
além de incluir novas possiblidades em
[`nomesgruposCSAP()`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md).
A atualização de `ler_popbr` foi a razão de lançamento dessa versão do
pacote, mas depois percebi que o código IBGE do município vinha com sete
dígitos, diferente de tudo o mais no DATASUS e então atualizei a função
e lancei nova versão do pacote. A diferença da nova versão, v0.0.4.7,
está apenas nessa atualização.

A ajuda sobre o pacote oferece mais detalhes sobre as funções e seu uso.
Veja no
[manual](https://github.com/fulvionedel/csapAIH/tree/master/inst/manual/csapAIH_0.0.4.7.pdf)
ou, no R, com
[`?'csapAIH-package'`](https://fulvionedel.github.io/csapAIH/reference/csapAIH-package.md).

# Dependências

A leitura de arquivos .DBC exige a instalação prévia do pacote
[`read.dbc`](https://cran.r-project.org/web/packages/read.dbc/index.html)
([Petruzalek 2016](#ref-readdbc)). Sua falta não impede o funcionamento
das demais funções do pacote (inclusive de leitura de arquivos em outro
formato). Da mesma forma, `popbr2000_2021` exige a instalação do
pacote[`brpop`](https://rfsaldanha.github.io/brpop/) (mas a função é
mantida apenas para documentação) e `fetchcsap` exige a instalação do
pacote [`microdatasus`](https://github.com/rfsaldanha/microdatasus).

A função `desenhaCSAP` tem melhor desempenho com o pacote `ggplot2`
instalado, mas sua instalação não é necessária para que ela funcione.

A função `popbr2000_2021` usa o pacote
[`dplyr`](https://cran.r-project.org/package=dplyr), que é importado. O
pacote [`haven`](https://cran.r-project.org/package=haven) também é
importado. A partir da v0.0.4.4
[`Hmisc`](https://cran.r-project.org/web/packages/Hmisc/index.html) não
é mais.

------------------------------------------------------------------------

***Veja o manual do pacote em:***
<https://github.com/fulvionedel/csapAIH/blob/master/inst/manual/csapAIH_0.0.4.7.pdf>

# Agradecimentos

Agradeço a todxs os usuárixs do pacote, particularmente a quem informa
problemas e sugere mudanças, como @laiovictor e @igortadeu @rafadbarros,
e (muito!!) a quem apresenta soluções, como @denis-or.

E, sempre, meus profundos agradecimentos a

- Daniela Petruzalek, pelo pacote
  [read.dbc](https://cran.r-project.org/web/packages/read.dbc/index.html);
  e
- A Raphael Saldanha, pelos pacotes
  [microdatasus](https://github.com/rfsaldanha/microdatasus) e
  [brpop](https://github.com/rfsaldanha/brpop).

# Referências

Alfradique, Maria Elmira, Palmira de Fátima Bonolo, Inês Dourado, Maria
Fernanda Lima-Costa, James Macinko, Claunara Schilling Mendonça, Veneza
Berenice Oliveira, Luís Fernando Rolim Sampaio, Carmen de Simoni, and
Maria Aparecida Turci. 2009. “Internações por condições sensíveis à
atenção primária: a construção da lista brasileira como ferramenta para
medir o desempenho do sistema de saúde (Projeto ICSAP - Brasil).”
*Cadernos de Saúde Pública* 25 (6): 1337–49.
<https://doi.org/10.1590/S0102-311X2009000600016>.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. 2008.
“Portaria Nº 221, de 17 de abril de 2008.” Ministério da Saúde.
<https://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html>.

Nedel, Fúlvio Borges. 2017. “csapAIH: uma função para a classificação
das condições sensíveis à atenção primária no programa estatístico R.”
*Epidemiologia e Serviços de Saúde* 26 (01): 199–209.
<https://doi.org/10.5123/S1679-49742017000100021>.

———. 2019. “Pacote csapAIH: a Lista Brasileira de Internações por
Condições Sensíveis à Atenção Primária no programa R.” *Epidemiologia e
Serviços de Saúde* 28 (2): e2019084.
<https://doi.org/10.5123/S1679-49742019000200021>.

Nedel, Fúlvio Borges, Luiz Augusto Facchini, João Luiz Bastos, and
Miguel Martín-Mateo. 2011. “Conceptual and methodological aspects in the
study of hospitalizations for ambulatory care sensitive conditions.”
*Ciência & Saúde Coletiva* 16 (SUPPL. 1): 1145–54.
<https://doi.org/10.1590/S1413-81232011000700046>.

Nedel, Fúlvio Borges, Luiz Augusto Facchini, Miguel Martín-Mateo, Lúcia
Azambuja Saraiva Vieira, and Elaine Thumé. 2008. “Programa Saúde da
Família e condições sensíveis à atenção primária, Bagé (RS).” *Rev Saude
Publica* 42 (6): 1041–52.
<https://www.scielo.br/j/rsp/a/NHNcRYsk8kwv4KYZqRD6S8c/?lang=pt>.

Organización Panamericana de la Salud (OPS). 2014. *Compendio de
indicadores del impacto y resultados intermedios. Plan estratégico de la
OPS 2014-2019: “En pro de la salud: Desarrollo sostenible y equidad”*.
Edited by OPS. Washington.
<https://www.paho.org/hq/dmdocuments/2016/ops-pe-14-19-compendium-indicadores-nov-2014.pdf>.

Petruzalek, Daniela. 2016. *Read.dbc: Read Data Stored in DBC
(Compressed DBF) Files*. <https://CRAN.R-project.org/package=read.dbc>.

Saldanha, Raphael. 2022. “Brpop: Brazilian Population Estimatives.”
<https://CRAN.R-project.org/package=brpop>.

Saldanha, Raphael de Freitas, Ronaldo Rocha Bastos, and Christovam
Barcellos. 2019. “Microdatasus: pacote para download e pré-processamento
de microdados do Departamento de Informática do SUS (DATASUS).”
*Cadernos de Saúde Pública* 35 (9): e00032419.
<https://doi.org/10.1590/0102-311x00032419>.
