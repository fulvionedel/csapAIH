csapAIH: <font size="2"> Classificar Condições Sensíveis à Atenção
Primária</font>
================
Fúlvio Borges Nedel

Atualizado em 09 de abril de 2023

- <a href="#apresentação" id="toc-apresentação">Apresentação</a>
- <a href="#justificativa" id="toc-justificativa">Justificativa</a>
- <a href="#instalação" id="toc-instalação">Instalação</a>
- <a href="#conteúdo-timeline" id="toc-conteúdo-timeline">Conteúdo
  (<em>timeline</em>)</a>
- <a href="#dependências" id="toc-dependências">Dependências</a>
- <a href="#exemplos-de-uso" id="toc-exemplos-de-uso">Exemplos de uso</a>
  - <a href="#classificação-da-causa-código-cid-10"
    id="toc-classificação-da-causa-código-cid-10">Classificação da causa
    (código CID-10)</a>
    - <a href="#em-arquivos-de-dados" id="toc-em-arquivos-de-dados">Em
      arquivos de dados</a>
    - <a href="#em-um-banco-de-dados-existente-na-sessão-de-trabalho"
      id="toc-em-um-banco-de-dados-existente-na-sessão-de-trabalho">Em um
      banco de dados existente na sessão de trabalho</a>
    - <a href="#a-partir-de-uma-variável-com-códigos-da-cid-10"
      id="toc-a-partir-de-uma-variável-com-códigos-da-cid-10">A partir de uma
      variável com códigos da CID-10:</a>
  - <a href="#apresentação-de-resultados"
    id="toc-apresentação-de-resultados">Apresentação de resultados</a>
    - <a href="#resumo-de-importação-de-dados"
      id="toc-resumo-de-importação-de-dados">Resumo de importação de dados</a>
    - <a href="#tabela-bruta" id="toc-tabela-bruta">Tabela “bruta”</a>
    - <a href="#tabela-para-apresentação"
      id="toc-tabela-para-apresentação">Tabela para apresentação</a>
    - <a href="#calcular-taxas" id="toc-calcular-taxas">Calcular taxas</a>
    - <a href="#gráficos" id="toc-gráficos">Gráficos</a>
- <a href="#agradecimentos" id="toc-agradecimentos">Agradecimentos</a>
- <a href="#referências" id="toc-referências">Referências</a>

<!-- README.md is generated from README.Rmd. Please edit that file -->

------------------------------------------------------------------------

