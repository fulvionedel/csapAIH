# O pacote csapAIH

``` r

library(csapAIH)
library(dplyr) 
```

O pacote csapAIH foi criado para facilitar a distribuição da função
[`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
então sua única função, para a classificação de códigos da Classificação
Internacional de Doenças – 10ª Revisão (CID-10) segundo a Lista
Brasileira de Condições Sensíveis à Atenção Primária, publicada em
Portaria Ministerial em 2008(Brasil. Ministério da Saúde. Secretaria de
Atenção à Saúde 2008). A função classifica qualquer vetor com códigos da
CID-10, mas é particularmente voltada ao trabalho com os arquivos
“RD\*.DBC” das Bases de Dados do Sistema de Informação em Saúde
(BD-SIH/SUS), com argumentos facilitando a extração e manejo dos dados
nesse sentido.(Nedel 2017)

A construção da lista brasileira foi relatada em artigo
científico.(Alfradique et al. 2009) Entretanto, a lista publicada na
Portaria Ministerial(Brasil. Ministério da Saúde. Secretaria de Atenção
à Saúde 2008) difere do artigo pelo agrupamento dos dois primeiros
grupos (*1. Doenças imunizáveis* e *2. Condições evitáveis*). Há então
duas versões da lista, a da Portaria Ministerial, com 19 grupos, e a que
desmembra o primeiro grupo em dois, totalizando então 20 grupos
(Tabela). Não há diferença nos códigos considerados. A versão com o
desdobramento do primeiro grupo da Portaria e, consequentemente, com 20
grupos ao final, é a recomendada pela Organização Panamericana da Saúde
(OPAS).(Organización Panamericana de la Salud (OPS) 2014)

``` r

ms <- nomesgruposCSAP()
artigo <- nomesgruposCSAP(lista = "Alfradique")
cbind(ms = c(ms[1], "-", ms[-1]), artigo) |> 
  kableExtra::kable(col.names = c("Portaria Ministerial", "Alfradique et al."), 
                    caption = "Grupos da Lista Brasileira de ICSAP segundo a fonte de publicação.")
```

| Portaria Ministerial                  | Alfradique et al.                   |
|:--------------------------------------|:------------------------------------|
| 1\. Prev. vacinação e cond. evitáveis | 1\. Prev. por vacinação             |
| \-                                    | 2\. Outras cond. evitáveis          |
| 2\. Gastroenterites                   | 3\. Gastroenterites                 |
| 3\. Anemia                            | 4\. Anemia                          |
| 4\. Defic. nutricionais               | 5\. Defic. nutricionais             |
| 5\. Infec. ouvido, nariz e garganta   | 6\. Infec. ouvido, nariz e garganta |
| 6\. Pneumonias bacterianas            | 7\. Pneumonias bacterianas          |
| 7\. Asma                              | 8\. Asma                            |
| 8\. Pulmonares                        | 9\. Pulmonares                      |
| 9\. Hipertensão                       | 10\. Hipertensão                    |
| 10\. Angina                           | 11\. Angina                         |
| 11\. Insuf. cardíaca                  | 12\. Insuf. cardíaca                |
| 12\. Cerebrovasculares                | 13\. Cerebrovasculares              |
| 13\. Diabetes mellitus                | 14\. Diabetes mellitus              |
| 14\. Epilepsias                       | 15\. Epilepsias                     |
| 15\. Infec. urinária                  | 16\. Infec. urinária                |
| 16\. Infec. pele e subcutâneo         | 17\. Infec. pele e subcutâneo       |
| 17\. D. infl. órgãos pélvicos fem.    | 18\. D. infl. órgãos pélvicos fem.  |
| 18\. Úlcera gastrointestinal          | 19\. Úlcera gastrointestinal        |
| 19\. Pré-natal e parto                | 20\. Pré-natal e parto              |

Grupos da Lista Brasileira de ICSAP segundo a fonte de publicação.
{.table}

A função
[`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
permite a classificação segundo as duas versões, definidas pelo
argumento “`lista`”. Esse argumento aparece em
[`desenhaCSAP()`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)
para desenhar o gráfico adequado. As funções
[`tabCSAP()`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md)
e
[`descreveCSAP()`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md)
identificam a lista utilizada e portanto não têm o argumento. Os grupos
em cada lista podem ser citados pela função
[`nomesgruposCSAP()`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md),
em português, espanhol ou inglês.

Os “arquivos da AIH” são disponibilizados pelo DATASUS em arquivos nos
formatos DBF, CSV e DBC (arquivo DBC comprimido pelo DATASUS)

``` r

data.frame(arquivo = c("RDRS1801.dbf", "RDRS1801.csv", "RDRS1801.dbc"),
           tamanho = c(round(file.size("../../data-raw/RDRS1801.dbf") / 1024^2, 1),
                       round(file.size("../../data-raw/RDRS1801.csv") / 1024^2, 1),
                       round(file.size("../../data-raw/RDRS1801.dbc") / 1024^2, 1)))

csapAIH("../../data-raw/RDRS1801.dbf")
csapAIH("../../data-raw/RDRS1801.csv", sep = ",")
csapAIH("../../data-raw/RDRS1801.dbc")
```

Atualmente, a forma mais fácil

## ICSAP no RS, 2023 a 2024

A função `fetchcsap` baixa os arquivos da AIH no DATASUS e entrega um
banco de dados com a classificação da internação segundo a lista
brasileira de ICSAP e outras ações (veja a ajuda da função digitando
“`?fetchsap`” no console).

Assim, com uma conexão de internet ativa, podemos conhecer as ICSAP do
RS de 2023 a 2024 com o seguinte comando:

``` r
# icsaprs <- fetchcsap(2023, 2024, uf = "RS")
icsaprs <- fetchcsap(2018, mesfim = 1, periodo = "c", uf = "RS")
 [36mℹ [39m Discovering available files on DataSUS...
 [36mℹ [39m Preparing to download and read 1 DataSUS file...
 [36mℹ [39m Downloading [1/1]  [34m [34mRDRS1801.dbc [34m [39m...
 [36mℹ [39m Reading [1/1]  [34m [34mRDRS1801.dbc [34m [39m...
 [32m✔ [39m Downloaded and read 1 of 1 DataSUS file.
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
```

Vemos nas mensagens de *download* que foram baixados os arquivos até
junho de 2025 (’RDRS2506.dbc) e que foram “importados 60.529 registros”,
excluídos alguns registros e finalmente “exportados 51.923 registros”,
que representam 85,8% de todas as internações do período. Esse resumo de
importação é guardado como atributo do banco de dados e pode ser
recuperado com as funções [`attr()`](https://rdrr.io/r/base/attr.html)
ou [`attributes()`](https://rdrr.io/r/base/attributes.html):

``` r
attr(icsaprs, "resumo")
        acao  freq  perc                                  objeto
1 Importados 60529 100.0                              registros.
2  Excluídos  8240  13.6 registros de procedimentos obstétricos.
3  Excluídos   366   0.6  registros de AIH de longa permanência.
4 Exportados 51923  85.8                              registros.
attributes(icsaprs)$resumo
        acao  freq  perc                                  objeto
1 Importados 60529 100.0                              registros.
2  Excluídos  8240  13.6 registros de procedimentos obstétricos.
3  Excluídos   366   0.6  registros de AIH de longa permanência.
4 Exportados 51923  85.8                              registros.
```

Em tabela para apresentação:

``` r

attributes(icsaprs)$resumo |>
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

## Referências

Alfradique, Maria Elmira, Palmira de Fátima Bonolo, Inês Dourado, et al.
2009. “Internações por condições sensíveis à atenção primária: a
construção da lista brasileira como ferramenta para medir o desempenho
do sistema de saúde (Projeto ICSAP - Brasil).” *Cadernos de Saúde
Pública* 25 (6): 1337–49.
<https://doi.org/10.1590/S0102-311X2009000600016>.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. 2008.
*Portaria Nº 221, de 17 de abril de 2008.* Ministério da Saúde.
<https://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html>.

Nedel, Fúlvio Borges. 2017. “csapAIH: uma função para a classificação
das condições sensíveis à atenção primária no programa estatístico R.”
*Epidemiologia e Serviços de Saúde* 26 (01): 199–209.
<https://doi.org/10.5123/S1679-49742017000100021>.

Organización Panamericana de la Salud (OPS). 2014. *Compendio de
indicadores del impacto y resultados intermedios. Plan estratégico de la
OPS 2014-2019: "En pro de la salud: Desarrollo sostenible y equidad"*.
Edited by OPS. Washington.
<https://www.paho.org/hq/dmdocuments/2016/ops-pe-14-19-compendium-indicadores-nov-2014.pdf>.
