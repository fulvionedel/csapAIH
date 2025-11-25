# Classificar Condições Sensíveis à Atenção Primária

Classifica códigos da 10ª Revisão da Classificação Internacional de
Doenças (CID-10) segundo a Lista Brasileira de Internação por Condições
Sensíveis à Atenção Primária e oferece outras funcionalidades,
especialmente para o manejo dos "arquivos da AIH" (RD??????.DBC;
BD-SIH/SUS).

## Usage

``` r
csapAIH(
  x,
  lista = "MS",
  grupos = TRUE,
  sihsus = TRUE,
  procobst.rm = TRUE,
  parto.rm = TRUE,
  longa.rm = TRUE,
  cep = TRUE,
  cnes = TRUE,
  arquivo = TRUE,
  sep,
  cid = NULL,
  ...
)
```

## Arguments

- x:

  alvo da função: um arquivo, banco de dados ou vetor com códigos da
  CID-10 (ver `detalhes`);

- lista:

  Lista de causas a ser considerada (v. detalhes); pode ser `"MS"`
  (padrão) para a lista publicada em portaria pelo Ministério da Saúde
  do Brasil ou "Alfradique" para a lista publicada no artigo de
  Alfradique et al.

- grupos:

  argumento lógico, obrigatório; `TRUE` (padrão) indica que as
  internações serão classificadas também em grupos de causas CSAP;

- sihsus:

  argumento lógico, obrigatório se `x` for um arquivo; `TRUE` (padrão)
  indica que o arquivo ou banco de dados a ser tabulado tem minimamente
  os seguintes campos dos arquivos da AIH:

  - DIAG_PRINC: diagnóstico principal da internação;

  - NASC: data de nascimento;

  - DT_INTER: data da internação;

  - DT_SAIDA: data da alta hospitalar;

  - COD_IDADE: código indicando a faixa etária a que se refere o valor
    registrado no campo idade;

  - IDADE: idade (tempo de vida acumulado) do paciente, na unidade
    indicada no campo COD_IDADE;

  - MUNIC_RES: município de residência do paciente;

  - MUNIC_MOV: município de internação do paciente;

  - SEXO: sexo do paciente;

  - N_AIH: número da AIH;

  - PROC_REA: procedimento realizado, segundo a tabela do SIH/SUS.

- procobst.rm:

  argumento lógico, obrigatório se `sihsus=TRUE`; `TRUE` (padrão) exclui
  as internações por procedimento obstétrico (`ver detalhes`);

- parto.rm:

  argumento lógico, obrigatório se `sihsus=TRUE`; `TRUE` (padrão) exclui
  as internações por parto (`ver detalhes`);

- longa.rm:

  argumento lógico; `TRUE` (padrão) exclui as AIH de longa permanência
  (AIH tipo 5), retornando uma mensagem com o número e proporção de
  registros excluídos e o total de registros importados; argumento
  válido apenas se `sihsus=TRUE`;

- cep:

  argumento lógico, obrigatório se `sihsus=TRUE`; `TRUE` (padrão) inclui
  no banco o Código de Endereçamento Postal do indivíduo; argumento
  válido apenas se `sihsus=TRUE`;

- cnes:

  argumento lógico, obrigatório se `sihsus=TRUE`; `TRUE` (padrão) inclui
  no banco o nº do hospital no Cadastro Nacional de Estabelecimentos de
  Saúde; argumento válido apenas se `sihsus=TRUE`;

- arquivo:

  argumento lógico, obrigatório; `TRUE` (padrão) indica que o alvo da
  função (`x`) é um arquivo; `FALSE` indica que `x` é um objeto no
  espaço de trabalho; é automaticamente marcado como `FALSE` quando `x`
  é um `factor` ou `data frame`; deve ser definido pelo usuário como
  `FALSE` apenas quando `x` contiver em seu nome as sequências "dbc",
  "dbf" ou "csv" sem que isso seja a extensão do arquivo; apenas
  arquivos com esses formatos podem ser lidos;

- sep:

  usado para a leitura de arquivos da AIH em formato CSV; pode ser ";"
  para arquivos separados por ponto-e-vírgula e com vírgula como
  separador decimal, ou "," para arquivos separados por vírgula e com
  ponto como separador decimal;

- cid:

  identifica a varivável contendo os códigos da CID-10, em bancos de
  dados sem a estrutura do SIHSUS; argumento obrigatório nesses casos;

