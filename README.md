# csapAIH
Classificar Condições Sensíveis à Atenção Primária

### Apresentação

Pacote em **R** para a classificação de códigos da CID-10 (Classificação Internacional de Doenças, 10ª Revisão) segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária (CSAP). É particularmente voltado ao trabalho com as bases de dados do Sistema de Informações Hospitalares do SUS, o Sistema Único de Saúde brasileiro. Tais bases (BD-SIH/SUS) contêm os "arquivos da AIH" (`RD??????.DBC`), que podem ser expandidos para o formato DBF (`RD??????.DBF`), com as informações de cada hospitalização ocorrida pelo SUS num período determinado. Assim, embora o pacote permita a classificação de qualquer listagem de códigos da CID-10, tem também algumas funcionalidades para facilitar o trabalho com os "arquivos da AIH".

### Justificativa

A hospitalização por CSAP é um indicador da qualidade do sistema de saúde em sua primeira instância de atenção, uma vez que a internação por tais condições ---pneumonia, infecção urinária, sarampo, diabetes etc.---  só acontecerá se houver uma falha do sistema nesse âmbito de atenção, seja por não prevenir a ocorrência da doença (caso das doenças preveníveis por vacinação, como o sarampo), não diagnosticá-la ou tratá-la a tempo (como na pneumonia ou infeccão urinária) ou por falhar no seu controle clínico (como é o caso da diabete).

O Ministério da Saúde brasileiro estabeleceu em 2008, após amplo processo de validação, uma lista com várias causas de internação hospitalar consideradas CSAP, definindo em portaria a Lista Brasileira. A Lista envolve vários códigos da CID-10 e classifica as CSAP em 19 subgrupos de causa, o que torna complexa e trabalhosa a sua decodificação. Há alguns anos o Departamento de Informática do SUS (DATASUS) incluiu em seu excelente programa de tabulação de dados TabWin a opção de tabulação por essas causas, apresentando sua frequência segundo a tabela definida pelo usuário.

Entretanto, muitas vezes a pesquisa exige a classificação de cada internação individual como uma variável na base de dados. E não conheço outro programa ou *script* (além do que tive de escrever em minha tese) que automatize esse trabalho.

### Instalação

O pacote `csapAIH` pode ser instalado no **R** de duas maneiras:
  
  * com a função `install.packages()` sobre os arquivos de instalação no SourceForge:
    * para Linux e Mac:
    
          install.packages( "https://sourceforge.net/projects/csapaih/files/csapAIH-v.0.0.3.tar.gz/download", 
                            type = "source", repos = NULL) 
  
    * para Windows: 
    
          install.packages( "https://sourceforge.net/projects/csapaih/files/csapAIH-v.0.0.3.zip/download", 
                            type = "source", repos = NULL)
  
  ou
  
  * através do pacote `devtools`sobre os arquivos-fonte da função em desenvolvimento, no GitHub:
      
        install.packages("devtools") # desnecessário se o pacote devtools já estiver instalado
        devtools::install_github("fulvionedel/csapAIH")



### Conteúdo

Na sua primeira versão, o pacote `csapAIH` continha apenas uma função, homônima: `csapAIH`. 

