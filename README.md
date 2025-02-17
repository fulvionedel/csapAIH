csapAIH: Classificar Condições Sensíveis à Atenção Primária
================
Fúlvio Borges Nedel
Atualizado em 17 de fevereiro de 2025

- [Apresentação](#apresentação)
  - [Justificativa](#justificativa)
- [Instalação](#instalação)
- [Conteúdo (*timeline*)](#conteúdo-timeline)
- [Dependências](#dependências)
- [Agradecimentos](#agradecimentos)
- [Referências](#referências)

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
(como é o caso da diabete). ([Nedel et al. 2011](#ref-Nedel2011))

O Ministério da Saúde brasileiro estabeleceu em 2008, após amplo
processo de validação, uma lista com várias causas de internação
hospitalar consideradas CSAP, definindo em portaria a Lista Brasileira.
([Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde
2008](#ref-MS2008lista); [Alfradique et al. 2009](#ref-Alfradique2009))
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

O pacote `csapAIH` pode ser instalado no **R** de diferentes maneiras:

- baixando o arquivo de instalação no
  [SourceForge](https://sourceforge.net/projects/csapaih/) e depois
  instalando, com a IDE de preferência ou com o comando
  `install.packages("csapAIH_<versão>.tar.gz")` (em Linux ou Mac) ou
  `install.packages("csapAIH_<versão>.zip")` (em Windows);

- com a função `install.packages()` sobre o arquivo tar.gz no
  [SourceForge](https://sourceforge.net/projects/csapaih/) [^1]:

``` r
install.packages("https://sourceforge.net/projects/csapaih/files/csapAIH_0.0.4.5.tar.gz/download", type = "source", repos = NULL) 
```

ou

- através do pacote `remotes` sobre os arquivos-fonte da versão em
  desenvolvimento, no [GitHub](https://github.com/fulvionedel/csapAIH):

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
da Lista Brasileira ([Alfradique et al. 2009](#ref-Alfradique2009)).
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
variável `grupo`). A v0.0.4.6 corrige um erro em `ler_popbr` e,
principalmente, acrescenta a possibilidade de leitura dos arquivos com
as estimativas populacionais atualizadas após o Censo 2022 do IBGE, além
de incluir novas possiblidades em `nomesgruposCSAP`.

A ajuda sobre o pacote oferece mais detalhes sobre as funções e seu uso.
Veja no
[manual](https://github.com/fulvionedel/csapAIH/blob/master/docs/csapAIH_0.0.4.6.pdf)
ou, no R, com `?'csapAIH-package'`.

# Dependências

A leitura de arquivos .DBC exige a instalação prévia do pacote
[`read.dbc`](https://cran.r-project.org/web/packages/read.dbc/index.html)
([Petruzalek 2016](#ref-readdbc)). Sua falta não impede o funcionamento
das demais funções do pacote (inclusive de leitura de arquivos em outro
formato). Da mesma forma, `popbr2000_2021` exige a instalação do
pacote[`brpop`](https://rfsaldanha.github.io/brpop/) e `fetchcsap` exige
a instalação do pacote
[`microdatasus`](https://github.com/rfsaldanha/microdatasus).

A função `desenhaCSAP` tem melhor desempenho com o pacote `ggplot2`
instalado, mas sua instalação não é necessária para que ela funcione.

A função `popbr2000_2021` usa o pacote
[`dplyr`](https://cran.r-project.org/package=dplyr), que é importado. O
pacote [`haven`](https://cran.r-project.org/package=haven) também é
importado. A partir da v0.0.4.4
[`Hmisc`](https://cran.r-project.org/web/packages/Hmisc/index.html) não
é mais.
<!-- O código da função `???` é escrito com a função de encadeamento de comandos  ("_piping_") própria do R ("|>") e seu uso exige, portanto, R>=4.1.0 (espero não gerar outro problema como [esse](https://github.com/fulvionedel/csapAIH/issues/5). -->

------------------------------------------------------------------------

***Veja o manual do pacote em:***
<https://github.com/fulvionedel/csapAIH/blob/master/docs/csapAIH_0.0.4.5.pdf>

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->

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

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-Alfradique2009" class="csl-entry">

Alfradique, Maria Elmira, Palmira de Fátima Bonolo, Inês Dourado, Maria
Fernanda Lima-Costa, James Macinko, Claunara Schilling Mendonça, Veneza
Berenice Oliveira, Luís Fernando Rolim Sampaio, Carmen de Simoni, and
Maria Aparecida Turci. 2009.
“<span class="nocase">Interna<span class="nocase">ç</span><span class="nocase">õ</span>es
por condi<span class="nocase">ç</span><span class="nocase">õ</span>es
sens<span class="nocase">í</span>veis <span class="nocase">à</span>
aten<span class="nocase">ç</span><span class="nocase">ã</span>o
prim<span class="nocase">á</span>ria: a
constru<span class="nocase">ç</span><span class="nocase">ã</span>o da
lista brasileira como ferramenta para medir o desempenho do sistema de
sa<span class="nocase">ú</span>de (Projeto ICSAP - Brasil)</span>.”
*Cadernos de Saúde Pública* 25 (6): 1337–49.
<https://doi.org/10.1590/S0102-311X2009000600016>.

</div>

<div id="ref-MS2008lista" class="csl-entry">

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. 2008.
“<span class="nocase">Portaria Nº 221, de 17 de abril de 2008.</span>”
Ministério da Saúde.
<https://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html>.

</div>

<div id="ref-Nedel2017" class="csl-entry">

Nedel, Fúlvio Borges. 2017. “<span class="nocase">csapAIH: uma
fun<span class="nocase">ç</span><span class="nocase">ã</span>o para a
classifica<span class="nocase">ç</span><span class="nocase">ã</span>o
das condi<span class="nocase">ç</span><span class="nocase">õ</span>es
sens<span class="nocase">í</span>veis <span class="nocase">à</span>
aten<span class="nocase">ç</span><span class="nocase">ã</span>o
prim<span class="nocase">á</span>ria no programa
estat<span class="nocase">í</span>stico R</span>.” *Epidemiologia e
Serviços de Saúde* 26 (01): 199–209.
<https://doi.org/10.5123/S1679-49742017000100021>.

</div>

<div id="ref-Nedel2019" class="csl-entry">

———. 2019. “<span class="nocase">Pacote csapAIH: a Lista Brasileira de
Interna<span class="nocase">ç</span><span class="nocase">õ</span>es por
Condi<span class="nocase">ç</span><span class="nocase">õ</span>es
Sens<span class="nocase">í</span>veis <span class="nocase">à</span>
Aten<span class="nocase">ç</span><span class="nocase">ã</span>o
Prim<span class="nocase">á</span>ria no programa R</span>.”
*Epidemiologia e Serviços de Saúde* 28 (2): e2019084.
<https://doi.org/10.5123/S1679-49742019000200021>.

</div>

<div id="ref-Nedel2011" class="csl-entry">

Nedel, Fúlvio Borges, Luiz Augusto Facchini, João Luiz Bastos, and
Miguel Martín-Mateo. 2011. “<span class="nocase">Conceptual and
methodological aspects in the study of hospitalizations for ambulatory
care sensitive conditions</span>.” *Ciência & Saúde Coletiva* 16 (SUPPL.
1): 1145–54. <https://doi.org/10.1590/S1413-81232011000700046>.

</div>

<div id="ref-Nedel2008" class="csl-entry">

Nedel, Fúlvio Borges, Luiz Augusto Facchini, Miguel Martín-Mateo, Lúcia
Azambuja Saraiva Vieira, and Elaine Thumé. 2008.
“<span class="nocase">Programa Sa<span class="nocase">ú</span>de da
Fam<span class="nocase">í</span>lia e
condi<span class="nocase">ç</span><span class="nocase">õ</span>es
sens<span class="nocase">í</span>veis <span class="nocase">à</span>
aten<span class="nocase">ç</span><span class="nocase">ã</span>o
prim<span class="nocase">á</span>ria, Bag<span class="nocase">é</span>
(RS)</span>.” *Rev Saude Publica* 42 (6): 1041–52.
<https://www.scielo.br/j/rsp/a/NHNcRYsk8kwv4KYZqRD6S8c/?lang=pt>.

</div>

<div id="ref-OPS2014" class="csl-entry">

Organización Panamericana de la Salud (OPS). 2014.
*<span class="nocase">Compendio de indicadores del impacto y resultados
intermedios. Plan estrat<span class="nocase">é</span>gico de la OPS
2014-2019: "En pro de la salud: Desarrollo sostenible y
equidad"</span>*. Edited by OPS. Washington.
<https://www.paho.org/hq/dmdocuments/2016/ops-pe-14-19-compendium-indicadores-nov-2014.pdf>.

</div>

<div id="ref-readdbc" class="csl-entry">

Petruzalek, Daniela. 2016. *Read.dbc: Read Data Stored in DBC
(Compressed DBF) Files*. <https://CRAN.R-project.org/package=read.dbc>.

</div>

<div id="ref-brpopref" class="csl-entry">

Saldanha, Raphael. 2022. “Brpop: Brazilian Population Estimatives.”
<https://CRAN.R-project.org/package=brpop>.

</div>

<div id="ref-Saldanha2019" class="csl-entry">

Saldanha, Raphael de Freitas, Ronaldo Rocha Bastos, and Christovam
Barcellos. 2019. “<span class="nocase">Microdatasus: pacote para
download e pr<span class="nocase">é</span>-processamento de microdados
do Departamento de Inform<span class="nocase">á</span>tica do SUS
(DATASUS)</span>.” *Cadernos de Saúde Pública* 35 (9): e00032419.
<https://doi.org/10.1590/0102-311x00032419>.

</div>

</div>

[^1]: Como informado por [Rafael
    Barros](https://github.com/fulvionedel/csapAIH/issues/13#top), a
    instalação pelo arquivo .zip da internet resulta em erro.
    Estranhamente (pra mim, ao menos), uma vez baixado, o arquivo .zip é
    instalado sem erro.