No [SourceForge](https://sourceforge.net/projects/csapaih/): [![Download
csapAIH](https://img.shields.io/sourceforge/dt/csapaih.svg)](https://sourceforge.net/projects/csapaih/files/latest/download)
[![Download
csapAIH](https://img.shields.io/sourceforge/dm/csapaih.svg)](https://sourceforge.net/projects/csapaih/files/latest/download)

------------------------------------------------------------------------

# Apresentação

Pacote em **R** para a classificação de códigos da CID-10 (Classificação
Internacional de Doenças, 10ª Revisão) segundo a Lista Brasileira de
Condições Sensíveis à Atenção Primária (CSAP). É particularmente voltado
ao trabalho com as bases de dados do Sistema de Informações Hospitalares
do SUS, o Sistema Único de Saúde brasileiro. Tais bases (BD-SIH/SUS)
contêm os “arquivos da AIH” (`RD??????.DBC`), que podem ser expandidos
para o formato DBF (`RD??????.DBF`), com as informações de cada
hospitalização ocorrida pelo SUS num período determinado. Assim, embora
o pacote permita a classificação de qualquer listagem de códigos da
CID-10, tem também algumas funcionalidades para facilitar o trabalho com
os “arquivos da AIH” e, atualmente, do Sistema de Informações sobre
Mortalidade (SIM).

# Justificativa

A hospitalização por CSAP é um indicador da efetividade do sistema de
saúde em sua primeira instância de atenção, uma vez que a internação por
tais condições —pneumonia, infecção urinária, sarampo, diabetes etc.— só
acontecerá se houver uma falha do sistema nesse âmbito de atenção, seja
por não prevenir a ocorrência da doença (caso das doenças evitáveis por
vacinação, como o sarampo), não diagnosticá-la ou tratá-la a tempo (como
na pneumonia ou infeccão urinária) ou por falhar no seu controle clínico
(como é o caso da diabete).<sup>[1](#ref-Nedel2011)</sup>

O Ministério da Saúde brasileiro estabeleceu em 2008, após amplo
processo de validação, uma lista com várias causas de internação
hospitalar consideradas CSAP, definindo em portaria a Lista
Brasileira.<sup>[2](#ref-MS2008lista),[3](#ref-Alfradique2009)</sup> A
Lista envolve vários códigos da CID-10 e classifica as CSAP em 19
subgrupos de causa, o que torna complexa e trabalhosa a sua
decodificação. Há alguns anos o Departamento de Informática do SUS
(DATASUS) incluiu em seu excelente programa de tabulação de dados
[TabWin](https://datasus.saude.gov.br/transferencia-de-arquivos/) a
opção de tabulação por essas causas, apresentando sua frequência segundo
a tabela definida pelo usuário.

Entretanto, muitas vezes a pesquisa exige a classificação de cada
internação individual como uma variável na base de
dados.<sup>[4](#ref-Nedel2008)</sup> E não conheço outro programa ou
*script* (além do que tive de escrever em minha
tese<sup>[5](#ref-NedelTese)</sup>) que automatize esse trabalho.

# Instalação

O pacote `csapAIH` pode ser instalado no **R** de diferentes maneiras:

- baixando o arquivo em de instalação no
  [SourceForge](https://sourceforge.net/projects/csapaih/) e depois
  instalando no R, com a IDE de preferência ou com o comando
  `install.packages("csapAIH_<versão>.tar.gz")` ou
  `install.packages("csapAIH_<versão>.zip")`;

- com a função `install.packages()` sobre os arquivos de instalação no
  [SourceForge](https://sourceforge.net/projects/csapaih/):

``` r
#  arquivos .tar.gz
install.packages("https://sourceforge.net/projects/csapaih/files/<versão>.tar.gz/download", type = "source", repos = NULL) 

# arquivos .zip
install.packages("https://sourceforge.net/projects/csapaih/files/<versão>.zip/download", type = "source", repos = NULL) 
```

ou

- através do pacote `remotes` sobre os arquivos-fonte do pacote em
  desenvolvimento, no [GitHub](https://github.com/fulvionedel/csapAIH):

``` r
# install.packages("remotes") # desnecessário se o pacote já estiver instalado
remotes::install_github("fulvionedel/csapAIH")
```

# Conteúdo (*timeline*)

Na sua primeira versão<sup>[6](#ref-Nedel2017)</sup>, o pacote `csapAIH`
continha apenas uma função, homônima: `csapAIH`.

Na versão 0.0.2, foram acrescentadas as funções `descreveCSAP`,
`desenhaCSAP` e `nomesgruposCSAP`, para a representação gráfica e
tabular das CSAP pela lista brasileira. Esta versão também permite a
leitura de arquivos da AIH em formato .DBC, sem necessidade de prévia
expansão a .DBF. Isso é possível pelo uso do pacote `read.dbc`, de
Daniela Petruzalek
(<https://cran.r-project.org/web/packages/read.dbc/index.html>).

A partir da versão 0.0.3<sup>[7](#ref-Nedel2019)</sup>, a função
`desenhaCSAP` permite o detalhamento do gráfico por categorias de outros
fatores do banco de dados, com o uso das funções `facet_wrap()` e
`facet_grid()`, de `ggplot2`, e permite ainda o desenho de gráficos com
as funções básicas, sem a instalação do pacote `ggplot2`. Foi ainda
criada uma função para o cálculo da idade nos arquivos da AIH: a função
`idadeSUS` é usada internamente por `csapAIH` e pode ser chamada pelo
usuário para calcular a idade sem a necessidade de classificar as CSAP.

Na versão 0.0.4, a função `csapAIH` oferece a opção de classificação das
CSAP em 20 grupos de causa, conforme proposto no processo de construção
da Lista Brasileira<sup>[3](#ref-Alfradique2009)</sup>. Essa é a lista
sugerida pela Organização Panamericana da
Saúde<sup>[8](#ref-OPS2014)</sup>. As funções `desenhaCSAP` e `tabCSAP`
têm um argumento para seleção do idioma dos nomes de grupos, em
português (`pt`, padrão), espanhol (`es`) ou inglês (`en`). Foram
criadas as funções `ler_popbr` e `popbr2000_2021` (esta sobre o pacote
[brpop](https://cran.r-project.org/package=brpop)
de<sup>[9](#ref-brpopref)</sup>) para acesso às estimativas
populacionais publicadas pelo DATASUS e funções para categorização da
idade em faixas etárias.

A ajuda sobre o pacote oferece mais detalhes sobre as funções e seu uso.
Veja no
[manual](https://github.com/fulvionedel/csapAIH/blob/master/docs/csapAIH_0.0.4.pdf)
ou, no R, com `?'csapAIH-package'`.

# Dependências

A leitura de arquivos .DBC exige a instalação prévia do pacote
[`read.dbc`](https://cran.r-project.org/web/packages/read.dbc/index.html)<sup>[10](#ref-readdbc)</sup>.
Sua falta não impede o funcionamento das demais funções do pacote
(inclusive de leitura de arquivos em outro formato). A função
`desenhaCSAP` tem melhor desempenho com o pacote `ggplot2` instalado,
mas sua instalação não é necessária para que ela funcione. A função
`popbr2000_2021` usa o pacote
[`dplyr`](https://cran.r-project.org/package=dplyr), que é importado.
[`Hmisc`](https://cran.r-project.org/web/packages/Hmisc/index.html) e
[`haven`](https://cran.r-project.org/package=haven) também são
importados.
<!-- O código da função `???` é escrito com a função de encadeamento de comandos  ("_piping_") própria do R ("|>") e seu uso exige, portanto, R>=4.1.0 (espero não gerar outro problema como [esse](https://github.com/fulvionedel/csapAIH/issues/5). -->

# Exemplos de uso

``` r
library(dplyr) # facilitar o trabalho
Warning: package 'dplyr' was built under R version 4.2.3
library(csapAIH)
```

## Classificação da causa (código CID-10)

### Em arquivos de dados

É possível classificar as CSAP diretamente a partir de arquivos com
extensão .DBC, .DBF, ou .CSV, sem necessidade da leitura prévia dos
dados. Para outras extensões de arquivo é necessária a prévia importação
dos dados para um objeto de classe `data.frame`.

#### Arquivos do DATASUS

Através de seu site FTP, o DATASUS disponibiliza dados de diferentes
Sistemas de Informação em Saúde do SUS, em arquivos comprimidos de
extensão DBC. Os arquivos podem ser baixados na página de [transferência
de arquivos](https://datasus.saude.gov.br/transferencia-de-arquivos/) do
DATASUS e expandidos para DBF ou CSV (entre várias outras possibilidades
de manejo) pelo TabWin, disponível na mesma página. Graças ao pacote
[read.dbc](https://github.com/danicat/read.dbc), de Daniela Petruzalek,
também podemos ler os arquivos comprimidos do DATASUS no R, e graças ao
pacote [microdatasus](https://github.com/rfsaldanha/microdatasus), de
Raphael Saldanha<sup>[11](#ref-Saldanha2019)</sup>, podemos ler com
facilidade esses arquivos na internet, sem necessidade de download.

O código abaixo cria um banco com as informações das AIHs do “ano de
competência” 2021 ocorridas no RS e outro com as informações das
Declarações de Óbito (DO) de residentes no RS ocorridas em 2021:

``` r
# remotes::install_github("rfsaldanha/microdatasus") # desnecessário se o pacote estiver instalado
AIHRS2021 <- microdatasus::fetch_datasus(year_start = 2021, 1, 2021, 12, uf = "RS", 
                                         information_system = "SIH-RD")
nrow(AIHRS2021) |> Rcoisas::formatL(digits = 0) # linhas
[1] "709.893"
ncol(AIHRS2021) # colunas
[1] 113

DORS2021 <- microdatasus::fetch_datasus(year_start = 2021, year_end = 2021, uf = "RS", 
                                        information_system = "SIM-DO") 
nrow(DORS2021) |> Rcoisas::formatL(digits = 0)
[1] "117.158"
ncol(DORS2021)
[1] 87
```

Se o arquivo de dados estiver armazenado no computador, basta digitar,
entre aspas, o nome do arquivo — com o “*path*” se o arquivo estiver em
diretório diferente daquele da sessão de trabalho ativa (neste exemplo,
num sub-diretório do diretório de trabalho da sessão ativa, chamado
‘data-raw’).

<!-- têm o nome de acordo à seguinte estrutura: "RDUFAAMM.DBC", onde "UF" é a Unidade da Federação do hospital de internação e "AA" e "MM" são, respectivamente, o ano e mês "_de referência_", isto é, de faturamento da AIH. Os arquivos são disponibilizados em formato comprimido com a extensão "DBC", na página de ["transferência de arquivos"](https://datasus.saude.gov.br/transferencia-de-arquivos/) do site do DATASUS.  -->

``` r
csap <- csapAIH("data-raw/RDRS1801.dbc") 
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
```

``` r
csap <- csapAIH("data-raw/RDRS1801.dbf") 
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
```

- No caso de arquivos CSV é mandatório indicar o tipo de separador de
  campos, com o argumento `sep`.

``` r
csap <- csapAIH("data-raw/RDRS1801.csv", sep = ",")
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
```

### Em um banco de dados existente na sessão de trabalho

#### Com a estrutura dos arquivos da AIH

``` r
read.csv("data-raw/RDRS1801.csv") |> # criar o data.frame
  csapAIH() |>
  glimpse()
Importados 60.529 registros.
Excluídos 5.044 (8,3%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 55.119 (91,1%) registros.
Rows: 55,119
Columns: 16
$ n.aih      <chr> "4318100063695", "4318100349508", "4318100349563", "4318100…
$ munres     <int> 431340, 430450, 430450, 430450, 430450, 430450, 430450, 430…
$ munint     <int> 431080, 430450, 430450, 430450, 430450, 430450, 430450, 430…
$ sexo       <fct> masc, fem, fem, fem, masc, masc, masc, masc, fem, masc, fem…
$ nasc       <date> 1960-01-14, 1992-09-21, 1993-05-31, 1984-07-06, 1937-09-15…
$ idade      <dbl> 58, 25, 24, 33, 80, 69, 50, 58, 70, 69, 88, 61, 26, 42, 67,…
$ fxetar.det <fct> 55-59, 25-29, 20-24, 30-34, 80 e +, 65-69, 50-54, 55-59, 70…
$ fxetar5    <fct> 55-59, 25-29, 20-24, 30-34, 80 e +, 65-69, 50-54, 55-59, 70…
$ csap       <fct> não, não, não, não, sim, sim, não, não, sim, sim, não, não,…
$ grupo      <fct> não-CSAP, não-CSAP, não-CSAP, não-CSAP, g12, g03, não-CSAP,…
$ cid        <chr> "K439", "O628", "O641", "O623", "I64", "D500", "I408", "T63…
$ proc.rea   <int> 407040064, 411010034, 411010034, 303100044, 303040149, 3030…
$ data.inter <date> 2018-01-14, 2018-01-01, 2018-01-11, 2018-01-11, 2018-01-19…
$ data.saida <date> 2018-01-16, 2018-01-03, 2018-01-13, 2018-01-12, 2018-01-24…
$ cep        <int> 93544360, 96600000, 96600000, 96600000, 96600000, 96600000,…
$ cnes       <int> 2232189, 2232928, 2232928, 2232928, 2232928, 2232928, 22329…
```

#### Sem o padrão dos arquivos da AIH

Mude o argumento `sihsus` para `FALSE` e indique no argumento `cid` qual
variável contém os códigos diagnósticos. As variáveis `csap` e `grupo`
(se `csapAIH(..., grupos = TRUE, ...)`) são acrescentadas ao final do
banco de dados alvo da função.

##### A *Encuesta de Egresos Hospitalarios* do Equador.

``` r
data("eeh20") # Amostra da "Encuesta de egresos hospitalarios" do Equador, ano 2020
names(eeh20) # Os nomes das variáveis
 [1] "prov_ubi"   "cant_ubi"   "parr_ubi"   "area_ubi"   "clase"     
 [6] "tipo"       "entidad"    "sector"     "mes_inv"    "nac_pac"   
[11] "cod_pais"   "nom_pais"   "sexo"       "cod_edad"   "edad"      
[16] "etnia"      "prov_res"   "area_res"   "anio_ingr"  "mes_ingr"  
[21] "dia_ingr"   "fecha_ingr" "anio_egr"   "mes_egr"    "dia_egr"   
[26] "fecha_egr"  "dia_estad"  "con_egrpa"  "esp_egrpa"  "cau_cie10" 
[31] "cant_res"   "parr_res"   "causa3"     "cap221rx"   "cau221rx"  
[36] "cau298rx"  
```

A variável `cau_cie10` (posição 30) tem o código do diagnóstico de
internação. A função csapAIH acrescenta à base duas (se `grupo == TRUE`)
variáveis, `csap` e `grupo`, dispostas nas últimas colunas (posição e
respectivamente.)

``` r
csap.eeh20 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10)
Importados 1.000 registros.
Excluídos 150 registros de parto (15% do total).
names(csap.eeh20)
 [1] "prov_ubi"   "cant_ubi"   "parr_ubi"   "area_ubi"   "clase"     
 [6] "tipo"       "entidad"    "sector"     "mes_inv"    "nac_pac"   
[11] "cod_pais"   "nom_pais"   "sexo"       "cod_edad"   "edad"      
[16] "etnia"      "prov_res"   "area_res"   "anio_ingr"  "mes_ingr"  
[21] "dia_ingr"   "fecha_ingr" "anio_egr"   "mes_egr"    "dia_egr"   
[26] "fecha_egr"  "dia_estad"  "con_egrpa"  "esp_egrpa"  "cau_cie10" 
[31] "cant_res"   "parr_res"   "causa3"     "cap221rx"   "cau221rx"  
[36] "cau298rx"   "csap"       "grupo"     
csap.eeh20[c(30,37:38)] |> 
  head(3) 
  cau_cie10 csap    grupo
1      C169  não não-CSAP
2      U072  não não-CSAP
3      A090  sim      g02
```

##### A Declaração de Óbito (DO) do SIM

A variável `CAUSABAS` tem o código da causa básica do óbito.

De modo semelhante à AIH, as bases de dados da DO também têm a idade
codificada e não a verdadeira idade da pessoa. Por exemplo, a variável
`IDADE` em `DORS2021` é um `factor` com 215 níveis, em que o primeiro é
‘001’ e o último é ‘999’. Neste caso podemos usar a função `idadeSUS`
para computar a idade, mas como o resultado de `idadeSUS` é “um objeto
da classe data frame com três variáveis” (v. `?idadeSUS`), necessitamos
a função `unnest` (de `tidyr`) para desagrupar as variáveis antes de
inseri-las em `DORS2021`. Além disso, foi excluída (com
`unnest(...)[-2]`) a “faixa etária detalhada”, que é a segunda variável
no output de `idadeSUS`.

``` r
DORS2021 <- DORS2021 %>%
  csapAIH(sihsus = FALSE, cid = CAUSABAS, parto.rm = FALSE) %>%
  mutate(tidyr::unnest(idadeSUS(DORS2021, sis = "SIM"), cols = c())[-2],
         fxetar3 = fxetar3g(idade),
         SEXO = factor(SEXO, levels = c(1,2), labels = c("masc", "fem")))
Importados 117.158 registros.
DORS2021[1:3, (ncol(DORS2021)-5):ncol(DORS2021)]
  CONTADOR csap    grupo idade fxetar5 fxetar3
1       52  não não-CSAP    64   60-64    60e+
2       54  não não-CSAP    63   60-64    60e+
3      112  sim      g08    70   70-74    60e+
```

### A partir de uma variável com códigos da CID-10:

``` r
cids <- aih100$DIAG_PRINC[1:10]
cids
 [1] N189 O689 S423 H938 P584 I200 I442 C189 C409 K818
3254 Levels: A009 A020 A044 A045 A048 A049 A050 A058 A059 A061 A069 A071 ... Z990
csapAIH(cids) 
    cid csap    grupo
1  N189  não não-CSAP
2  O689  não não-CSAP
3  S423  não não-CSAP
4  H938  não não-CSAP
5  P584  não não-CSAP
6  I200  sim      g10
7  I442  não não-CSAP
8  C189  não não-CSAP
9  C409  não não-CSAP
10 K818  não não-CSAP
```

## Apresentação de resultados

### Resumo de importação de dados

Um resumo de importação, apresentado durante a realização do trabalho, é
guardado como atributo do banco de dados e pode ser recuperado com as
funções `attr()` ou `attributes()`:

``` r
csap <- csapAIH("data-raw/RDRS1801.dbc") # cria o data.frame
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.

attr(csap, "resumo")
          acao  freq  perc                                  objeto
1   Importados 60529 100.0                              registros.
2 Excluídos \t  8240  13.6 registros de procedimentos obstétricos.
3 Excluídos \t   366   0.6  registros de AIH de longa permanência.
4   Exportados 51923  85.8                              registros.
# attributes(csap)$resumo
```

Em tabela para apresentação:

``` r
attributes(csap)$resumo |>
  knitr::kable(format.args = c(big.mark = ".", decimal.mark = ","), 
               col.names = c("Ação", "N", "%", "Objeto") ) |>
  suppressWarnings()
```

| Ação       |      N |     % | Objeto                                  |
|:-----------|-------:|------:|:----------------------------------------|
| Importados | 60.529 | 100,0 | registros.                              |
| Excluídos  |  8.240 |  13,6 | registros de procedimentos obstétricos. |
| Excluídos  |    366 |   0,6 | registros de AIH de longa permanência.  |
| Exportados | 51.923 |  85,8 | registros.                              |

### Tabela “bruta”

A função `descreveCSAP` gera, a partir de um comando muito simples, uma
tabela pronta para apresentação, com as frequências brutas e absolutas
das CSAP por grupo de causa.

``` r
descreveCSAP(csap)
                                   Grupo  Casos %Total %CSAP
1   1. Prev. vacinação e cond. evitáveis    118   0,23  1,09
2                      2. Gastroenterite    802   1,54  7,38
3                              3. Anemia     73   0,14  0,67
4                 4. Defic. nutricionais    241   0,46  2,22
5     5. Infec. ouvido, nariz e garganta    168   0,32  1,55
6              6. Pneumonias bacterianas    653   1,26  6,01
7                                7. Asma    234   0,45  2,15
8                   8. Pulmonares (DPOC)  1.213   2,34 11,17
9                         9. Hipertensão    147   0,28  1,35
10                            10. Angina  1.005   1,94  9,25
11                   11. Insuf. cardíaca  1.394   2,68 12,83
12                 12. Cerebrovasculares  1.373   2,64 12,64
13                 13. Diabetes mellitus    743   1,43  6,84
14                        14. Epilepsias    331   0,64  3,05
15                   15. Infec. urinária  1.360   2,62 12,52
16          16. Infec. pele e subcutâneo    459   0,88  4,22
17     17. D. infl. órgãos pélvicos fem.    133   0,26  1,22
18           18. Úlcera gastrointestinal    195   0,38  1,79
19                 19. Pré-natal e parto    222   0,43  2,04
20                            Total CSAP 10.864  20,92   100
21                              não-CSAP 41.059  79,08    --
22                  Total de internações 51.923    100    --
```

### Tabela para apresentação

``` r
descreveCSAP(csap) |>
  knitr::kable(align = c('l', rep('r', 3)))
```

| Grupo                                 |  Casos | %Total | %CSAP |
|:--------------------------------------|-------:|-------:|------:|
| 1\. Prev. vacinação e cond. evitáveis |    118 |   0,23 |  1,09 |
| 2\. Gastroenterite                    |    802 |   1,54 |  7,38 |
| 3\. Anemia                            |     73 |   0,14 |  0,67 |
| 4\. Defic. nutricionais               |    241 |   0,46 |  2,22 |
| 5\. Infec. ouvido, nariz e garganta   |    168 |   0,32 |  1,55 |
| 6\. Pneumonias bacterianas            |    653 |   1,26 |  6,01 |
| 7\. Asma                              |    234 |   0,45 |  2,15 |
| 8\. Pulmonares (DPOC)                 |  1.213 |   2,34 | 11,17 |
| 9\. Hipertensão                       |    147 |   0,28 |  1,35 |
| 10\. Angina                           |  1.005 |   1,94 |  9,25 |
| 11\. Insuf. cardíaca                  |  1.394 |   2,68 | 12,83 |
| 12\. Cerebrovasculares                |  1.373 |   2,64 | 12,64 |
| 13\. Diabetes mellitus                |    743 |   1,43 |  6,84 |
| 14\. Epilepsias                       |    331 |   0,64 |  3,05 |
| 15\. Infec. urinária                  |  1.360 |   2,62 | 12,52 |
| 16\. Infec. pele e subcutâneo         |    459 |   0,88 |  4,22 |
| 17\. D. infl. órgãos pélvicos fem.    |    133 |   0,26 |  1,22 |
| 18\. Úlcera gastrointestinal          |    195 |   0,38 |  1,79 |
| 19\. Pré-natal e parto                |    222 |   0,43 |  2,04 |
| Total CSAP                            | 10.864 |  20,92 |   100 |
| não-CSAP                              | 41.059 |  79,08 |     – |
| Total de internações                  | 51.923 |    100 |     – |

Entretanto, ao transformar os valores para o formato latino, sua classe
se transforma em `character` e assim é impossível realizar cálculos com
esse output. Além disso, não serve para publicações em inglês. Por isso
a função `descreveCSAP` permanecerá no pacote mas seu desenvolvimento
seguirá em outra função, agora de nome `tabCSAP`. Nessa nova função, a
apresentação de uma tabela formatada se faz a partir do argumento
`format = TRUE`. Por padrão esse argumento é `FALSE`, o que permite
operações matemáticas com os valores da tabela (um `data.frame`, na
verdade), como veremos em seguida.

A função `tabCSAP` permite também a apresentação da tabela em inglês ou
espanhol, através do argumento `lang`:

``` r
tabCSAP(csap$grupo, digits = 1, lang = "en", format = T) |>
  knitr::kable(align = c('l', rep('r', 3)))
```

| Group                                |  Cases | Total % | ACSC % |
|:-------------------------------------|-------:|--------:|-------:|
| 1\. Vaccine prev. and amenable cond. |    118 |     0.2 |    1.1 |
| 2\. Gastroenteritis                  |    802 |     1.5 |    7.4 |
| 3\. Anemia                           |     73 |     0.1 |    0.7 |
| 4\. Nutritional deficiency           |    241 |     0.5 |    2.2 |
| 5\. Ear, nose and throat infec.      |    168 |     0.3 |    1.5 |
| 6\. Bacterial pneumonia              |    653 |     1.3 |    6.0 |
| 7\. Asthma                           |    234 |     0.5 |    2.2 |
| 8\. Pulmonary (COPD)                 |  1,213 |     2.3 |   11.2 |
| 9\. Hypertension                     |    147 |     0.3 |    1.4 |
| 10\. Angina                          |  1,005 |     1.9 |    9.3 |
| 11\. Heart failure                   |  1,394 |     2.7 |   12.8 |
| 12\. Cerebrovascular                 |  1,373 |     2.6 |   12.6 |
| 13\. Diabetes mellitus               |    743 |     1.4 |    6.8 |
| 14\. Convulsions and epilepsy        |    331 |     0.6 |    3.0 |
| 15\. Urinary infection               |  1,360 |     2.6 |   12.5 |
| 16\. Skin and subcutaneous infec.    |    459 |     0.9 |    4.2 |
| 17\. Pelvic inflammatory disease     |    133 |     0.3 |    1.2 |
| 18\. Gastrointestinal ulcers         |    195 |     0.4 |    1.8 |
| 19\. Pre-natal and childbirth        |    222 |     0.4 |    2.0 |
| ACSC                                 | 10,864 |    20.9 |    100 |
| Non ACSC                             | 41,059 |    79.1 |      – |
| TOTAL hospitalizations               | 51,923 |     100 |      – |

``` r

tabCSAP(csap$grupo, digits = 1, lang = "es", format = T) |>
  knitr::kable(align = c('l', rep('r', 3)))
```

| Grupo                                     |  Casos | % Total | % CSAP |
|:------------------------------------------|-------:|--------:|-------:|
| 1\. Prev. vacunación y otros medios       |    118 |     0,2 |    1,1 |
| 2\. Gastroenteritis                       |    802 |     1,5 |    7,4 |
| 3\. Anemia                                |     73 |     0,1 |    0,7 |
| 4\. Def. nutricionales                    |    241 |     0,5 |    2,2 |
| 5\. Infec. oído, nariz y garganta         |    168 |     0,3 |    1,5 |
| 6\. Neumonía bacteriana                   |    653 |     1,3 |    6,0 |
| 7\. Asma                                  |    234 |     0,5 |    2,2 |
| 8\. Enf. vías respiratorias inferiores    |  1.213 |     2,3 |   11,2 |
| 9\. Hipertensión                          |    147 |     0,3 |    1,4 |
| 10\. Angina de pecho                      |  1.005 |     1,9 |    9,3 |
| 11\. Insuf. cardíaca congestiva           |  1.394 |     2,7 |   12,8 |
| 12\. Enf. cerebrovasculares               |  1.373 |     2,6 |   12,6 |
| 13\. Diabetes mellitus                    |    743 |     1,4 |    6,8 |
| 14\. Epilepsias                           |    331 |     0,6 |    3,0 |
| 15\. Infección urinaria                   |  1.360 |     2,6 |   12,5 |
| 16\. Infec. piel y subcutáneo             |    459 |     0,9 |    4,2 |
| 17\. Enf infl órganos pélvicos femeninos  |    133 |     0,3 |    1,2 |
| 18\. Úlcera gastrointestinal              |    195 |     0,4 |    1,8 |
| 19\. Enf. del embarazo, parto y puerperio |    222 |     0,4 |    2,0 |
| Total CSAP                                | 10.864 |    20,9 |    100 |
| No-CSAP                                   | 41.059 |    79,1 |      – |
| Total de ingresos                         | 51.923 |     100 |      – |

Finalmente, [vimos](#lista) que a função `tabCSAP` permite ainda a
apresentação da lista em 20 grupos de causa. Assim, se as CSAP foram
classificadas em 20 grupos – usando, por exemplo o argumento
`lista = "Alfradique"` em `csapAIH()` –, essa tabela deve ser
apresentada com `tabCSAP` e não com `descreveCSAP`. Note ainda que, à
diferença de `descreveCSAP`, `tabCSAP` exige o nome da variável com o
grupo de causas.

``` r
listaOPS <- csapAIH(AIHRS2021, lista = "Alfradique")
Importados 709.893 registros.
Excluídos 88.345 (12,4%) registros de procedimentos obstétricos.
Excluídos 4.121 (0,6%) registros de AIH de longa permanência.
Exportados 617.427 (87%) registros.
# descreveCSAP(listaOPS) # Retorna o erro: "O vetor precisa ter os 19 grupos da Lista Brasileira.
#   Se essa for a lista 'Alfradique' use 'tabCSAP'.""
tabCSAP(listaOPS$grupo)
                                 grupo  casos perctot percsap
1               1. Prev. por vacinação    127    0.02    0.13
2            2. Outras cond. evitáveis   1316    0.21    1.31
3                    3. Gastroenterite   4205    0.68    4.20
4                            4. Anemia    695    0.11    0.69
5               5. Defic. nutricionais   1765    0.29    1.76
6   6. Infec. ouvido, nariz e garganta    954    0.15    0.95
7            7. Pneumonias bacterianas   5425    0.88    5.41
8                              8. Asma   3443    0.56    3.44
9                 9. Pulmonares (DPOC)  11389    1.84   11.36
10                     10. Hipertensão   1247    0.20    1.24
11                          11. Angina   8421    1.36    8.40
12                 12. Insuf. cardíaca  14119    2.29   14.09
13               13. Cerebrovasculares  16426    2.66   16.39
14               14. Diabetes mellitus   6784    1.10    6.77
15                      15. Epilepsias   3293    0.53    3.29
16                 16. Infec. urinária  11092    1.80   11.07
17        17. Infec. pele e subcutâneo   3852    0.62    3.84
18   18. D. infl. órgãos pélvicos fem.   1154    0.19    1.15
19         19. Úlcera gastrointestinal   2261    0.37    2.26
20               20. Pré-natal e parto   2260    0.37    2.25
21                          Total CSAP 100228   16.23  100.00
22                            Não-CSAP 517199   83.77      NA
23                Total de internações 617427  100.00      NA
```

### Calcular taxas

**Exemplo: cálculo das taxas brutas de ICSAP por grupo de causa em Cerro
Largo, RS, 2021:**

O código IBGE (os seis primeiros dígitos) de Cerro Largo é “430520”.

#### As ICSAP

Selecionamos as informações sobre residentes de Cerro Largo em nosso
banco de dados da AIH em 2021.

``` r
claih <- AIHRS2021 %>% 
  filter(MUNIC_RES == "430520") %>% 
  droplevels() %>% 
  csapAIH()
Importados 753 registros.
Excluídos 46 (6,1%) registros de procedimentos obstétricos.
Excluídos NA (NA%) registros de AIH de longa permanência.
Exportados 707 (93,9%) registros.
```

#### A população

Desde que o DATASUS interrompeu a publicação dos arquivos com as
estimativas populacionais por sexo e faixa etária para os municípios
brasileiros (último arquivo no FTP é da população em 2012), passou a ser
necessária a tabulação no TABNET e posterior leitura dos dados no
programa de análise. Ano passado (2022) Raphael Saldanha dispôs-se ao
trabalho de fazer as muitas [tabulações
necessárias](http://tabnet.datasus.gov.br/cgi/deftohtm.exe?ibge/cnv/popsvsbr.def)
e nos brindou outro excelente e muito esperado pacote preenchendo essa
lacuna: [brpop](https://rfsaldanha.github.io/brpop/), com as as
estimativas da população por sexo e faixa etária para os municípios
brasileiros, de 2000 a 2021 ([Nota
técnica](http://tabnet.datasus.gov.br/cgi/IBGE/NT-POPULACAO-RESIDENTE-2000-2021.PDF)).

Entretanto, as tabelas no pacote *brpop* têm o total (a soma da
população nas diferentes faixas etárias), e os rótulos das faixas
etárias são longos e estão em inglês, por isso resolvi criar outra
função (`popbr2000_2021`) que retornasse a população com os rótulos em
português e apenas com a população estimada em cada faixa etária (sem o
total). Assim, a população estimada para Cerro Largo em 2021 foi
capturada com o seguinte comando,

``` r
clpop <- csapAIH::popbr2000_2021(2021, munic = "430520")
```

Com o pacote brpop, teríamos de acrescentar o filtro de exclusão da
categoria “Total” na faixa etária e os resultados seriam os mesmos,
porém com outra estrutura do objeto e outros rótulos de categorias:

``` r
clpop %>% 
  group_by(fxetar5, sexo) %>% 
  summarise(sum(pop))
`summarise()` has grouped output by 'fxetar5'. You can override using the
`.groups` argument.
# A tibble: 34 × 3
# Groups:   fxetar5 [17]
   fxetar5 sexo  `sum(pop)`
   <fct>   <fct>      <int>
 1 0-4     masc         390
 2 0-4     fem          372
 3 5-9     masc         417
 4 5-9     fem          344
 5 10-14   masc         434
 6 10-14   fem          370
 7 15-19   masc         493
 8 15-19   fem          431
 9 20-24   masc         552
10 20-24   fem          503
# ℹ 24 more rows
brpop::mun_sex_pop() %>% 
  filter(mun == "430520", year == 2021, age_group != "Total") %>% 
  group_by(age_group, sex) %>% 
  summarise(sum(pop))
`summarise()` has grouped output by 'age_group'. You can override using the
`.groups` argument.
# A tibble: 34 × 3
# Groups:   age_group [17]
   age_group           sex    `sum(pop)`
   <chr>               <chr>       <int>
 1 From 0 to 4 years   Female        372
 2 From 0 to 4 years   Male          390
 3 From 10 to 14 years Female        344
 4 From 10 to 14 years Male          417
 5 From 15 to 19 years Female        370
 6 From 15 to 19 years Male          434
 7 From 20 to 24 years Female        431
 8 From 20 to 24 years Male          493
 9 From 25 to 29 years Female        503
10 From 25 to 29 years Male          552
# ℹ 24 more rows
```

#### A tabela com as taxas

``` r
cte <- 1e5
tabCSAP(claih$grupo) %>% 
  mutate(taxa = casos / sum(clpop$pop)*cte) %>% 
  knitr::kable(format.args = list(decimal.mark = ",", big.mark = "."), digits = 1, 
               caption = paste("ICSAP em Cerro Largo, RS, 2021. Taxas por", 
                               Rcoisas::formatL(cte, digits = 0), "hab.")) 
```

| grupo                                 | casos | perctot | percsap |    taxa |
|:--------------------------------------|------:|--------:|--------:|--------:|
| 1\. Prev. vacinação e cond. evitáveis |     2 |     0,3 |     1,9 |    14,0 |
| 2\. Gastroenterite                    |     6 |     0,8 |     5,6 |    42,1 |
| 3\. Anemia                            |     0 |     0,0 |     0,0 |     0,0 |
| 4\. Defic. nutricionais               |     0 |     0,0 |     0,0 |     0,0 |
| 5\. Infec. ouvido, nariz e garganta   |     2 |     0,3 |     1,9 |    14,0 |
| 6\. Pneumonias bacterianas            |    20 |     2,8 |    18,5 |   140,4 |
| 7\. Asma                              |     1 |     0,1 |     0,9 |     7,0 |
| 8\. Pulmonares (DPOC)                 |    13 |     1,8 |    12,0 |    91,3 |
| 9\. Hipertensão                       |     1 |     0,1 |     0,9 |     7,0 |
| 10\. Angina                           |     3 |     0,4 |     2,8 |    21,1 |
| 11\. Insuf. cardíaca                  |    13 |     1,8 |    12,0 |    91,3 |
| 12\. Cerebrovasculares                |     7 |     1,0 |     6,5 |    49,1 |
| 13\. Diabetes mellitus                |    10 |     1,4 |     9,3 |    70,2 |
| 14\. Epilepsias                       |     2 |     0,3 |     1,9 |    14,0 |
| 15\. Infec. urinária                  |    24 |     3,4 |    22,2 |   168,5 |
| 16\. Infec. pele e subcutâneo         |     4 |     0,6 |     3,7 |    28,1 |
| 17\. D. infl. órgãos pélvicos fem.    |     0 |     0,0 |     0,0 |     0,0 |
| 18\. Úlcera gastrointestinal          |     0 |     0,0 |     0,0 |     0,0 |
| 19\. Pré-natal e parto                |     0 |     0,0 |     0,0 |     0,0 |
| Total CSAP                            |   108 |    15,3 |   100,0 |   758,3 |
| Não-CSAP                              |   599 |    84,7 |      NA | 4.205,6 |
| Total de internações                  |   707 |   100,0 |      NA | 4.963,8 |

ICSAP em Cerro Largo, RS, 2021. Taxas por 100.000 hab.

### Gráficos

``` r
gr <- desenhaCSAP(csap, titulo = "auto", onde = "RS", quando = 2018, limsup = .18)
gr
```

<img src="man/figures/README-unnamed-chunk-24-1.png" width="50%" style="display: block; margin: auto;" />

#### Estratificado por categorias de outra variável presente no banco de dados:

Observe que ao estratificar o gráfico mantém a ordenação por frequência
da variável em seu todo, sem a estratificação, quando o argumento
`ordenar = TRUE`(padrão).

``` r
rot <- ggplot2::as_labeller(c("masc" = "Masculino", "fem" = "Feminino", "(all)" = "Total"))
gr + ggplot2::facet_grid(~ sexo, margins = TRUE, labeller = rot)

gr + ggplot2::facet_wrap(~ munres == "431490", 
                         labeller = ggplot2::as_labeller(c("FALSE" = "Interior", 
                                                           "TRUE" = "Capital")))
```

<img src="man/figures/README-unnamed-chunk-25-1.png" width="45%" style="display: block; margin: auto;" /><img src="man/figures/README-unnamed-chunk-25-2.png" width="45%" style="display: block; margin: auto;" />

``` r
 DORS2021 %>% 
  filter(!is.na(SEXO)) %>% 
  desenhaCSAP(x.size = 7, y.size = 8) + 
    ggplot2::facet_grid(SEXO ~ fxetar3)
```

<div class="figure">

<img src="man/figures/README-unnamed-chunk-26-1.png" alt="Mortalidade por CSAP por grupos de causa, por sexo e faixa etária. RS, 2021." width="80%" />
<p class="caption">
Mortalidade por CSAP por grupos de causa, por sexo e faixa etária. RS,
2021.
</p>

</div>

------------------------------------------------------------------------

***Veja o manual do pacote em:***
<https://github.com/fulvionedel/csapAIH/blob/master/docs/csapAIH_0.0.4.2.pdf>

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->

# Agradecimentos

Agradeço a todxs os usuárixs do pacote, particularmente a quem informa
problemas e sugere mudanças, como @laiovictor e @igortadeu, e (muito!!)
a quem apresenta soluções, como @denis-or.

E, sempre, meus profundos agradecimentos a

- Daniela Petruzalek, pelo pacote
  [read.dbc](https://cran.r-project.org/web/packages/read.dbc/index.html);
  e
- A Raphael Saldanha, pelos pacotes
  [microdatasus](https://github.com/rfsaldanha/microdatasus) e
  [brpop](https://github.com/rfsaldanha/brpop).

# Referências

<div id="refs" class="references csl-bib-body">

<div id="ref-Nedel2011" class="csl-entry">

<span class="csl-left-margin">1. </span><span
class="csl-right-inline">Nedel FB, Facchini LA, Bastos JL, Martín-Mateo
M. <span class="nocase">Conceptual and methodological aspects in the
study of hospitalizations for ambulatory care sensitive
conditions</span>. Ciência & Saúde Coletiva \[Internet\]. 2011;16(SUPPL.
1):1145–54. Available from:
<http://www.scielo.br/j/csc/a/4BYnRnKGjwdhYstBkKk7X7M/?lang=en></span>

</div>

<div id="ref-MS2008lista" class="csl-entry">

<span class="csl-left-margin">2. </span><span
class="csl-right-inline">Brasil. Ministério da Saúde. Secretaria de
Atenção à Saúde. <span class="nocase">Portaria Nº 221, de 17 de abril de
2008.</span> \[Internet\]. Ministério da Saúde; 2008. p. 70. Available
from:
<https://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html></span>

</div>

<div id="ref-Alfradique2009" class="csl-entry">

<span class="csl-left-margin">3. </span><span
class="csl-right-inline">Alfradique ME, Bonolo P de F, Dourado I,
Lima-Costa MF, Macinko J, Mendonça CS, et al. <span
class="nocase">Interna<span class="nocase">ç</span><span
class="nocase">õ</span>es por condi<span class="nocase">ç</span><span
class="nocase">õ</span>es sens<span class="nocase">í</span>veis <span
class="nocase">à</span> aten<span class="nocase">ç</span><span
class="nocase">ã</span>o prim<span class="nocase">á</span>ria: a
constru<span class="nocase">ç</span><span class="nocase">ã</span>o da
lista brasileira como ferramenta para medir o desempenho do sistema de
sa<span class="nocase">ú</span>de (Projeto ICSAP - Brasil)</span>.
Cadernos de Saúde Pública \[Internet\]. 2009 Jun;25(6):1337–49.
Available from:
<https://www.scielo.br/j/csp/a/y5n975h7b3yW6ybnk6hJwft/?lang=pt></span>

</div>

<div id="ref-Nedel2008" class="csl-entry">

<span class="csl-left-margin">4. </span><span
class="csl-right-inline">Nedel FB, Facchini LA, Martín-Mateo M, Vieira
LAS, Thumé E. <span class="nocase">Programa Sa<span
class="nocase">ú</span>de da Fam<span class="nocase">í</span>lia e
condi<span class="nocase">ç</span><span class="nocase">õ</span>es
sens<span class="nocase">í</span>veis <span class="nocase">à</span>
aten<span class="nocase">ç</span><span class="nocase">ã</span>o
prim<span class="nocase">á</span>ria, Bag<span class="nocase">é</span>
(RS)</span>. Rev Saude Publica \[Internet\]. 2008;42(6):1041–52.
Available from:
<https://www.scielo.br/j/rsp/a/NHNcRYsk8kwv4KYZqRD6S8c/?lang=pt></span>

</div>

<div id="ref-NedelTese" class="csl-entry">

<span class="csl-left-margin">5. </span><span
class="csl-right-inline">Nedel FB. <span class="nocase">Interna<span
class="nocase">ç</span><span class="nocase">õ</span>es hospitalares
evit<span class="nocase">á</span>veis pela aten<span
class="nocase">ç</span><span class="nocase">ã</span>o prim<span
class="nocase">á</span>ria: estudo do impacto do Programa Sa<span
class="nocase">ú</span>de da Fam<span class="nocase">ı́</span>lia sobre
as interna<span class="nocase">ç</span><span class="nocase">õ</span>es
por Condi<span class="nocase">ç</span><span class="nocase">õ</span>es
Sens<span class="nocase">ı́</span>veis <span class="nocase">à</span>
Aten<span class="nocase">ç</span><span class="nocase">ã</span>o
Prim<span class="nocase">á</span>ria no Rio Grande do Sul,
Brasil.</span> \[Internet\] \[PhD thesis\]. \[Pelotas, RS\]:
Universidade Federal de Pelotas - UFPel; 2009. p. 279. Available from:
<http://repositorio.ufpel.edu.br:8080/bitstream/prefix/3654/1/tese%20nedel.pdf></span>

</div>

<div id="ref-Nedel2017" class="csl-entry">

<span class="csl-left-margin">6. </span><span
class="csl-right-inline">Nedel FB. <span class="nocase">csapAIH: uma
fun<span class="nocase">ç</span><span class="nocase">ã</span>o para a
classifica<span class="nocase">ç</span><span class="nocase">ã</span>o
das condi<span class="nocase">ç</span><span class="nocase">õ</span>es
sens<span class="nocase">í</span>veis <span class="nocase">à</span>
aten<span class="nocase">ç</span><span class="nocase">ã</span>o
prim<span class="nocase">á</span>ria no programa estat<span
class="nocase">í</span>stico R</span>. Epidemiologia e Serviços de Saúde
\[Internet\]. 2017;26(01):199–209. Available from:
<https://www.scielo.br/j/ress/a/cLvdvwyTpy8cQh5LnhJfd3G/?lang=pt></span>

</div>

<div id="ref-Nedel2019" class="csl-entry">

<span class="csl-left-margin">7. </span><span
class="csl-right-inline">Nedel FB. <span class="nocase">Pacote csapAIH:
a Lista Brasileira de Interna<span class="nocase">ç</span><span
class="nocase">õ</span>es por Condi<span class="nocase">ç</span><span
class="nocase">õ</span>es Sens<span class="nocase">í</span>veis <span
class="nocase">à</span> Aten<span class="nocase">ç</span><span
class="nocase">ã</span>o Prim<span class="nocase">á</span>ria no
programa R</span>. Epidemiologia e Serviços de Saúde \[Internet\]. 2019
Sep;28(2):e2019084. Available from:
<https://www.scielo.br/j/ress/a/7XsGCYRVdD6PZxPzmNCFqvp/abstract/?lang=pt></span>

</div>

<div id="ref-OPS2014" class="csl-entry">

<span class="csl-left-margin">8. </span><span
class="csl-right-inline">Organización Panamericana de la Salud (OPS).
<span class="nocase">Compendio de indicadores del impacto y resultados
intermedios. Plan estrat<span class="nocase">é</span>gico de la OPS
2014-2019: "En pro de la salud: Desarrollo sostenible y equidad"</span>
\[Internet\]. OPS, editor. Washington; 2014. Available from:
<https://www.paho.org/hq/dmdocuments/2016/ops-pe-14-19-compendium-indicadores-nov-2014.pdf></span>

</div>

<div id="ref-brpopref" class="csl-entry">

<span class="csl-left-margin">9. </span><span
class="csl-right-inline">Saldanha R. Brpop: Brazilian population
estimatives \[Internet\]. 2022. Available from:
<https://CRAN.R-project.org/package=brpop></span>

</div>

<div id="ref-readdbc" class="csl-entry">

<span class="csl-left-margin">10. </span><span
class="csl-right-inline">Petruzalek D. Read.dbc: Read data stored in DBC
(compressed DBF) files \[Internet\]. 2016. Available from:
<https://CRAN.R-project.org/package=read.dbc></span>

</div>

<div id="ref-Saldanha2019" class="csl-entry">

<span class="csl-left-margin">11. </span><span
class="csl-right-inline">Saldanha R de F, Bastos RR, Barcellos C. <span
class="nocase">Microdatasus: pacote para download e pr<span
class="nocase">é</span>-processamento de microdados do Departamento de
Inform<span class="nocase">á</span>tica do SUS (DATASUS)</span>.
Cadernos de Saúde Pública \[Internet\]. 2019;35(9):e00032419. Available
from:
<https://www.scielo.br/j/csp/a/gdJXqcrW5PPDHX8rwPDYL7F/?lang=pt></span>

</div>

</div>