Na versão 0.0.2, foram acrescentadas as funções `descreveCSAP`, `desenhaCSAP` e `nomesgruposCSAP`, para a representação gráfica e tabular das CSAP pela lista brasileira. Esta versão também permite a leitura de arquivos da AIH em formato .DBC, sem necessidade de prévia expansão a .DBF. Isso é possível pelo uso do pacote `read.dbc`, de Daniela Petruzalek (https://cran.r-project.org/web/packages/read.dbc/index.html). 

Agora na versão 0.0.3, a função `desenhaCSAP` permite o detalhamento do gráfico por categorias de outros fatores do banco de dados, com o uso das funções `facet_wrap()` e `facet_grid()`, de `ggplot2`, mas permite o desenho de gráficos com as funções básicas, sem a instalação do pacote `ggplot2`. Foi ainda criada uma função para o cálculo da idade nos arquivos da AIH: a função **idadeSUS** é usada internamente por `csapAIH` e pode ser chamada pelo usuário para calcular a idade sem a necessidade de classificar as CSAP.

### Dependências

A leitura de arquivos .DBC exige a instalação prévia do pacote `read.csap`. Sua falta não impede o funcionamento das demais funções do pacote (inclusive de leitura, mas em outro formato). A função `desenhaCSAP` tem melhor desempenho com o pacote `ggplot2` instalado, mas sua instalação não é necessária para seu funcionamento.

### Exemplos de uso
#### Leitura dos arquivos

  - A partir de um arquivo "RD??????.DBF" salvo no mesmo diretório da sessão de trabalho do **R**:
  
        csap <- csapAIH::csapAIH("RD??????.DBF")

- A partir de um arquivo "RD??????.DBC" salvo no mesmo diretório da sessão de trabalho do **R**:
  
        csap <- csapAIH::csapAIH("RD??????.DBC")
  
  - A paritr de um banco de dados com a estrutura da AIH já carregado no ambiente de trabalho:
  
        csap <- csapAIH::csapAIH(bancodedados)
  
  - A partir de uma variável com códigos da CID-10:
  
        csap <- csapAIH::csapAIH(variavel)
 
 #### Apresentação de resultados 

   csap <- csapAIH("RDRS1801.dbc")
        Importados 60.488 registros.
        Excluídos 8.239 (13,6%) registros de procedimentos obstétricos.
        Excluídos 366 (0,6%) registros de AIH de longa permanência.
        Exportados 51.883 (85,8%) registros.
       
 **Tabela "bruta"**
 
    descreveCSAP(csap)
                                     Grupo  Casos %Total %CSAP
    1                      1.Prev. vacinação    117   0,23  1,08
    2                       2.Gastroenterite    798   1,54  7,36
    3                               3.Anemia     73   0,14  0,67
    4                      4.Def. nutricion.    241   0,46  2,22
    5      5.Infec. ouvido, nariz e garganta    168   0,32  1,55
    6               6.Pneumonias bacterianas    653   1,26  6,02
    7                                 7.Asma    234   0,45  2,16
    8                    8.Pulmonares (DPOC)  1.209   2,33 11,15
    9                          9.Hipertensão    146   0,28  1,35
    10                             10.Angina  1.004   1,94  9,26
    11                    11.Insuf. cardíaca  1.393   2,68 12,84
    12                  12.Cerebrovasculares  1.373   2,65 12,66
    13                  13.Diabetes mellitus    739   1,42  6,81
    14                         14.Epilepsias    330   0,64  3,04
    15                    15.Infec. urinária  1.358   2,62 12,52
    16           16.Infec. pele e subcutâneo    459   0,88  4,23
    17 17.D. infl. órgãos pélvicos femininos    133   0,26  1,23
    18            18.Úlcera gastrointestinal    195   0,38  1,80
    19                  19.Pré-natal e parto    222   0,43  2,05
    20                            Total CSAP 10.845  20,90   100
    21                              não-CSAP 41.038  79,10    --
    22                  Total de internações 51.883    100    --

**Tabela para apresentação ou impressão (com a função `kable`, do pacote `knitr`)**

    knitr::kable(descreveCSAP(csap), align = c('l', rep('r', 3)))

|Grupo                                 |  Casos| %Total| %CSAP|
|:-------------------------------------|------:|------:|-----:|
|1.Prev. vacinação                     |    118|   0,23|  1,09|
|2.Gastroenterite                      |    802|   1,54|  7,38|
|3.Anemia                              |     73|   0,14|  0,67|
|4.Defic. nutricionais                 |    241|   0,46|  2,22|
|5.Infec. ouvido, nariz e garganta     |    168|   0,32|  1,55|
|6.Pneumonias bacterianas              |    653|   1,26|  6,01|
|7.Asma                                |    234|   0,45|  2,15|
|8.Pulmonares (DPOC)                   |  1.213|   2,34| 11,17|
|9.Hipertensão                         |    147|   0,28|  1,35|
|10.Angina                             |  1.005|   1,94|  9,25|
|11.Insuf. cardíaca                    |  1.394|   2,68| 12,83|
|12.Cerebrovasculares                  |  1.373|   2,64| 12,64|
|13.Diabetes mellitus                  |    743|   1,43|  6,84|
|14.Epilepsias                         |    331|   0,64|  3,05|
|15.Infec. urinária                    |  1.360|   2,62| 12,52|
|16.Infec. pele e subcutâneo           |    459|   0,88|  4,22|
|17.D. infl. órgãos pélvicos femininos |    133|   0,26|  1,22|
|18.Úlcera gastrointestinal            |    195|   0,38|  1,79|
|19.Pré-natal e parto                  |    222|   0,43|  2,04|
|Total CSAP                            | 10.864|  20,92|   100|
|não-CSAP                              | 41.059|  79,08|    --|
|Total de internações                  | 51.923|    100|    --|


**Gráfico**

gr <- desenhaCSAP(csap, titulo = "auto", onde = "RS")

  gr
![desenhaCSAP(csap, titulo = "auto", onde = "RS")](https://github.com/fulvionedel/csapAIH/blob/master/docs/desenhaCSAPRS2018.jpeg) 
  
*Estratificado por categoria de outra variável presente no banco de dados:*
  
  gr + ggplot2::facet_grid(~sexo)
  
![gr + ggplot2::facet_grid(~sexo)](https://github.com/fulvionedel/csapAIH/blob/master/docs/desenhaCSAPRS2018sexo.jpeg)  


> gr + ggplot2::facet_wrap(~ munres == "431490", 
                           labeller = as_labeller(c("FALSE" = "Interior", "TRUE" = "Capital")))

![gr + ggplot2::facet_grid(~munres)](https://github.com/fulvionedel/csapAIH/blob/master/docs/desenhaCSAPRS2018capital.jpeg)

***Veja o manual do pacote para mais detalhes:*** 
https://github.com/fulvionedel/csapAIH/blob/master/docs/csapAIH_0.0.3.pdf
 