- ...:

  permite a inclusão de argumentos das funções
  [`read.table`](https://rdrr.io/r/utils/read.table.html) e suas
  derivadas.

## Value

A função tem diferentes possibilidades de retorno, segundo a estrutura
dos dados lidos e as opções de leitura:

- Se for um arquivo ou `data frame` com a estrutura dos arquivos da AIH:

  - um `data frame` com as variáveis nº da AIH, município de residência,
    município de internação, sexo, data de nascimento, idade em anos
    completos, faixa etária detalhada, faixa etária quinquenal, data da
    internação, data da saída, procedimento realizado, cid, CSAP, grupo
    csap, CEP e CNES do hospital

    - Nesse caso, o banco resultante tem um argumento "resumo" com o
      resumo da importação de dados, segundo as opções de seleção

    - Se os argumentos `grupo`, `cep` ou `cnes` forem definidos como
      `FALSE`, o banco é construído sem essas variáveis

  - Se um fator ou data frame sem a estrutura dos arquivos da AIH:

  &nbsp;

  - Se `grupos = TRUE`: um banco de dados com as variáveis `csap` (sim
    ou não), `grupo` (subgrupo CSAP) e `cid` (código da CID-10);

  - Se `factor` e `grupos = FALSE`: um fator com as observações
    classificadas como CSAP ou não-CSAP.

## Details

- x pode ser:

  1.  um arquivo de dados armazenado num diretório;

  2.  um banco de dados, ou um vetor da classe `factor` presente como
      objeto no espaço de trabalho do R, em que uma das variáveis, ou o
      vetor, contenha códigos da CID-10.

  Se for um arquivo, o nome deve ser escrito entre aspas e com a
  extensão do arquivo (DBC, DBF ou CSV, em minúsculas ou maiúsculas). Se
  não estiver no diretório de trabalho ativo, seu nome deve ser
  precedido pelo caminho (path) até o diretório de armazenamento. Se
  estiver em outro formato, podem-se usar os argumentos da função
  [`read.table`](https://rdrr.io/r/utils/read.table.html) para leitura
  dos dados.

  Se a função for dirigida a um objeto no espaço de trabalho da classe
  `factor` ou `data.frame`, estes também são reconhecidos e o comando é
  o mesmo: `csapAIH(x)`. Se o objeto for de outra classe, como
  `character` ou `matrix`, é necessário definir o argumento "arquivo"
  como FALSE: `csapAIH(x, arquivo = FALSE)`, ou, para vetores isolados,
  defini-lo como fator: `csapAIH(as.factor(x))`.

- `lista` A Lista Brasileira de ICSAP publicada pelo Ministério da Saúde
  (Brasil, 2008) se diferencia da lista publicada pelxs construtorxs da
  lista (Alfradique et al., 2009), em um único aspecto: a Portaria
  Ministerial uniu os dois primeiros grupos de causa da lista publicada
  por Alfradique et al. – doenças evitáveis por vacinação e doenças
  evitáveis por outros meios (sífilis, tuberculose e febre reumática).
  Não há diferença no total de diagnósticos considerados, ou na
  distribuição dos diagnósticos entre os demais grupos.

- `procbst.rm` TRUE (padrão) exclui as internações por procedimentos
  relacionados ao parto ou abortamento. São excluídas as internações
  pelos seguintes procedimentos obstétricos, independente do diagnóstico
  principal de internação (variável \`DIAGPRINC\`):

  - 0310010012 ASSISTENCIA AO PARTO S/ DISTOCIA

  - 0310010020 ATENDIMENTO AO RECÉM-NASCIDO EM SALA DE PARTO

  - 0310010039 PARTO NORMAL

  - 0310010047 PARTO NORMAL EM GESTAÇÃO DE ALTO RISCO

  - 0411010018 DESCOLAMENTO MANUAL DE PLACENTA

  - 0411010026 PARTO CESARIANO EM GESTAÇÃO ALTO RISCO

  - 0411010034 PARTO CESARIANO

  - 0411010042 PARTO CESARIANO C/ LAQUEADURA TUBÁRIA

  - 0411020013 CURETAGEM PÓS-ABORTAMENTO / PUERPERAL

  - 0411020021 EMBRIOTOMIA

- `parto.rm ` TRUE (padrão) exclui as internações por parto pelo campo
  diagnóstico, independente do procedimento. São excluídas as
  internações com os seguintes diagnósticos (CID-10):

  - O80 Parto único espontâneo

  - O81 Parto único por fórceps ou vácuo-extrator

  - O82 Parto único por cesariana

  - O83 Outros tipos de parto único assistido

  - O84 Parto múltiplo

  É retornada uma mensagem informando o número de registros lidos, o
  número e proporção de registros excluídos e o total de registros
  importados.

- `sihsus` A própria função define este argumento como `FALSE` quando
  "x" (o alvo da função) é um fator. Quando o alvo é um objeto da clase
  `data frame` sem a estrutura dos arquivos da AIH, a variável com os
  códigos da CID-10 deve ser trabalhada como um `factor`.

## Note

A função [`read.dbf`](https://rdrr.io/pkg/foreign/man/read.dbf.html), do
pacote `foreign`, não lê arquivos em formato DBF em que uma das
variáveis tenha todos os valores ausentes ('missings'); essas variáveis
devem ser excluídas antes da leitura do arquivo pela função `csapAIH` ou
mesmo pela função
[`read.dbf`](https://rdrr.io/pkg/foreign/man/read.dbf.html).

## References

Alfradique ME et al. Internações por condições sensíveis à atenção
primária: a construção da lista brasileira como ferramenta para medir o
desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de
Saúde Pública. 2009; 25(6): 1337-1349.
<https://doi.org/10.1590/S0102-311X2009000600016>.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No
221, de 17 de abril de 2008.
[http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html](http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.md)

\_\_\_\_\_\_\_\_\_\_. Departamento de Regulação, Avaliação e Controle.
Coordenação Geral de Sistemas de Informação - 2010. Manual técnico
operacional do Sistema de Informação Hospitalar: orientações técnicas.
Versão 01.2013. Ministério da Saúde: Brasília, 2013.

## See also

[`read.table`](https://rdrr.io/r/utils/read.table.html),
[`read.csv`](https://rdrr.io/r/utils/read.table.html),
[`read.dbc`](https://rdrr.io/pkg/read.dbc/man/read.dbc.html),
[`descreveCSAP`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md),
[`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md),
[`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md)

## Examples

``` r
## Uma lista de códigos da CID-10:
##---------------------------------
cids <- c("I200", "K929", "T16", "I509", "I10",  "I509", "S068")
#
# Se o vetor for da classe 'character', deve-se transformá-lo em fator ou
# mudar o argumento 'arquivo' para 'FALSE':
# teste1 <- csapAIH(cids) # Erro
teste1 <- csapAIH(factor(cids)) ; class(teste1) ; teste1
#> Excluídos 0 registros de parto (0% do total).
#> [1] "data.frame"
#>    cid csap    grupo
#> 1 I200  sim      g10
#> 2 K929  não nao-CSAP
#> 3  T16  não nao-CSAP
#> 4 I509  sim      g11
#> 5  I10  sim      g09
#> 6 I509  sim      g11
#> 7 S068  não nao-CSAP
teste1 <- csapAIH(cids, arquivo=FALSE) ; class(teste1) ; teste1
#> Excluídos 0 registros de parto (0% do total).
#> [1] "data.frame"
#>    cid csap    grupo
#> 1 I200  sim      g10
#> 2 K929  não nao-CSAP
#> 3  T16  não nao-CSAP
#> 4 I509  sim      g11
#> 5  I10  sim      g09
#> 6 I509  sim      g11
#> 7 S068  não nao-CSAP
teste2 <- csapAIH(cids, arquivo=FALSE,  grupo=FALSE) ; class(teste2) ; teste2
#> Excluídos 0 registros de parto (0% do total).
#> [1] "character"
#> [1] "sim" "não" "não" "sim" "sim" "sim" "não"
teste2 <- csapAIH(factor(cids), grupo=FALSE) ; class(teste2) ; teste2
#> Excluídos 0 registros de parto (0% do total).
#> [1] "character"
#> [1] "sim" "não" "não" "sim" "sim" "sim" "não"
#

## Um 'arquivo da AIH' armazenado no diretório de trabalho:
##---------------------------------------------------------
if (FALSE) { # \dontrun{
 teste3.dbf <- csapAIH("RDRS1201.dbf")
 str(teste3.dbf)
 teste4.dbc <- csapAIH("data-raw/RDRS1801.dbc")
 str(teste4.dbc) } # }

## Um 'data.frame' com a estrutura dos 'arquivos da AIH':
##-------------------------------------------------------
data("aih500")
str(aih500)
#> 'data.frame':    500 obs. of  113 variables:
#>  $ UF_ZI     : Factor w/ 63 levels "430000","430070",..: 1 60 55 42 1 1 1 15 42 1 ...
#>  $ ANO_CMPT  : Factor w/ 1 level "2018": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ MES_CMPT  : Factor w/ 1 level "01": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ ESPEC     : Factor w/ 12 levels "01","02","03",..: 3 2 1 1 7 3 1 3 1 1 ...
#>  $ CGC_HOSP  : Factor w/ 261 levels "00765384000133",..: 104 111 NA 192 83 211 171 88 40 104 ...
#>  $ N_AIH     : Factor w/ 60477 levels "4313102362129",..: 26471 57886 6357 39499 25436 10259 2406 23767 41266 7866 ...
#>  $ IDENT     : Factor w/ 2 levels "1","5": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CEP       : Factor w/ 13493 levels "03315000","04618003",..: 13451 8635 4404 6011 13008 9738 13065 8100 6174 13332 ...
#>  $ MUNIC_RES : Factor w/ 574 levels "110020","110140",..: 226 523 495 261 168 419 427 238 560 223 ...
#>  $ NASC      : Factor w/ 25848 levels "19050128","19070106",..: 2855 19158 13297 23675 25758 15121 3265 12653 8468 8017 ...
#>  $ SEXO      : Factor w/ 2 levels "1","3": 2 2 2 2 1 2 2 1 2 2 ...
#>  $ UTI_MES_IN: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_MES_AN: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_MES_AL: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_MES_TO: int  0 0 0 0 0 6 0 0 0 12 ...
#>  $ MARCA_UTI : Factor w/ 11 levels "00","01","74",..: 1 1 1 1 1 4 1 1 1 4 ...
#>  $ UTI_INT_IN: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_INT_AN: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_INT_AL: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ UTI_INT_TO: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ DIAR_ACOM : int  7 2 0 1 2 0 0 0 0 2 ...
#>  $ QT_DIARIAS: int  0 2 1 1 2 8 1 2 11 12 ...
#>  $ PROC_SOLIC: Factor w/ 1175 levels "0201010127","0201010135",..: 197 978 657 1045 168 96 530 186 67 584 ...
#>  $ PROC_REA  : Factor w/ 1112 levels "0201010127","0201010135",..: 192 924 620 985 164 103 396 182 690 552 ...
#>  $ VAL_SH    : num  538 521 478 370 240 ...
#>  $ VAL_SP    : num  68.7 276.4 122.4 338 38.8 ...
#>  $ VAL_SADT  : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_RN    : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_ACOMP : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_ORTP  : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_SANGUE: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_SADTSR: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_TRANSP: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_OBSANG: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_PED1AC: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_TOT   : num  607 798 601 708 279 ...
#>  $ VAL_UTI   : num  0 0 0 0 0 ...
#>  $ US_TOT    : num  187 246 185 218 86 ...
#>  $ DT_INTER  : Factor w/ 235 levels "20130610","20131001",..: 194 222 195 220 144 152 129 199 213 139 ...
#>  $ DT_SAIDA  : Factor w/ 182 levels "20170801","20170802",..: 148 171 143 168 93 112 77 148 171 110 ...
#>  $ DIAG_PRINC: Factor w/ 3254 levels "A009","A020",..: 2131 2444 2887 1189 2567 1219 1286 270 328 1766 ...
#>  $ DIAG_SECUN: Factor w/ 1 level "0000": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ COBRANCA  : Factor w/ 26 levels "11","12","14",..: 2 21 2 2 2 20 1 2 2 20 ...
#>  $ NATUREZA  : Factor w/ 1 level "00": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ NAT_JUR   : Factor w/ 13 levels "1023","1104",..: 5 13 6 9 13 13 13 13 8 5 ...
#>  $ GESTAO    : Factor w/ 2 levels "1","2": 2 1 1 1 2 2 2 1 1 2 ...
#>  $ RUBRICA   : int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ IND_VDRL  : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ MUNIC_MOV : Factor w/ 232 levels "430003","430010",..: 65 212 195 142 47 150 133 48 142 65 ...
#>  $ COD_IDADE : Factor w/ 4 levels "2","3","4","5": 3 3 3 3 1 3 3 3 3 3 ...
#>  $ IDADE     : int  79 27 46 10 2 39 78 48 61 62 ...
#>  $ DIAS_PERM : int  7 2 1 1 2 13 1 2 11 24 ...
#>  $ MORTE     : int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ NACIONAL  : Factor w/ 32 levels "010","020","021",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ NUM_PROC  : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
#>  $ CAR_INT   : Factor w/ 4 levels "01","02","05",..: 2 2 1 1 2 2 2 2 2 2 ...
#>  $ TOT_PT_SP : int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ CPF_AUT   : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
#>  $ HOMONIMO  : Factor w/ 3 levels "0","1","2": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ NUM_FILHOS: int  0 0 0 0 0 0 0 0 0 0 ...
#>  $ INSTRU    : Factor w/ 5 levels "0","1","2","3",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CID_NOTIF : Factor w/ 1 level "Z302": NA NA NA NA NA NA NA NA NA NA ...
#>  $ CONTRACEP1: Factor w/ 6 levels "00","06","08",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CONTRACEP2: Factor w/ 6 levels "00","06","08",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ GESTRISCO : Factor w/ 2 levels "0","1": 2 2 2 2 2 2 2 2 2 2 ...
#>  $ INSC_PN   : Factor w/ 2396 levels "000000000000",..: 1 1780 1 1 1 1 1 1 1 1 ...
#>  $ SEQ_AIH5  : Factor w/ 1 level "000": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CBOR      : Factor w/ 5 levels "000000","225125",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CNAER     : Factor w/ 2 levels "000","851": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ VINCPREV  : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ GESTOR_COD: Factor w/ 16 levels "00000","00007",..: 1 1 1 1 1 1 1 1 1 2 ...
#>  $ GESTOR_TP : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 2 1 1 2 ...
#>  $ GESTOR_CPF: Factor w/ 49 levels "000000000000000",..: 1 1 1 1 1 1 36 1 1 36 ...
#>  $ GESTOR_DT : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
#>  $ CNES      : Factor w/ 277 levels "2223538","2223546",..: 236 174 37 77 122 41 129 2 78 236 ...
#>  $ CNPJ_MANT : Factor w/ 35 levels "03066309000172",..: NA NA 14 NA NA NA NA NA NA NA ...
#>  $ INFEHOSP  : Factor w/ 0 levels: NA NA NA NA NA NA NA NA NA NA ...
#>  $ CID_ASSO  : Factor w/ 1 level "0000": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ CID_MORTE : Factor w/ 1 level "0000": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ COMPLEX   : Factor w/ 2 levels "02","03": 1 1 1 1 1 1 2 2 1 1 ...
#>  $ FINANC    : Factor w/ 2 levels "04","06": 2 2 2 2 2 2 2 2 2 2 ...
#>  $ FAEC_TP   : Factor w/ 13 levels "040014","040016",..: NA NA NA NA NA NA NA NA NA NA ...
#>  $ REGCT     : Factor w/ 5 levels "0000","7102",..: 1 1 1 5 1 1 1 1 4 1 ...
#>  $ RACA_COR  : Factor w/ 6 levels "01","02","03",..: 1 1 1 1 6 1 1 1 1 3 ...
#>  $ ETNIA     : Factor w/ 7 levels "0000","0001",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ SEQUENCIA : int  28000 158 36 5774 13434 3408 15626 1630 2869 26760 ...
#>  $ REMESSA   : Factor w/ 63 levels "HE43000001N201801.DTS",..: 1 60 55 42 1 1 1 15 42 1 ...
#>  $ AUD_JUST  : Factor w/ 11 levels "7021087628254",..: NA NA NA NA NA NA NA NA NA NA ...
#>  $ SIS_JUST  : Factor w/ 20 levels "702108762825496",..: NA NA NA NA NA NA NA NA NA NA ...
#>  $ VAL_SH_FED: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_SP_FED: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_SH_GES: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_SP_GES: num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ VAL_UCI   : num  0 0 0 0 0 0 0 0 0 0 ...
#>  $ MARCA_UCI : Factor w/ 4 levels "00","01","02",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ DIAGSEC1  : Factor w/ 675 levels "A049","A058",..: NA NA 523 NA NA NA NA NA NA NA ...
#>  $ DIAGSEC2  : Factor w/ 92 levels "A158","A419",..: NA NA NA NA NA NA NA NA NA NA ...
#>  $ DIAGSEC3  : Factor w/ 41 levels "A419","B182",..: NA NA NA NA NA NA NA NA NA NA ...
#>  $ DIAGSEC4  : Factor w/ 10 levels "A419","A499",..: NA NA NA NA NA NA NA NA NA NA ...
#>   [list output truncated]
#>  - attr(*, "data_types")= chr [1:113] "C" "C" "C" "C" ...
teste5 <- csapAIH(aih500)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
attributes(teste5)$resumo
#>           acao freq  perc                                  objeto
#> 1   Importados  500 100.0                              registros.
#> 2 Excluídos \t   62  12.4 registros de procedimentos obstétricos.
#> 3 Excluídos \t    3   0.6  registros de AIH de longa permanência.
#> 4   Exportados  435  87.0                              registros.
str(teste5)
#> 'data.frame':    435 obs. of  16 variables:
#>  $ n.aih     : chr  "4317109123778" "4317107038640" "4318100211370" "4317109050804" ...
#>   ..- attr(*, "label")= chr "No. da AIH"
#>  $ munres    : Factor w/ 574 levels "110020","110140",..: 226 495 261 168 419 427 238 560 223 211 ...
#>   ..- attr(*, "label")= chr "Municipio de residencia"
#>  $ munint    : Factor w/ 232 levels "430003","430010",..: 65 195 142 47 150 133 48 142 65 213 ...
#>   ..- attr(*, "label")= chr "Municipio de internacao"
#>  $ sexo      : Factor w/ 2 levels "masc","fem": 2 2 2 1 2 2 1 2 2 1 ...
#>   ..- attr(*, "label")= chr "Sexo"
#>  $ nasc      : Date, format: "1938-01-27" "1971-10-20" ...
#>  $ idade     : num  79 46 10 0 39 78 48 61 62 79 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
#>   ..- attr(*, "label")= chr "Idade"
#>  $ fxetar.det: Factor w/ 29 levels "<1ano"," 1ano",..: 28 22 8 1 20 28 22 25 25 28 ...
#>   ..- attr(*, "label")= chr "Faixa etaria detalhada"
#>  $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 16 10 3 1 8 16 10 13 13 16 ...
#>   ..- attr(*, "label")= chr "Faixa etaria quinquenal"
#>  $ csap      : chr  "não" "não" "não" "não" ...
#>   ..- attr(*, "label")= chr "CSAP"
#>  $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 20 20 10 20 20 20 20 20 ...
#>   ..- attr(*, "label")= chr "Grupo de causa CSAP"
#>  $ cid       : chr  "N189" "S423" "H938" "P584" ...
#>  $ proc.rea  : Factor w/ 1112 levels "0201010127","0201010135",..: 192 620 985 164 103 396 182 690 552 849 ...
#>   ..- attr(*, "label")= chr "Procedimento realizado"
#>  $ data.inter: Date, format: "2017-12-21" "2017-12-22" ...
#>  $ data.saida: Date, format: "2017-12-28" "2017-12-23" ...
#>  $ cep       : Factor w/ 13493 levels "03315000","04618003",..: 13451 4404 6011 13008 9738 13065 8100 6174 13332 8176 ...
#>   ..- attr(*, "label")= chr "Codigo de Enderecamento Postal"
#>  $ cnes      : Factor w/ 277 levels "2223538","2223546",..: 236 37 77 122 41 129 2 78 236 238 ...
#>   ..- attr(*, "label")= chr "No. do hospital no CNES"
#>  - attr(*, "resumo")='data.frame':   4 obs. of  4 variables:
#>   ..$ acao  : chr [1:4] "Importados" "Excluídos \t" "Excluídos \t" "Exportados"
#>   ..$ freq  : num [1:4] 500 62 3 435
#>   ..$ perc  : num [1:4] 100 12.4 0.6 87
#>   ..$ objeto: chr [1:4] "registros." "registros de procedimentos obstétricos." "registros de AIH de longa permanência." "registros."
levels(teste5$grupo)
#>  [1] "g01"      "g02"      "g03"      "g04"      "g05"      "g06"     
#>  [7] "g07"      "g08"      "g09"      "g10"      "g11"      "g12"     
#> [13] "g13"      "g14"      "g15"      "g16"      "g17"      "g18"     
#> [19] "g19"      "nao-CSAP"

# Sem excluir registros
teste6 <- csapAIH(aih500, procobst.rm = FALSE, parto.rm = FALSE, longa.rm = FALSE)
#> Importados 500 registros.
#> Exportados 500 (100%) registros.
str(teste6)
#> 'data.frame':    500 obs. of  16 variables:
#>  $ n.aih     : chr  "4317109123778" "4318100708361" "4317107038640" "4318100211370" ...
#>   ..- attr(*, "label")= chr "No. da AIH"
#>  $ munres    : Factor w/ 574 levels "110020","110140",..: 226 523 495 261 168 419 427 238 560 223 ...
#>   ..- attr(*, "label")= chr "Municipio de residencia"
#>  $ munint    : Factor w/ 232 levels "430003","430010",..: 65 212 195 142 47 150 133 48 142 65 ...
#>   ..- attr(*, "label")= chr "Municipio de internacao"
#>  $ sexo      : Factor w/ 2 levels "masc","fem": 2 2 2 2 1 2 2 1 2 2 ...
#>   ..- attr(*, "label")= chr "Sexo"
#>  $ nasc      : Date, format: "1938-01-27" "1990-11-10" ...
#>  $ idade     : num  79 27 46 10 0 39 78 48 61 62 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
#>   ..- attr(*, "label")= chr "Idade"
#>  $ fxetar.det: Factor w/ 29 levels "<1ano"," 1ano",..: 28 18 22 8 1 20 28 22 25 25 ...
#>   ..- attr(*, "label")= chr "Faixa etaria detalhada"
#>  $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 16 6 10 3 1 8 16 10 13 13 ...
#>   ..- attr(*, "label")= chr "Faixa etaria quinquenal"
#>  $ csap      : chr  "não" "não" "não" "não" ...
#>   ..- attr(*, "label")= chr "CSAP"
#>  $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 20 20 20 10 20 20 20 20 ...
#>   ..- attr(*, "label")= chr "Grupo de causa CSAP"
#>  $ cid       : chr  "N189" "O689" "S423" "H938" ...
#>  $ proc.rea  : Factor w/ 1112 levels "0201010127","0201010135",..: 192 924 620 985 164 103 396 182 690 552 ...
#>   ..- attr(*, "label")= chr "Procedimento realizado"
#>  $ data.inter: Date, format: "2017-12-21" "2018-01-18" ...
#>  $ data.saida: Date, format: "2017-12-28" "2018-01-20" ...
#>  $ cep       : Factor w/ 13493 levels "03315000","04618003",..: 13451 8635 4404 6011 13008 9738 13065 8100 6174 13332 ...
#>   ..- attr(*, "label")= chr "Codigo de Enderecamento Postal"
#>  $ cnes      : Factor w/ 277 levels "2223538","2223546",..: 236 174 37 77 122 41 129 2 78 236 ...
#>   ..- attr(*, "label")= chr "No. do hospital no CNES"
#>  - attr(*, "resumo")='data.frame':   2 obs. of  4 variables:
#>   ..$ acao  : chr [1:2] "Importados" "Exportados"
#>   ..$ freq  : num [1:2] 500 500
#>   ..$ perc  : num [1:2] 100 100
#>   ..$ objeto: chr [1:2] "registros." "registros."
attributes(teste6)$resumo
#>         acao freq perc     objeto
#> 1 Importados  500  100 registros.
#> 2 Exportados  500  100 registros.

# Com a lista de 20 grupos de causa (Alfradique et al.)
teste7 <- csapAIH(aih500, lista = "Alfradique")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
str(teste7)
#> 'data.frame':    435 obs. of  16 variables:
#>  $ n.aih     : chr  "4317109123778" "4317107038640" "4318100211370" "4317109050804" ...
#>   ..- attr(*, "label")= chr "No. da AIH"
#>  $ munres    : Factor w/ 574 levels "110020","110140",..: 226 495 261 168 419 427 238 560 223 211 ...
#>   ..- attr(*, "label")= chr "Municipio de residencia"
#>  $ munint    : Factor w/ 232 levels "430003","430010",..: 65 195 142 47 150 133 48 142 65 213 ...
#>   ..- attr(*, "label")= chr "Municipio de internacao"
#>  $ sexo      : Factor w/ 2 levels "masc","fem": 2 2 2 1 2 2 1 2 2 1 ...
#>   ..- attr(*, "label")= chr "Sexo"
#>  $ nasc      : Date, format: "1938-01-27" "1971-10-20" ...
#>  $ idade     : num  79 46 10 0 39 78 48 61 62 79 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
#>   ..- attr(*, "label")= chr "Idade"
#>  $ fxetar.det: Factor w/ 29 levels "<1ano"," 1ano",..: 28 22 8 1 20 28 22 25 25 28 ...
#>   ..- attr(*, "label")= chr "Faixa etaria detalhada"
#>  $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 16 10 3 1 8 16 10 13 13 16 ...
#>   ..- attr(*, "label")= chr "Faixa etaria quinquenal"
#>  $ csap      : chr  "não" "não" "não" "não" ...
#>   ..- attr(*, "label")= chr "CSAP"
#>  $ grupo     : Factor w/ 21 levels "g01","g02","g03",..: 21 21 21 21 11 21 21 21 21 21 ...
#>   ..- attr(*, "label")= chr "Grupo de causa CSAP"
#>  $ cid       : chr  "N189" "S423" "H938" "P584" ...
#>  $ proc.rea  : Factor w/ 1112 levels "0201010127","0201010135",..: 192 620 985 164 103 396 182 690 552 849 ...
#>   ..- attr(*, "label")= chr "Procedimento realizado"
#>  $ data.inter: Date, format: "2017-12-21" "2017-12-22" ...
#>  $ data.saida: Date, format: "2017-12-28" "2017-12-23" ...
#>  $ cep       : Factor w/ 13493 levels "03315000","04618003",..: 13451 4404 6011 13008 9738 13065 8100 6174 13332 8176 ...
#>   ..- attr(*, "label")= chr "Codigo de Enderecamento Postal"
#>  $ cnes      : Factor w/ 277 levels "2223538","2223546",..: 236 37 77 122 41 129 2 78 236 238 ...
#>   ..- attr(*, "label")= chr "No. do hospital no CNES"
#>  - attr(*, "resumo")='data.frame':   4 obs. of  4 variables:
#>   ..$ acao  : chr [1:4] "Importados" "Excluídos \t" "Excluídos \t" "Exportados"
#>   ..$ freq  : num [1:4] 500 62 3 435
#>   ..$ perc  : num [1:4] 100 12.4 0.6 87
#>   ..$ objeto: chr [1:4] "registros." "registros de procedimentos obstétricos." "registros de AIH de longa permanência." "registros."
levels(teste7$grupo)
#>  [1] "g01"      "g02"      "g03"      "g04"      "g05"      "g06"     
#>  [7] "g07"      "g08"      "g09"      "g10"      "g11"      "g12"     
#> [13] "g13"      "g14"      "g15"      "g16"      "g17"      "g18"     
#> [19] "g19"      "g20"      "nao-CSAP"

## Uma base de dados com a estrutura dos "arquivos da AIH"
## mas sem as variáveis CEP ou CNES:
##--------------------------------------------------------
aih <- subset(aih500, select = -c(CEP, CNES))
teste8 <- csapAIH(aih, cep = FALSE, cnes = FALSE)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
str(teste8)
#> 'data.frame':    435 obs. of  14 variables:
#>  $ n.aih     : chr  "4317109123778" "4317107038640" "4318100211370" "4317109050804" ...
#>   ..- attr(*, "label")= chr "No. da AIH"
#>  $ munres    : Factor w/ 574 levels "110020","110140",..: 226 495 261 168 419 427 238 560 223 211 ...
#>   ..- attr(*, "label")= chr "Municipio de residencia"
#>  $ munint    : Factor w/ 232 levels "430003","430010",..: 65 195 142 47 150 133 48 142 65 213 ...
#>   ..- attr(*, "label")= chr "Municipio de internacao"
#>  $ sexo      : Factor w/ 2 levels "masc","fem": 2 2 2 1 2 2 1 2 2 1 ...
#>   ..- attr(*, "label")= chr "Sexo"
#>  $ nasc      : Date, format: "1938-01-27" "1971-10-20" ...
#>  $ idade     : num  79 46 10 0 39 78 48 61 62 79 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
#>   ..- attr(*, "label")= chr "Idade"
#>  $ fxetar.det: Factor w/ 29 levels "<1ano"," 1ano",..: 28 22 8 1 20 28 22 25 25 28 ...
#>   ..- attr(*, "label")= chr "Faixa etaria detalhada"
#>  $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 16 10 3 1 8 16 10 13 13 16 ...
#>   ..- attr(*, "label")= chr "Faixa etaria quinquenal"
#>  $ csap      : chr  "não" "não" "não" "não" ...
#>   ..- attr(*, "label")= chr "CSAP"
#>  $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 20 20 10 20 20 20 20 20 ...
#>   ..- attr(*, "label")= chr "Grupo de causa CSAP"
#>  $ cid       : chr  "N189" "S423" "H938" "P584" ...
#>  $ proc.rea  : Factor w/ 1112 levels "0201010127","0201010135",..: 192 620 985 164 103 396 182 690 552 849 ...
#>   ..- attr(*, "label")= chr "Procedimento realizado"
#>  $ data.inter: Date, format: "2017-12-21" "2017-12-22" ...
#>  $ data.saida: Date, format: "2017-12-28" "2017-12-23" ...
#>  - attr(*, "resumo")='data.frame':   4 obs. of  4 variables:
#>   ..$ acao  : chr [1:4] "Importados" "Excluídos \t" "Excluídos \t" "Exportados"
#>   ..$ freq  : num [1:4] 500 62 3 435
#>   ..$ perc  : num [1:4] 100 12.4 0.6 87
#>   ..$ objeto: chr [1:4] "registros." "registros de procedimentos obstétricos." "registros de AIH de longa permanência." "registros."

## Uma base de dados sem a estrutura dos arquivos RD*.dbc:
##--------------------------------------------------------
teste9 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10)
#> Importados 1.000 registros.
#> Excluídos 150 registros de parto (15% do total).
str(teste9)
#> 'data.frame':    850 obs. of  38 variables:
#>  $ prov_ubi  : chr+lbl [1:850] 09, 09, 09, 09, 09, 09, 17, 09, 12, 17, 18, 18, 23, 09...
#>    ..@ label        : chr "Provincia ubicación establecimiento"
#>    ..@ format.spss  : chr "A6"
#>    ..@ display_width: int 2
#>    ..@ labels       : Named chr  "10" "20" "01" "11" ...
#>    .. ..- attr(*, "names")= chr [1:25] "Imbabura" "Galápagos" "Azuay" "Loja" ...
#>  $ cant_ubi  : chr+lbl [1:850] 0901, 0901, 0901, 0901, 0901, 0901, 1701, 0901, 1205, ...
#>    ..@ label        : chr "SecA Cantón ubicación establecimiento"
#>    ..@ format.spss  : chr "A12"
#>    ..@ display_width: int 14
#>    ..@ labels       : Named chr  "8800" "0110" "1110" "1210" ...
#>    .. ..- attr(*, "names")= chr [1:222] "Exterior" "Oña" "Puyango" "Buena Fé" ...
#>  $ parr_ubi  : chr+lbl [1:850] 090114, 090114, 090112, 090112, 090112, 090113, 170155...
#>    ..@ label        : chr "SecA Parroquia ubicación establecimiento"
#>    ..@ format.spss  : chr "A18"
#>    ..@ display_width: int 20
#>    ..@ labels       : Named chr  "880000" "010110" "170110" "090110" ...
#>    .. ..- attr(*, "names")= chr [1:1308] "Exterior" "San Blas" "El Condado" "Rocafuerte" ...
#>  $ area_ubi  : dbl+lbl [1:850] 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
#>    ..@ label      : chr "Area de ubicación del establecimiento"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2
#>    .. ..- attr(*, "names")= chr [1:2] "Urbana" "Rural"
#>  $ clase     : dbl+lbl [1:850] 11,  2,  5,  1,  2,  1,  2,  5,  1, 11,  2,  1,  2, 11...
#>    ..@ label      : chr "Clase de establecimiento"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:18] "Hospital básico" "Hospital general" "Infectología" "Gineco-Obstétrico" ...
#>  $ tipo      : dbl+lbl [1:850] 1, 1, 1, 5, 1, 5, 1, 1, 5, 1, 1, 5, 1, 1, 1, 1, 5, 3, ...
#>    ..@ label      : chr "Tipo de establecimiento"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 5
#>    .. ..- attr(*, "names")= chr [1:5] "Agudo" "Crónico" "Clínicas generales sin especialidad" "Establecimientos sin internación" ...
#>  $ entidad   : dbl+lbl [1:850]  6,  1, 13, 18,  1, 18,  1,  1,  1,  6,  6, 18,  1, 18...
#>    ..@ label      : chr "Entidad a la que pertenece el establecimiento"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:18] "Ministerio de Salud Pública" "Ministerio de Justicia, Derechos Humanos y Cultos" "Ministerio de Defensa Nacional" "Ministerio de Educación" ...
#>  $ sector    : dbl+lbl [1:850] 1, 1, 3, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, ...
#>    ..@ label      : chr "Sector al que pertenece el establecimiento"
#>    ..@ format.spss: chr "F3.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Público" "Privado con fines de lucro" "Privado sin fines de lucro"
#>  $ mes_inv   : dbl+lbl [1:850]  9, 11,  2,  8,  3, 12,  7, 12,  2,  1,  6,  5,  3, 10...
#>    ..@ label      : chr "Mes de registro/investigación"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ nac_pac   : dbl+lbl [1:850] 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
#>    ..@ label      : chr "Nacionalidad del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 9
#>    .. ..- attr(*, "names")= chr [1:3] "Ecuatoriano/a" "Extranjero/a" "Ignorado"
#>  $ cod_pais  : num  218 218 218 218 218 218 218 218 218 218 ...
#>  $ nom_pais  : chr  "ECUADOR" "ECUADOR" "ECUADOR" "ECUADOR" ...
#>  $ sexo      : dbl+lbl [1:850] 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 1, 2, 1, 1, 2, 1, 1, 2, ...
#>    ..@ label      : chr "Sexo del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Hombre" "Mujer" "Indeterminado"
#>  $ cod_edad  : dbl+lbl [1:850] 4, 4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, ...
#>    ..@ label      : chr "Condición de la edad del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 9
#>    .. ..- attr(*, "names")= chr [1:5] "Horas (1 a 23 horas de edad)" "Días (1 a 28 días de edad)" "Meses (1 a 11 meses de edad)" "Años (1 a 115 años de edad)" ...
#>  $ edad      : num  52 57 9 56 17 36 20 10 67 80 ...
#>  $ etnia     : dbl+lbl [1:850] 8, 6, 6, 6, 6, 6, 6, 6, 6, 9, 9, 6, 6, 6, 6, 6, 6, 6, ...
#>    ..@ label      : chr "Definicion étnica del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9
#>    .. ..- attr(*, "names")= chr [1:9] "Indígena" "Afroecuatoriano/a Afrodescendiente" "Negro/a" "Mulato/a" ...
#>  $ prov_res  : chr+lbl [1:850] 09, 09, 09, 09, 09, 09, 17, 09, 12, 17, 18, 17, 23, 09...
#>    ..@ label        : chr "Provincia de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A6"
#>    ..@ display_width: int 2
#>    ..@ labels       : Named chr  "10" "20" "01" "11" ...
#>    .. ..- attr(*, "names")= chr [1:25] "Imbabura" "Galápagos" "Azuay" "Loja" ...
#>  $ area_res  : num  1 1 1 1 1 1 2 1 1 1 ...
#>  $ anio_ingr : num  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>  $ mes_ingr  : dbl+lbl [1:850]  8, 10,  2,  8,  3, 12,  7, 12,  2,  1,  6,  5,  3, 10...
#>    ..@ label      : chr "Mes de ingreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ dia_ingr  : num  30 30 14 6 4 16 17 15 18 15 ...
#>  $ fecha_ingr: chr  "2020/08/30 00:00:00.000" "2020/10/30 00:00:00.000" "2020/02/14 00:00:00.000" "2020/08/06 00:00:00.000" ...
#>  $ anio_egr  : num  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>  $ mes_egr   : dbl+lbl [1:850]  9, 11,  2,  8,  3, 12,  7, 12,  2,  1,  6,  5,  3, 10...
#>    ..@ label      : chr " Mes egreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ dia_egr   : num  5 2 17 9 5 17 18 21 19 28 ...
#>  $ fecha_egr : chr  "2020/09/05 00:00:00.000" "2020/11/02 00:00:00.000" "2020/02/17 00:00:00.000" "2020/08/09 00:00:00.000" ...
#>  $ dia_estad : num  6 3 3 3 1 1 1 6 1 13 ...
#>  $ con_egrpa : dbl+lbl [1:850] 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1, 1, ...
#>    ..@ label      : chr " Condición del egreso"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Vivo" "Fallecido menos de 48 horas" "Fallecido en 48 horas y más"
#>  $ esp_egrpa : dbl+lbl [1:850] 37, 23, 41,  7, 27, 47, 21, 29, 27, 30, 27, 21, 27, 52...
#>    ..@ label      : chr " Especialidad del egreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:52] "Alergología" "Atención Primaria de la Salud" "Cardiología" "Cardiopediatría" ...
#>  $ cau_cie10 : chr+lbl [1:850] C169 , U072 , A090 , K469 , K802 , S903 , O730 , P369 ...
#>    ..@ label        : chr "Causa de lista internacional detallada a 4 dígitos de la CIE-10"
#>    ..@ format.spss  : chr "A15"
#>    ..@ display_width: int 5
#>    ..@ labels       : Named chr  "A00" "B00" "C00" "D00" ...
#>    .. ..- attr(*, "names")= chr [1:18445] "Cólera" "Infecciones herpética [herpes simple]" "Tumor maligno del labio" "Carcinoma in situ de la cavidad bucal, del esófago y del estómago" ...
#>  $ cant_res  : chr+lbl [1:850] 0901, 0901, 0901, 0901, 0901, 0901, 1701, 0901, 1210, ...
#>    ..@ label        : chr "SecA Cantón de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A12"
#>    ..@ display_width: int 14
#>    ..@ labels       : Named chr  "8800" "0110" "1110" "1210" ...
#>    .. ..- attr(*, "names")= chr [1:222] "Exterior" "Oña" "Puyango" "Buena Fé" ...
#>  $ parr_res  : chr+lbl [1:850] 090150, 090104, 090150, 090150, 090112, 090150, 170180...
#>    ..@ label        : chr "SecA Parroquia de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A18"
#>    ..@ display_width: int 20
#>    ..@ labels       : Named chr  "880000" "010110" "170110" "090110" ...
#>    .. ..- attr(*, "names")= chr [1:1308] "Exterior" "San Blas" "El Condado" "Rocafuerte" ...
#>  $ causa3    : chr+lbl [1:850] C16, U07, A09, K46, K80, S90, O73, P36, J90, J44, U07,...
#>    ..@ label      : chr "Causa de lista internacional detallada a 3 dígitos de la CIE-10"
#>    ..@ format.spss: chr "A9"
#>    ..@ labels     : Named chr  "A00" "B00" "C00" "D00" ...
#>    .. ..- attr(*, "names")= chr [1:2054] "Cólera" "Infecciones herpética [herpes simple]" "Tumor maligno del labio" "Carcinoma in situ de la cavidad bucal, del esófago y del estómago" ...
#>  $ cap221rx  : dbl+lbl [1:850]  2, 22,  1, 11, 11, 19, 15, 16, 10, 10, 22, 21, 19, 10...
#>    ..@ label        : chr "Capitulo lista 221"
#>    ..@ format.spss  : chr "F4.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:22] "I Ciertas enfermedades infecciosas y parasitarias (A00 -B99)" "II Neoplasias (C00-D48)" "III Enfermedades de la sangre y de los órganos hematopoyéticos y otros tras. que afectan el mecan. de la inmu (D50-D89)" "IV Enfermedades endocrinas, nutricionales y metabólicas  (E00-E90)" ...
#>  $ cau221rx  : dbl+lbl [1:850]  23, 222,   1, 114, 119, 205, 159, 167, 109, 105, 222,...
#>    ..@ label        : chr "Lista especial de 221 grupos"
#>    ..@ format.spss  : chr "F3.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:222] "Enfermedades infecciosas intestinales (A00-A09)" "Tuberculosis (A15-A19)" "Ciertas zoonosis bacterianas (A20-A28)" "Otras enfermedades bacterianas (A30-A49)" ...
#>  $ cau298rx  : dbl+lbl [1:850]  60, 299,   5, 188, 195, 281, 242, 250, 179, 175, 299,...
#>    ..@ label        : chr "Lista de causas 298"
#>    ..@ format.spss  : chr "F3.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:299] "Cólera" "Fiebres tifoidea y paratifoidea" "Shigelosis" "Amebiasis" ...
#>  $ csap      : chr  "não" "não" "sim" "não" ...
#>  $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 2 20 20 20 20 20 20 8 ...
teste10 <- csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10, parto.rm = FALSE)
#> Importados 1.000 registros.
str(teste10)
#> 'data.frame':    1000 obs. of  38 variables:
#>  $ prov_ubi  : chr+lbl [1:1000] 09, 09, 09, 12, 09, 09, 09, 17, 09, 12, 17, 11, 18, 1...
#>    ..@ label        : chr "Provincia ubicación establecimiento"
#>    ..@ format.spss  : chr "A6"
#>    ..@ display_width: int 2
#>    ..@ labels       : Named chr  "10" "20" "01" "11" ...
#>    .. ..- attr(*, "names")= chr [1:25] "Imbabura" "Galápagos" "Azuay" "Loja" ...
#>  $ cant_ubi  : chr+lbl [1:1000] 0901, 0901, 0901, 1207, 0901, 0901, 0901, 1701, 0901,...
#>    ..@ label        : chr "SecA Cantón ubicación establecimiento"
#>    ..@ format.spss  : chr "A12"
#>    ..@ display_width: int 14
#>    ..@ labels       : Named chr  "8800" "0110" "1110" "1210" ...
#>    .. ..- attr(*, "names")= chr [1:222] "Exterior" "Oña" "Puyango" "Buena Fé" ...
#>  $ parr_ubi  : chr+lbl [1:1000] 090114, 090114, 090112, 120750, 090112, 090112, 09011...
#>    ..@ label        : chr "SecA Parroquia ubicación establecimiento"
#>    ..@ format.spss  : chr "A18"
#>    ..@ display_width: int 20
#>    ..@ labels       : Named chr  "880000" "010110" "170110" "090110" ...
#>    .. ..- attr(*, "names")= chr [1:1308] "Exterior" "San Blas" "El Condado" "Rocafuerte" ...
#>  $ area_ubi  : dbl+lbl [1:1000] 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
#>    ..@ label      : chr "Area de ubicación del establecimiento"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2
#>    .. ..- attr(*, "names")= chr [1:2] "Urbana" "Rural"
#>  $ clase     : dbl+lbl [1:1000] 11,  2,  5,  1,  1,  2,  1,  2,  5,  1, 11,  2,  2,  ...
#>    ..@ label      : chr "Clase de establecimiento"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:18] "Hospital básico" "Hospital general" "Infectología" "Gineco-Obstétrico" ...
#>  $ tipo      : dbl+lbl [1:1000] 1, 1, 1, 5, 5, 1, 5, 1, 1, 5, 1, 1, 1, 5, 1, 1, 1, 1,...
#>    ..@ label      : chr "Tipo de establecimiento"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 5
#>    .. ..- attr(*, "names")= chr [1:5] "Agudo" "Crónico" "Clínicas generales sin especialidad" "Establecimientos sin internación" ...
#>  $ entidad   : dbl+lbl [1:1000]  6,  1, 13,  1, 18,  1, 18,  1,  1,  1,  6,  1,  6, 1...
#>    ..@ label      : chr "Entidad a la que pertenece el establecimiento"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:18] "Ministerio de Salud Pública" "Ministerio de Justicia, Derechos Humanos y Cultos" "Ministerio de Defensa Nacional" "Ministerio de Educación" ...
#>  $ sector    : dbl+lbl [1:1000] 1, 1, 3, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1,...
#>    ..@ label      : chr "Sector al que pertenece el establecimiento"
#>    ..@ format.spss: chr "F3.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Público" "Privado con fines de lucro" "Privado sin fines de lucro"
#>  $ mes_inv   : dbl+lbl [1:1000]  9, 11,  2,  8,  8,  3, 12,  7, 12,  2,  1, 11,  6,  ...
#>    ..@ label      : chr "Mes de registro/investigación"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ nac_pac   : dbl+lbl [1:1000] 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1,...
#>    ..@ label      : chr "Nacionalidad del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 9
#>    .. ..- attr(*, "names")= chr [1:3] "Ecuatoriano/a" "Extranjero/a" "Ignorado"
#>  $ cod_pais  : num  218 218 218 218 218 218 218 218 218 218 ...
#>   ..- attr(*, "label")= chr "Código del país"
#>   ..- attr(*, "format.spss")= chr "F3.0"
#>  $ nom_pais  : chr  "ECUADOR" "ECUADOR" "ECUADOR" "ECUADOR" ...
#>   ..- attr(*, "label")= chr "Nombre de país"
#>   ..- attr(*, "format.spss")= chr "A21"
#>   ..- attr(*, "display_width")= int 7
#>  $ sexo      : dbl+lbl [1:1000] 1, 2, 1, 2, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 1, 2, 2,...
#>    ..@ label      : chr "Sexo del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Hombre" "Mujer" "Indeterminado"
#>  $ cod_edad  : dbl+lbl [1:1000] 4, 4, 4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4,...
#>    ..@ label      : chr "Condición de la edad del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 9
#>    .. ..- attr(*, "names")= chr [1:5] "Horas (1 a 23 horas de edad)" "Días (1 a 28 días de edad)" "Meses (1 a 11 meses de edad)" "Años (1 a 115 años de edad)" ...
#>  $ edad      : num  52 57 9 24 56 17 36 20 10 67 ...
#>   ..- attr(*, "label")= chr "Edad del paciente"
#>   ..- attr(*, "format.spss")= chr "F3.0"
#>  $ etnia     : dbl+lbl [1:1000] 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 9, 6, 9, 6, 6, 6, 6, 6,...
#>    ..@ label      : chr "Definicion étnica del paciente"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9
#>    .. ..- attr(*, "names")= chr [1:9] "Indígena" "Afroecuatoriano/a Afrodescendiente" "Negro/a" "Mulato/a" ...
#>  $ prov_res  : chr+lbl [1:1000] 09, 09, 09, 12, 09, 09, 09, 17, 09, 12, 17, 11, 18, 1...
#>    ..@ label        : chr "Provincia de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A6"
#>    ..@ display_width: int 2
#>    ..@ labels       : Named chr  "10" "20" "01" "11" ...
#>    .. ..- attr(*, "names")= chr [1:25] "Imbabura" "Galápagos" "Azuay" "Loja" ...
#>  $ area_res  : num  1 1 1 1 1 1 1 2 1 1 ...
#>   ..- attr(*, "label")= chr "Area de residencia habitual del paciente"
#>   ..- attr(*, "format.spss")= chr "F1.0"
#>  $ anio_ingr : num  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>   ..- attr(*, "label")= chr "Año de ingreso"
#>   ..- attr(*, "format.spss")= chr "F4.0"
#>  $ mes_ingr  : dbl+lbl [1:1000]  8, 10,  2,  8,  8,  3, 12,  7, 12,  2,  1, 11,  6,  ...
#>    ..@ label      : chr "Mes de ingreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ dia_ingr  : num  30 30 14 12 6 4 16 17 15 18 ...
#>   ..- attr(*, "label")= chr "Día de ingreso"
#>   ..- attr(*, "format.spss")= chr "F2.0"
#>  $ fecha_ingr: chr  "2020/08/30 00:00:00.000" "2020/10/30 00:00:00.000" "2020/02/14 00:00:00.000" "2020/08/12 00:00:00.000" ...
#>   ..- attr(*, "label")= chr "Fecha de egreso"
#>   ..- attr(*, "format.spss")= chr "A69"
#>   ..- attr(*, "display_width")= int 23
#>  $ anio_egr  : num  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>   ..- attr(*, "label")= chr "Año del egreso"
#>   ..- attr(*, "format.spss")= chr "F4.0"
#>  $ mes_egr   : dbl+lbl [1:1000]  9, 11,  2,  8,  8,  3, 12,  7, 12,  2,  1, 11,  6,  ...
#>    ..@ label      : chr " Mes egreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:12] "Enero" "Febrero" "Marzo" "Abril" ...
#>  $ dia_egr   : num  5 2 17 13 9 5 17 18 21 19 ...
#>   ..- attr(*, "label")= chr " Día egreso"
#>   ..- attr(*, "format.spss")= chr "F2.0"
#>  $ fecha_egr : chr  "2020/09/05 00:00:00.000" "2020/11/02 00:00:00.000" "2020/02/17 00:00:00.000" "2020/08/13 00:00:00.000" ...
#>   ..- attr(*, "label")= chr " Fecha de egreso"
#>   ..- attr(*, "format.spss")= chr "A69"
#>   ..- attr(*, "display_width")= int 23
#>  $ dia_estad : num  6 3 3 1 3 1 1 1 6 1 ...
#>   ..- attr(*, "label")= chr " Días estada"
#>   ..- attr(*, "format.spss")= chr "F6.0"
#>  $ con_egrpa : dbl+lbl [1:1000] 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 3, 1, 1, 1, 1, 1,...
#>    ..@ label      : chr " Condición del egreso"
#>    ..@ format.spss: chr "F1.0"
#>    ..@ labels     : Named num  1 2 3
#>    .. ..- attr(*, "names")= chr [1:3] "Vivo" "Fallecido menos de 48 horas" "Fallecido en 48 horas y más"
#>  $ esp_egrpa : dbl+lbl [1:1000] 37, 23, 41, 21,  7, 27, 47, 21, 29, 27, 30, 21, 27, 2...
#>    ..@ label      : chr " Especialidad del egreso"
#>    ..@ format.spss: chr "F2.0"
#>    ..@ labels     : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:52] "Alergología" "Atención Primaria de la Salud" "Cardiología" "Cardiopediatría" ...
#>  $ cau_cie10 : chr+lbl [1:1000] C169 , U072 , A090 , O809 , K469 , K802 , S903 , O730...
#>    ..@ label        : chr "Causa de lista internacional detallada a 4 dígitos de la CIE-10"
#>    ..@ format.spss  : chr "A15"
#>    ..@ display_width: int 5
#>    ..@ labels       : Named chr  "A00" "B00" "C00" "D00" ...
#>    .. ..- attr(*, "names")= chr [1:18445] "Cólera" "Infecciones herpética [herpes simple]" "Tumor maligno del labio" "Carcinoma in situ de la cavidad bucal, del esófago y del estómago" ...
#>  $ cant_res  : chr+lbl [1:1000] 0901, 0901, 0901, 1207, 0901, 0901, 0901, 1701, 0901,...
#>    ..@ label        : chr "SecA Cantón de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A12"
#>    ..@ display_width: int 14
#>    ..@ labels       : Named chr  "8800" "0110" "1110" "1210" ...
#>    .. ..- attr(*, "names")= chr [1:222] "Exterior" "Oña" "Puyango" "Buena Fé" ...
#>  $ parr_res  : chr+lbl [1:1000] 090150, 090104, 090150, 120750, 090150, 090112, 09015...
#>    ..@ label        : chr "SecA Parroquia de residencia habitual del paciente"
#>    ..@ format.spss  : chr "A18"
#>    ..@ display_width: int 20
#>    ..@ labels       : Named chr  "880000" "010110" "170110" "090110" ...
#>    .. ..- attr(*, "names")= chr [1:1308] "Exterior" "San Blas" "El Condado" "Rocafuerte" ...
#>  $ causa3    : chr+lbl [1:1000] C16, U07, A09, O80, K46, K80, S90, O73, P36, J90, J44...
#>    ..@ label      : chr "Causa de lista internacional detallada a 3 dígitos de la CIE-10"
#>    ..@ format.spss: chr "A9"
#>    ..@ labels     : Named chr  "A00" "B00" "C00" "D00" ...
#>    .. ..- attr(*, "names")= chr [1:2054] "Cólera" "Infecciones herpética [herpes simple]" "Tumor maligno del labio" "Carcinoma in situ de la cavidad bucal, del esófago y del estómago" ...
#>  $ cap221rx  : dbl+lbl [1:1000]  2, 22,  1, 15, 11, 11, 19, 15, 16, 10, 10, 15, 22, 2...
#>    ..@ label        : chr "Capitulo lista 221"
#>    ..@ format.spss  : chr "F4.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:22] "I Ciertas enfermedades infecciosas y parasitarias (A00 -B99)" "II Neoplasias (C00-D48)" "III Enfermedades de la sangre y de los órganos hematopoyéticos y otros tras. que afectan el mecan. de la inmu (D50-D89)" "IV Enfermedades endocrinas, nutricionales y metabólicas  (E00-E90)" ...
#>  $ cau221rx  : dbl+lbl [1:1000]  23, 222,   1, 160, 114, 119, 205, 159, 167, 109, 105...
#>    ..@ label        : chr "Lista especial de 221 grupos"
#>    ..@ format.spss  : chr "F3.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:222] "Enfermedades infecciosas intestinales (A00-A09)" "Tuberculosis (A15-A19)" "Ciertas zoonosis bacterianas (A20-A28)" "Otras enfermedades bacterianas (A30-A49)" ...
#>  $ cau298rx  : dbl+lbl [1:1000]  60, 299,   5, 243, 188, 195, 281, 242, 250, 179, 175...
#>    ..@ label        : chr "Lista de causas 298"
#>    ..@ format.spss  : chr "F3.0"
#>    ..@ display_width: int 10
#>    ..@ labels       : Named num  1 2 3 4 5 6 7 8 9 10 ...
#>    .. ..- attr(*, "names")= chr [1:299] "Cólera" "Fiebres tifoidea y paratifoidea" "Shigelosis" "Amebiasis" ...
#>  $ csap      : chr  "não" "não" "sim" "não" ...
#>  $ grupo     : Factor w/ 20 levels "g01","g02","g03",..: 20 20 2 20 20 20 20 20 20 20 ...

## Uma base de dados com a estrutura dos "arquivos da AIH" mantendo
## todas suas variáveis
##-----------------------------------------------------------------
## Trate como se não fosse um arquivo da AIH e apenas acrescente
## a classificação ao banco:
teste11 <- csapAIH(aih500, sihsus = FALSE, cid = DIAG_PRINC)
#> Importados 500 registros.
#> Warning: ‘<’ not meaningful for factors
#> Warning: ‘>=’ not meaningful for factors
#> Excluídos 500 registros de parto (100% do total).
str(teste11)
#> 'data.frame':    0 obs. of  115 variables:
#>  $ UF_ZI     : Factor w/ 63 levels "430000","430070",..: 
#>  $ ANO_CMPT  : Factor w/ 1 level "2018": 
#>  $ MES_CMPT  : Factor w/ 1 level "01": 
#>  $ ESPEC     : Factor w/ 12 levels "01","02","03",..: 
#>  $ CGC_HOSP  : Factor w/ 261 levels "00765384000133",..: 
#>  $ N_AIH     : Factor w/ 60477 levels "4313102362129",..: 
#>  $ IDENT     : Factor w/ 2 levels "1","5": 
#>  $ CEP       : Factor w/ 13493 levels "03315000","04618003",..: 
#>  $ MUNIC_RES : Factor w/ 574 levels "110020","110140",..: 
#>  $ NASC      : Factor w/ 25848 levels "19050128","19070106",..: 
#>  $ SEXO      : Factor w/ 2 levels "1","3": 
#>  $ UTI_MES_IN: int 
#>  $ UTI_MES_AN: int 
#>  $ UTI_MES_AL: int 
#>  $ UTI_MES_TO: int 
#>  $ MARCA_UTI : Factor w/ 11 levels "00","01","74",..: 
#>  $ UTI_INT_IN: int 
#>  $ UTI_INT_AN: int 
#>  $ UTI_INT_AL: int 
#>  $ UTI_INT_TO: int 
#>  $ DIAR_ACOM : int 
#>  $ QT_DIARIAS: int 
#>  $ PROC_SOLIC: Factor w/ 1175 levels "0201010127","0201010135",..: 
#>  $ PROC_REA  : Factor w/ 1112 levels "0201010127","0201010135",..: 
#>  $ VAL_SH    : num 
#>  $ VAL_SP    : num 
#>  $ VAL_SADT  : num 
#>  $ VAL_RN    : num 
#>  $ VAL_ACOMP : num 
#>  $ VAL_ORTP  : num 
#>  $ VAL_SANGUE: num 
#>  $ VAL_SADTSR: num 
#>  $ VAL_TRANSP: num 
#>  $ VAL_OBSANG: num 
#>  $ VAL_PED1AC: num 
#>  $ VAL_TOT   : num 
#>  $ VAL_UTI   : num 
#>  $ US_TOT    : num 
#>  $ DT_INTER  : Factor w/ 235 levels "20130610","20131001",..: 
#>  $ DT_SAIDA  : Factor w/ 182 levels "20170801","20170802",..: 
#>  $ DIAG_PRINC: Factor w/ 3254 levels "A009","A020",..: 
#>  $ DIAG_SECUN: Factor w/ 1 level "0000": 
#>  $ COBRANCA  : Factor w/ 26 levels "11","12","14",..: 
#>  $ NATUREZA  : Factor w/ 1 level "00": 
#>  $ NAT_JUR   : Factor w/ 13 levels "1023","1104",..: 
#>  $ GESTAO    : Factor w/ 2 levels "1","2": 
#>  $ RUBRICA   : int 
#>  $ IND_VDRL  : Factor w/ 2 levels "0","1": 
#>  $ MUNIC_MOV : Factor w/ 232 levels "430003","430010",..: 
#>  $ COD_IDADE : Factor w/ 4 levels "2","3","4","5": 
#>  $ IDADE     : int 
#>  $ DIAS_PERM : int 
#>  $ MORTE     : int 
#>  $ NACIONAL  : Factor w/ 32 levels "010","020","021",..: 
#>  $ NUM_PROC  : Factor w/ 0 levels: 
#>  $ CAR_INT   : Factor w/ 4 levels "01","02","05",..: 
#>  $ TOT_PT_SP : int 
#>  $ CPF_AUT   : Factor w/ 0 levels: 
#>  $ HOMONIMO  : Factor w/ 3 levels "0","1","2": 
#>  $ NUM_FILHOS: int 
#>  $ INSTRU    : Factor w/ 5 levels "0","1","2","3",..: 
#>  $ CID_NOTIF : Factor w/ 1 level "Z302": 
#>  $ CONTRACEP1: Factor w/ 6 levels "00","06","08",..: 
#>  $ CONTRACEP2: Factor w/ 6 levels "00","06","08",..: 
#>  $ GESTRISCO : Factor w/ 2 levels "0","1": 
#>  $ INSC_PN   : Factor w/ 2396 levels "000000000000",..: 
#>  $ SEQ_AIH5  : Factor w/ 1 level "000": 
#>  $ CBOR      : Factor w/ 5 levels "000000","225125",..: 
#>  $ CNAER     : Factor w/ 2 levels "000","851": 
#>  $ VINCPREV  : Factor w/ 2 levels "0","1": 
#>  $ GESTOR_COD: Factor w/ 16 levels "00000","00007",..: 
#>  $ GESTOR_TP : Factor w/ 2 levels "0","1": 
#>  $ GESTOR_CPF: Factor w/ 49 levels "000000000000000",..: 
#>  $ GESTOR_DT : Factor w/ 0 levels: 
#>  $ CNES      : Factor w/ 277 levels "2223538","2223546",..: 
#>  $ CNPJ_MANT : Factor w/ 35 levels "03066309000172",..: 
#>  $ INFEHOSP  : Factor w/ 0 levels: 
#>  $ CID_ASSO  : Factor w/ 1 level "0000": 
#>  $ CID_MORTE : Factor w/ 1 level "0000": 
#>  $ COMPLEX   : Factor w/ 2 levels "02","03": 
#>  $ FINANC    : Factor w/ 2 levels "04","06": 
#>  $ FAEC_TP   : Factor w/ 13 levels "040014","040016",..: 
#>  $ REGCT     : Factor w/ 5 levels "0000","7102",..: 
#>  $ RACA_COR  : Factor w/ 6 levels "01","02","03",..: 
#>  $ ETNIA     : Factor w/ 7 levels "0000","0001",..: 
#>  $ SEQUENCIA : int 
#>  $ REMESSA   : Factor w/ 63 levels "HE43000001N201801.DTS",..: 
#>  $ AUD_JUST  : Factor w/ 11 levels "7021087628254",..: 
#>  $ SIS_JUST  : Factor w/ 20 levels "702108762825496",..: 
#>  $ VAL_SH_FED: num 
#>  $ VAL_SP_FED: num 
#>  $ VAL_SH_GES: num 
#>  $ VAL_SP_GES: num 
#>  $ VAL_UCI   : num 
#>  $ MARCA_UCI : Factor w/ 4 levels "00","01","02",..: 
#>  $ DIAGSEC1  : Factor w/ 675 levels "A049","A058",..: 
#>  $ DIAGSEC2  : Factor w/ 92 levels "A158","A419",..: 
#>  $ DIAGSEC3  : Factor w/ 41 levels "A419","B182",..: 
#>  $ DIAGSEC4  : Factor w/ 10 levels "A419","A499",..: 
#>   [list output truncated]

## Acrescentar variáveis da AIH ao banco com as CSAP
##---------------------------------------------------------
## É necessário unir o banco da AIH com as variáveis de interesse
## ao banco resultante da função 'csapAIH':
vars <- c('N_AIH', 'RACA_COR', 'INSTRU')
teste12 <- csapAIH(aih500)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
teste12 <- merge(teste12, aih500[, vars], by.x = "n.aih", by.y = "N_AIH")
names(teste12)
#>  [1] "n.aih"      "munres"     "munint"     "sexo"       "nasc"      
#>  [6] "idade"      "fxetar.det" "fxetar5"    "csap"       "grupo"     
#> [11] "cid"        "proc.rea"   "data.inter" "data.saida" "cep"       
#> [16] "cnes"       "RACA_COR"   "INSTRU"    
## Ou, usando o encadeamento ("piping") de funções,
teste13 <- csapAIH(aih500) |>
merge(aih100[, vars], by.x = "n.aih", by.y = "N_AIH")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
names(teste13)
#>  [1] "n.aih"      "munres"     "munint"     "sexo"       "nasc"      
#>  [6] "idade"      "fxetar.det" "fxetar5"    "csap"       "grupo"     
#> [11] "cid"        "proc.rea"   "data.inter" "data.saida" "cep"       
#> [16] "cnes"       "RACA_COR"   "INSTRU"    
```
