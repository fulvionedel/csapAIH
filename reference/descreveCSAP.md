# Tabular Condições Sensíveis à Atenção Primária

Constrói uma tabela de frequências absolutas e relativas das CSAP por
grupo de causa

## Usage

``` r
descreveCSAP(grupos, digits = 2, lang = "pt.ca", ...)
```

## Arguments

- grupos:

  Pode ser:

  - Um `data.frame` gerado pela função
    [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
    ou qualquer `data.frame` com uma variável chamada `grupo` com os
    grupos de causa da Lista Brasileira de Internações por CSAP,
    rotulados como os resultantes da função
    [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
    isto é, "g01", "g02", ..., "g19".

  - Um vetor da classe `factor` ou `character` com os grupos de causa
    CSAP, nomeados de acordo com o resultado da função
    [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md).
    Esse vetor não precisa ser gerado pela função
    [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
    mas deve conter todos os 19 grupos de causa, ainda que sua
    frequência seja zero, e também devem ser rotulados da mesma forma e
    ordem que na função, isto é, "g01", "g02", ..., "g19".

- digits:

  Número de decimais nas proporções apresentadas.

- lang:

  Define o idioma dos nomes dos grupos. O padrão é `"pt.ca"` ("português
  com acentos"). Pode ser `"pt.sa"`, `"es"` ou `"en"`.

- ...:

  Permite a inclusão de argumentos da função
  [nomesgruposCSAP](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md),
  como "`lista`", para definição da lista de causas usada, se "MS" ou
  "Alfradique".

## Value

Um objeto da classe `data.frame` com a tabulação dos códigos da CID-10
segundo os grupos de causa da Lista Brasileira de ICSAP (19 grupos), com
a frequência absoluta de casos e as porcentagens sobre o total de
internações e sobre o conjunto das ICSAP.

## Note

Os valores são armazenados em formato latino (vírgula como separador
decimal e ponto como separador de milhar) e são, portanto, da classe
`character`. Isso é indesejado, porque impede a realização de operações
matemáticas ou mesmo a aplicação direta da função
[`as.numeric`](https://rdrr.io/r/base/numeric.html), para retornar à
classe `numeric`. Para resolver esse problema foi criada uma nova função
[`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md)
que tem por output uma versão da tabela com os valores numéricos, com um
argumento para a apresentação em formato latino. Portanto, para evitar a
quebra de código já escrito, `descreveCSAP` será mantida como está, mas
não será mais desenvolvida com esse nome, sua continuidade se dará por
meio de
[`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md).
Tabulações com a lista de 20 grupos de causa deve ser feita com esta
última função.

## See also

[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
[`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md),
[`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md),
[`tabCSAP`](https://fulvionedel.github.io/csapAIH/reference/tabCSAP.md)

## Examples

``` r
data(aih100)
df = csapAIH(aih100)
#> Importados 100 registros.
#> Excluídos 15 (15%) registros de procedimentos obstétricos.
#> Excluídos 1 (1%) registros de AIH de longa permanência.
#> Exportados 84 (84%) registros.
descreveCSAP(df$grupo)
#>                                    Grupo Casos %Total %CSAP
#> 1   1. Prev. vacinação e cond. evitáveis     0   0,00  0,00
#> 2                     2. Gastroenterites     1   1,19  5,00
#> 3                              3. Anemia     0   0,00  0,00
#> 4                 4. Defic. nutricionais     0   0,00  0,00
#> 5     5. Infec. ouvido, nariz e garganta     0   0,00  0,00
#> 6              6. Pneumonias bacterianas     3   3,57 15,00
#> 7                                7. Asma     0   0,00  0,00
#> 8                          8. Pulmonares     3   3,57 15,00
#> 9                         9. Hipertensão     0   0,00  0,00
#> 10                            10. Angina     2   2,38 10,00
#> 11                   11. Insuf. cardíaca     1   1,19  5,00
#> 12                 12. Cerebrovasculares     2   2,38 10,00
#> 13                 13. Diabetes mellitus     4   4,76 20,00
#> 14                        14. Epilepsias     0   0,00  0,00
#> 15                   15. Infec. urinária     1   1,19  5,00
#> 16          16. Infec. pele e subcutâneo     1   1,19  5,00
#> 17     17. D. infl. órgãos pélvicos fem.     0   0,00  0,00
#> 18           18. Úlcera gastrointestinal     0   0,00  0,00
#> 19                 19. Pré-natal e parto     2   2,38 10,00
#> 20                            Total CSAP    20  23,81   100
#> 21                              Não-CSAP    64  76,19    --
#> 22                  Total de internações    84    100    --
descreveCSAP(df)
#>                                    Grupo Casos %Total %CSAP
#> 1   1. Prev. vacinação e cond. evitáveis     0   0,00  0,00
#> 2                     2. Gastroenterites     1   1,19  5,00
#> 3                              3. Anemia     0   0,00  0,00
#> 4                 4. Defic. nutricionais     0   0,00  0,00
#> 5     5. Infec. ouvido, nariz e garganta     0   0,00  0,00
#> 6              6. Pneumonias bacterianas     3   3,57 15,00
#> 7                                7. Asma     0   0,00  0,00
#> 8                          8. Pulmonares     3   3,57 15,00
#> 9                         9. Hipertensão     0   0,00  0,00
#> 10                            10. Angina     2   2,38 10,00
#> 11                   11. Insuf. cardíaca     1   1,19  5,00
#> 12                 12. Cerebrovasculares     2   2,38 10,00
#> 13                 13. Diabetes mellitus     4   4,76 20,00
#> 14                        14. Epilepsias     0   0,00  0,00
#> 15                   15. Infec. urinária     1   1,19  5,00
#> 16          16. Infec. pele e subcutâneo     1   1,19  5,00
#> 17     17. D. infl. órgãos pélvicos fem.     0   0,00  0,00
#> 18           18. Úlcera gastrointestinal     0   0,00  0,00
#> 19                 19. Pré-natal e parto     2   2,38 10,00
#> 20                            Total CSAP    20  23,81   100
#> 21                              Não-CSAP    64  76,19    --
#> 22                  Total de internações    84    100    --

df = csapAIH(eeh20, sihsus = FALSE, cid = cau_cie10, lista = "Alfradique")
#> Importados 1.000 registros.
#> Excluídos 150 registros de parto (15% do total).
descreveCSAP(df$grupo)
#>                                  Grupo Casos %Total %CSAP
#> 1               1. Prev. por vacinação     0   0,00  0,00
#> 2            2. Outras cond. evitáveis     2   0,24  1,94
#> 3                   3. Gastroenterites    11   1,29 10,68
#> 4                            4. Anemia     2   0,24  1,94
#> 5               5. Defic. nutricionais     0   0,00  0,00
#> 6   6. Infec. ouvido, nariz e garganta     2   0,24  1,94
#> 7            7. Pneumonias bacterianas     2   0,24  1,94
#> 8                              8. Asma     2   0,24  1,94
#> 9                        9. Pulmonares     5   0,59  4,85
#> 10                     10. Hipertensão     6   0,71  5,83
#> 11                          11. Angina     2   0,24  1,94
#> 12                 12. Insuf. cardíaca     4   0,47  3,88
#> 13               13. Cerebrovasculares     4   0,47  3,88
#> 14               14. Diabetes mellitus    13   1,53 12,62
#> 15                      15. Epilepsias     6   0,71  5,83
#> 16                 16. Infec. urinária    13   1,53 12,62
#> 17        17. Infec. pele e subcutâneo    10   1,18  9,71
#> 18   18. D. infl. órgãos pélvicos fem.     4   0,47  3,88
#> 19         19. Úlcera gastrointestinal     2   0,24  1,94
#> 20               20. Pré-natal e parto    13   1,53 12,62
#> 21                          Total CSAP   103  12,12   100
#> 22                            Não-CSAP   747  87,88    --
#> 23                Total de internações   850    100    --
descreveCSAP(df, lang = "es")
#>                                        Grupo Casos %Total %CSAP
#> 1                    1. Prev. por vacunación     0   0,00  0,00
#> 2   2. Afec. prev. incluidas FR, sífilis, TB     2   0,24  1,94
#> 3                         3. Gastroenteritis    11   1,29 10,68
#> 4                                  4. Anemia     2   0,24  1,94
#> 5                      5. Def. nutricionales     0   0,00  0,00
#> 6           6. Infec. oído, nariz y garganta     2   0,24  1,94
#> 7                     7. Neumonía bacteriana     2   0,24  1,94
#> 8                                    8. Asma     2   0,24  1,94
#> 9      9. Enf. vías respiratorias inferiores     5   0,59  4,85
#> 10                          10. Hipertensión     6   0,71  5,83
#> 11                       11. Angina de pecho     2   0,24  1,94
#> 12            12. Insuf. cardíaca congestiva     4   0,47  3,88
#> 13                13. Enf. cerebrovasculares     4   0,47  3,88
#> 14                     14. Diabetes mellitus    13   1,53 12,62
#> 15                            15. Epilepsias     6   0,71  5,83
#> 16                    16. Infección urinaria    13   1,53 12,62
#> 17              17. Infec. piel y subcutáneo    10   1,18  9,71
#> 18   18. Enf infl órganos pélvicos femeninos     4   0,47  3,88
#> 19               19. Úlcera gastrointestinal     2   0,24  1,94
#> 20  20. Enf. del embarazo, parto y puerperio    13   1,53 12,62
#> 21                                Total CSAP   103  12,12   100
#> 22                                   No-CSAP   747  87,88    --
#> 23                         Total de ingresos   850    100    --
```
