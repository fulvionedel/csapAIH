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

Os “arquivos da AIH” são disponibilizados pelo DATASUS em arquivos nos
formatos DBF, CSV e DBC (arquivo DBF comprimido pelo DATASUS). Arquivos
nesses formatos são importados por
[`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
sem necessidade de importação prévia do arquivo para leitura dos dados.
Para os arquivos em CSV deve-se indicar o separador, se vírgula (“,”) ou
ponto-e-vírgula (“;”). Os arquivos DBC são lidos pela função
[`read.dbc::read.dbc()`](https://rdrr.io/pkg/read.dbc/man/read.dbc.html).

Para os “arquivos da AIH”, não é necessária outra informação que o
*path* do arquivo, ou o nome do *data frame*, se for um objeto no espaço
de trabalho. A função retorna uma mensagem com o número de registros
importados, salva como atributo do banco de dados criado.

``` r
csapAIH("../../data-raw/RDRS1801.dbf") 
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.

csapAIH("../../data-raw/RDRS1801.csv", sep = ",")
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.

csapAIH("../../data-raw/RDRS1801.dbc")
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
```

Não obstante, os arquivos RD\* ocupam muito espaço em disco, apesar da
grande compressão do formato DBC, e pode ser preferível baixar o arquivo
da internet, fazer o processamento desejado e então apagá-lo.

``` r

data.frame(arquivo = c("RDRS1801.dbf", "RDRS1801.csv", "RDRS1801.dbc"),
           tamanho = c(round(file.size("../../data-raw/RDRS1801.dbf") / 1024^2, 1),
                       round(file.size("../../data-raw/RDRS1801.csv") / 1024^2, 1),
                       round(file.size("../../data-raw/RDRS1801.dbc") / 1024^2, 1))) |> 
  kableExtra::kable(caption = "Tamanho do arquivo segundo o formato disponibilizado.", 
                    format.args = list(decimal.mark = ","), 
                    col.names = c("Arquivo", "Tamanho (MB)")) |> 
  kableExtra::kable_styling(full_width = FALSE)
```

| Arquivo      | Tamanho (MB) |
|:-------------|-------------:|
| RDRS1801.dbf |         40,5 |
| RDRS1801.csv |         35,9 |
| RDRS1801.dbc |          4,5 |

Tamanho do arquivo segundo o formato disponibilizado. {.table .table
style="width: auto !important; margin-left: auto; margin-right: auto;"}

Para esses casos foi criada a função
[`fetchcsap()`](https://fulvionedel.github.io/csapAIH/reference/fetchcsap.md),
um “atalho” para `fetchdatasus()`, do pacote *microdatasus*(Saldanha
2019), que baixa os arquivos da AIH no DATASUS e então aplica
[`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
sobre o banco de dados.

Assim, com uma conexão de internet ativa, podemos conhecer as ICSAP do
RS no “mês de competência” jan/2018 com o seguinte comando, que retorna
os mesmos resultados vistos acima:

``` r
options(width = 120)
fetchcsap(2018, mesfim = 1, periodo = "comp", uf = "RS")
 [36mℹ [39m Discovering available files on DataSUS...
 [36mℹ [39m Preparing to download and read 1 DataSUS file...
 [36mℹ [39m Downloading [1/1]  [34m [34mRDRS1801.dbc [34m [39m...
 [36mℹ [39m Reading [1/1]  [34m [34mRDRS1801.dbc [34m [39m...
 [32m✔ [39m Downloaded and read 1 of 1 DataSUS file.
Importados 60.529 registros.
Excluídos 8.240 (13,6%) registros de procedimentos obstétricos.
Excluídos 366 (0,6%) registros de AIH de longa permanência.
Exportados 51.923 (85,8%) registros.
       munres munint   sexo idade fxetar5   csap    grupo    cid data.inter data.saida
       <char> <char> <fctr> <num>  <fctr> <fctr>   <fctr> <char>     <Date>     <Date>
    1: 431560 431560    fem    53   50-54    não nao-CSAP   B207 2017-11-14 2017-11-22
    2: 431560 431560    fem     0     0-4    não nao-CSAP   P704 2017-11-04 2017-11-11
    3: 431560 431560   masc     0     0-4    não nao-CSAP   P220 2017-11-03 2017-11-13
    4: 431560 431560   masc     0     0-4    não nao-CSAP   A419 2017-10-18 2017-11-08
    5: 431560 431560    fem     0     0-4    não nao-CSAP   P073 2017-11-08 2017-12-14
   ---                                                                                
51919: 430786 432280   masc    75   75-79    sim      g06   J158 2018-01-04 2018-01-10
51920: 430786 432280    fem    90  80 e +    sim      g12    I64 2018-01-15 2018-01-23
51921: 430786 432280   masc    75   75-79    não nao-CSAP   J180 2018-01-26 2018-01-29
51922: 430595 432280    fem    91  80 e +    sim      g08   J439 2018-01-02 2018-01-05
51923: 430786 432280   masc    20   20-24    não nao-CSAP   L988 2018-01-09 2018-01-13
```

O argumento `periodo = "comp"` garante que o data frame resultante
contenha todas as internações do(s) arquivo(s) RD considerados e o
período se refira, portanto, ao “mês de competência” (i.e., mês em que
foi registrado o faturamento) da internação.

Por padrão, esse argumento é `periodo = "interna"`, o que leva ao
download dos arquivos RD de até seis meses após o definido em `mesfim` e
então a seleção dos casos pela data de internação, para retornar um
banco apenas com as internações ocorridas no período definido e
registradas em até seis meses após a internação.

Veja o resultado com `periodo = "interna"` (que por ser o padrão é
desnecessário no comando):

``` r
fetchcsap(2018, mesfim = 1, uf = "RS")
 [36mℹ [39m Discovering available files on DataSUS...
 [36mℹ [39m Preparing to download and read 6 DataSUS files...
 [36mℹ [39m Downloading [1/6]  [34m [34mRDRS1801.dbc [34m [39m...
 [36mℹ [39m Reading [1/6]  [34m [34mRDRS1801.dbc [34m [39m...
 [36mℹ [39m Downloading [2/6]  [34m [34mRDRS1802.dbc [34m [39m...
 [36mℹ [39m Reading [2/6]  [34m [34mRDRS1802.dbc [34m [39m...
 [36mℹ [39m Downloading [3/6]  [34m [34mRDRS1803.dbc [34m [39m...
 [36mℹ [39m Reading [3/6]  [34m [34mRDRS1803.dbc [34m [39m...
 [36mℹ [39m Downloading [4/6]  [34m [34mRDRS1804.dbc [34m [39m...
 [36mℹ [39m Reading [4/6]  [34m [34mRDRS1804.dbc [34m [39m...
 [36mℹ [39m Downloading [5/6]  [34m [34mRDRS1805.dbc [34m [39m...
 [36mℹ [39m Reading [5/6]  [34m [34mRDRS1805.dbc [34m [39m...
 [36mℹ [39m Downloading [6/6]  [34m [34mRDRS1806.dbc [34m [39m...
 [36mℹ [39m Reading [6/6]  [34m [34mRDRS1806.dbc [34m [39m...
 [32m✔ [39m Downloaded and read 6 of 6 DataSUS files.
Importados 62.748 registros.
Excluídos 8.667 (13,8%) registros de procedimentos obstétricos.
Excluídos 324 (0,5%) registros de AIH de longa permanência.
Exportados 53.757 (85,7%) registros.
       munres munint   sexo idade fxetar5   csap    grupo    cid data.inter data.saida
       <char> <char> <fctr> <num>  <fctr> <fctr>   <fctr> <char>     <Date>     <Date>
    1: 432200 431240   masc    89  80 e +    não nao-CSAP    C61 2018-01-03 2018-01-08
    2: 432200 431240   masc    71   70-74    não nao-CSAP   N180 2018-01-02 2018-01-20
    3: 432200 431240   masc    78   75-79    não nao-CSAP   I472 2018-01-02 2018-01-07
    4: 432200 431240   masc    47   45-49    sim      g11   I509 2018-01-12 2018-01-18
    5: 432200 431240   masc    61   60-64    não nao-CSAP   N189 2018-01-13 2018-01-25
   ---                                                                                
53753: 430085 431490   masc    42   40-44    não nao-CSAP    I48 2018-01-28 2018-03-07
53754: 431350 431490   masc    23   20-24    não nao-CSAP   M532 2018-01-22 2018-01-26
53755: 430920 431490    fem    70   70-74    não nao-CSAP   H330 2018-01-19 2018-01-20
53756: 431440 431490    fem    66   65-69    não nao-CSAP   H330 2018-01-18 2018-01-19
53757: 431560 431490    fem    21   20-24    não nao-CSAP   H330 2018-01-16 2018-01-17
```

O pacote [healthbR](https://sidneybissoli.github.io/healthbR/)(Bissoli
2025) é uma nova alternativa para download de dados do SIH/SUS (entre
outros). Abaixo é exemplificado seu uso com
[`csapAIH()`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
para jan/2025.

``` r
healthbR::sih_data(2025, 1, uf = "RS") |> 
  csapAIH() |> 
  pull(data.inter) |> 
  summary()
 [1m [22m [36mℹ [39m Package  [34marrow [39m is not installed; using DATASUS directly.
 [36mℹ [39m Install  [34marrow [39m to enable the (faster) R2 backend.
 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/01...
Importados 66.998 registros.

Excluídos 6.591 (9,8%) registros de procedimentos obstétricos.

Excluídos 378 (0,6%) registros de AIH de longa permanência.

Exportados 60.029 (89,6%) registros.

healthbR::sih_data(2025, 1:6, uf = "RS") |> 
  filter(DT_INTER >= "2025-01-01", DT_INTER <= "2025-01-31") |>
  csapAIH() |> 
  pull(data.inter) |> 
  summary()
 [1m [22m [36mℹ [39m Package  [34marrow [39m is not installed; using DATASUS directly.
 [36mℹ [39m Install  [34marrow [39m to enable the (faster) R2 backend.
 [1m [22m [36mℹ [39m Downloading 6 file(s) (1 UF(s) x 1 year(s) x 6 month(s))...
 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/01...
⠙ Downloading [1/6]  [32m■■■■■■                           [39m | ETA:  1m

 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/02...
⠹ Downloading [2/6]  [32m■■■■■■■■■■■                      [39m | ETA:  1m

 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/03...
⠸ Downloading [3/6]  [32m■■■■■■■■■■■■■■■■                 [39m | ETA:  1m

 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/04...
⠼ Downloading [4/6]  [32m■■■■■■■■■■■■■■■■■■■■■            [39m | ETA: 39s

 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/05...
⠴ Downloading [5/6]  [32m■■■■■■■■■■■■■■■■■■■■■■■■■■       [39m | ETA: 21s

 [1m [22m [36mℹ [39m Downloading SIH data: RS 2025/06...
⠴ Downloading [6/6]  [32m■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  [39m | ETA:  0s

Importados 69.018 registros.

Excluídos 6.807 (9,9%) registros de procedimentos obstétricos.

Excluídos 437 (0,6%) registros de AIH de longa permanência.

Exportados 61.774 (89,5%) registros.
```

## Referências

Alfradique, Maria Elmira, Palmira de Fátima Bonolo, Inês Dourado, et al.
2009. “Internações por condições sensíveis à atenção primária: a
construção da lista brasileira como ferramenta para medir o desempenho
do sistema de saúde (Projeto ICSAP - Brasil).” *Cadernos de Saúde
Pública* 25 (6): 1337–49.
<https://doi.org/10.1590/S0102-311X2009000600016>.

Bissoli, Sidney. 2025. *healthbR: Access Brazilian Public Health Data*.
<https://github.com/SidneyBissoli/healthbR>.

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

Saldanha, Raphael de Freitas. 2019. *Microdatasus: Download and
Preprocess DataSUS Files*. <https://github.com/rfsaldanha/microdatasus>.
