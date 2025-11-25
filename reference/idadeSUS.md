# Computa a idade nas bases de dados do SIH/SUS e SIM

Computa a idade em anos completos, a "faixa etária detalhada" e faixa
etária quinquenal do indivíduo em registros dos bancos de dados do
Sistema de Informação Hospitalar (SIH/SUS) ou do Sistema de Informação
sobre Mortalidade (SIM) do SUS.

## Usage

``` r
idadeSUS(dados, sis = "SIH")
```

## Arguments

- dados:

  Um objeto da classe \`data frame\` com a estrutura das bases de dados
  de hospitalização pelo SUS ("arquivos da AIH") ou das Declarações de
  Óbito ("arquivos do SIM").

- sis:

  O Sistema de Informação de Saúde fonte dos dados. Pode ser "SIH"
  \[padrão\], "SIM" ou "SIM-DOINF", em maiúsculas ou minúsculas

## Value

Quando `sis = "SIM-DOINF"`, devolve um fator com os componentes da Taxa
de Mortalidade Infantil. Para os dados de hospitalização (`sis = "SIH"`)
ou quando `sis = "SIM"`, devolve um objeto da classe `data frame` com
três variáveis:

1.  `idade`: idade em anos completos;

2.  `fxetar.det`: `factor` com 33 `levels`, a idade em anos completos de
    0 a 19 ("\<1ano", ..., "19anos"), em faixas quinquenais de "20-24" a
    "75-79" e "80 e +". Essa classificação é chamada pelo DATASUS de
    "idade detalhada";

3.  `fxetar5`: `factor` de 17 `levels` com a idade em faixas quinquenais
    ("0-4", ..., "75-79", "80 e +").

## Details

O campo `IDADE` nas bases de dados do SIH e do SIM não é a idade em anos
mas o tempo de vida em dias, meses, anos ou anos após a centena, de
acordo com outro campo, (`COD_IDADE`) no SIH, ou um "subcampo" (1º
dígito do campo `IDADE`) no SIM. Analisar o campo `IDADE` como se fosse
a idade em anos completos pode gerar equívocos. A função computa a idade
do indivíduo, evitando esse erro, e o classifica em faixas etárias
utilizadas pelo DATASUS em suas ferramentas de tabulação, o TABNET e
TabWin. Para os dados de hospitalização (`sis = "SIH"`) ou quando
`sis = "SIM"`, é computada a idade em anos completos, a faixa etária
quinquenal e a "faixa etária detalhada". Quando `sis = "SIM-DOINF"`, é
computada a faixa etária em menores de um ano, classificada segundo os
componentes da Taxa de Mortalidade Infantil (isto é, *Neonatal precoce*
(0 a 6 dias), *Neonatal tardia* (7 a 27 dias), *Pós-neonatal* (28 a 364
dias).

## References

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento
de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de
Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual
Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015.
87p.

Brasil. Ministério da Saúde. DATASUS. Tab para Windows - TabWin.
Ministério da Saúde: Brasília, 2010.

## Examples

``` r
if (FALSE) { # \dontrun{
df <- read.dbc::read.dbc("rdrs1801.dbc")
idades <- idadeSUS(df)

# Em ordem, para pegar apenas um fator com a categoria desejada:
## Idade em anos completos
idade.ano.a <- idadeSUS(df)[1] # "data.frame" com 1 variável
idade.ano.b <- idadeSUS(df)[,1] # vetor numérico
idade.ano.c <- idadeSUS(df)["idade"] # "data.frame" com 1 variável
all.equal(idade.ano.a, idade.ano.b)
all.equal(idade.ano.a, idade.ano.c)
all.equal(as.numeric(as.matrix(idade.ano.a)), idade.ano.b)
attributes (idade.ano.b)

## Faixa etária detalhada
idade.detalhada.a <- idadeSUS(df)[2]
idade.detalhada.b <- idadeSUS(df)[,2]
idade.detalhada.c <- idadeSUS(df)["fxetar.det"]

## Faixa etária quinquenal
idade.fxet5.a <- idadeSUS(df)[3]
idade.fxet5.a <- idadeSUS(df)[,3]
idade.fxet5.a <- idadeSUS(df)["fxetar5"]
} # }

data("aih100")
idades <- idadeSUS(aih100)
str(idades)
#> 'data.frame':    100 obs. of  3 variables:
#>  $ idade     : num  79 27 46 10 0 39 78 48 61 62 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
#>  $ fxetar.det: Factor w/ 26 levels "<1ano"," 1ano",..: 25 15 19 5 1 17 25 19 22 22 ...
#>  $ fxetar5   : Factor w/ 17 levels "0-4","5-9","10-14",..: 16 6 10 3 1 8 16 10 13 13 ...
head(idades)
#>   idade fxetar.det fxetar5
#> 1    79      75-79   75-79
#> 2    27      25-29   25-29
#> 3    46      45-49   45-49
#> 4    10     10anos   10-14
#> 5     0      <1ano     0-4
#> 6    39      35-39   35-39
idade.ano <- idadeSUS(aih100)[1] ; str(idade.ano)
#> 'data.frame':    100 obs. of  1 variable:
#>  $ idade: num  79 27 46 10 0 39 78 48 61 62 ...
#>   ..- attr(*, "comment")= chr "em anos completos"
idade.detalhada <- idadeSUS(aih100)[,2] ; str(idade.detalhada)
#>  Factor w/ 26 levels "<1ano"," 1ano",..: 25 15 19 5 1 17 25 19 22 22 ...
idade.fxet5 <- idadeSUS(aih100)["fxetar5"] ; str(idade.fxet5)
#> 'data.frame':    100 obs. of  1 variable:
#>  $ fxetar5: Factor w/ 17 levels "0-4","5-9","10-14",..: 16 6 10 3 1 8 16 10 13 13 ...

# Mortalidade
# ----------------
if (FALSE) { # \dontrun{
library(microdatasus)
dors19 <- fetch_datasus(2019, 01, 2019, 12, "RS", "SIM-DO")
idadeSUS(dors19, "sim") |> summary()
idadeSUS(dors19, "SIM-DOINF") |> summary()
} # }
```
