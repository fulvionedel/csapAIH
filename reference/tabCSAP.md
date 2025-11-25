# Tabular Condições Sensíveis à Atenção Primária (CSAP)

Tabular Condições Sensíveis à Atenção Primária (CSAP) segundo a Lista
Brasileira de Internações por Condições Sensíveis à Atenção Primária.
Permite o uso da lista da portaria ministerial, com 19 grupos de causa,
e da lista publicada por Alfradique et al., com 20 grupos de causa.

## Usage

``` r
tabCSAP(x, digits = 2, lang = "pt.ca", format = FALSE)
```

## Arguments

- x:

  Um vetor da classe `factor` com os grupos de causa CSAP, nomeados de
  acordo com o resultado da função
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md).
  Esse vetor não precisa ser gerado pela função
  [`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
  mas deve conter todos os 19 ou 20 grupos de causa da lista utilizada,
  ainda que sua frequência seja zero, e também devem ser rotulados da
  mesma forma e ordem que na função, isto é, "g01", "g02", ..., "g19" ou
  "g20".

- digits:

  número de decimais para o arredondamento (com
  [`round`](https://rdrr.io/r/base/Round.html)).

- lang:

  idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca"
  (default) para nomes em português com acentos; "pt.sa" para nomes em
  português sem acentos; "en" para nomes em inglês; ou "es" para nomes
  em castelhano.

- format:

  A tabela deve ser formatada para impressão? (default = FALSE).

## Value

Uma tabela com a frequência absoluta dos grupos de causa e sua
distribuição proporcional sobre o total de internações e sobre o total
de ICSAP. \#'

## References

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No
221, de 17 de abril de 2008.
[http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html](http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.md)

## See also

[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
[`nomesgruposCSAP`](https://fulvionedel.github.io/csapAIH/reference/nomesgruposCSAP.md)

## Examples

``` r
# data("aih500")
tabCSAP(csapAIH(aih500)$grupo)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                    grupo casos perctot percsap
#> 1   1. Prev. vacinação e cond. evitáveis     0    0.00    0.00
#> 2                     2. Gastroenterites     6    1.38    6.25
#> 3                              3. Anemia     0    0.00    0.00
#> 4                 4. Defic. nutricionais     3    0.69    3.12
#> 5     5. Infec. ouvido, nariz e garganta     0    0.00    0.00
#> 6              6. Pneumonias bacterianas     7    1.61    7.29
#> 7                                7. Asma     0    0.00    0.00
#> 8                          8. Pulmonares     9    2.07    9.38
#> 9                         9. Hipertensão     2    0.46    2.08
#> 10                            10. Angina    11    2.53   11.46
#> 11                   11. Insuf. cardíaca    13    2.99   13.54
#> 12                 12. Cerebrovasculares    11    2.53   11.46
#> 13                 13. Diabetes mellitus     8    1.84    8.33
#> 14                        14. Epilepsias     5    1.15    5.21
#> 15                   15. Infec. urinária    12    2.76   12.50
#> 16          16. Infec. pele e subcutâneo     1    0.23    1.04
#> 17     17. D. infl. órgãos pélvicos fem.     1    0.23    1.04
#> 18           18. Úlcera gastrointestinal     1    0.23    1.04
#> 19                 19. Pré-natal e parto     6    1.38    6.25
#> 20                            Total CSAP    96   22.07  100.00
#> 21                              Não-CSAP   339   77.93      NA
#> 22                  Total de internações   435  100.00      NA
tabCSAP(csapAIH(aih500)$grupo, lang = "pt.sa")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                    grupo casos perctot percsap
#> 1   1. Prev. vacinacao e cond. evitaveis     0    0.00    0.00
#> 2                     2. Gastroenterites     6    1.38    6.25
#> 3                              3. Anemia     0    0.00    0.00
#> 4                     4. Def. nutricion.     3    0.69    3.12
#> 5     5. Infec. ouvido, nariz e garganta     0    0.00    0.00
#> 6              6. Pneumonias bacterianas     7    1.61    7.29
#> 7                                7. Asma     0    0.00    0.00
#> 8                          8. Pulmonares     9    2.07    9.38
#> 9                         9. Hipertensao     2    0.46    2.08
#> 10                            10. Angina    11    2.53   11.46
#> 11                   11. Insuf. cardiaca    13    2.99   13.54
#> 12                 12. Cerebrovasculares    11    2.53   11.46
#> 13                 13. Diabetes mellitus     8    1.84    8.33
#> 14                        14. Epilepsias     5    1.15    5.21
#> 15                   15. Infec. urinaria    12    2.76   12.50
#> 16          16. Infec. pele e subcutaneo     1    0.23    1.04
#> 17     17. D. infl. Orgaos pelvicos fem.     1    0.23    1.04
#> 18           18. Ulcera gastrointestinal     1    0.23    1.04
#> 19                 19. Pre-natal e parto     6    1.38    6.25
#> 20                            Total CSAP    96   22.07  100.00
#> 21                              Nao-CSAP   339   77.93      NA
#> 22                  Total de internacoes   435  100.00      NA
tabCSAP(csapAIH(aih500)$grupo, lang = "en")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                   grupo casos perctot percsap
#> 1   1. Vaccine prev. and amenable cond.     0    0.00    0.00
#> 2                    2. Gastroenteritis     6    1.38    6.25
#> 3                             3. Anemia     0    0.00    0.00
#> 4             4. Nutritional deficiency     3    0.69    3.12
#> 5        5. Ear, nose and throat infec.     0    0.00    0.00
#> 6                6. Bacterial pneumonia     7    1.61    7.29
#> 7                             7. Asthma     0    0.00    0.00
#> 8                          8. Pulmonary     9    2.07    9.38
#> 9                       9. Hypertension     2    0.46    2.08
#> 10                           10. Angina    11    2.53   11.46
#> 11                    11. Heart failure    13    2.99   13.54
#> 12                  12. Cerebrovascular    11    2.53   11.46
#> 13                13. Diabetes mellitus     8    1.84    8.33
#> 14         14. Convulsions and epilepsy     5    1.15    5.21
#> 15                15. Urinary infection    12    2.76   12.50
#> 16     16. Skin and subcutaneous infec.     1    0.23    1.04
#> 17      17. Pelvic inflammatory disease     1    0.23    1.04
#> 18          18. Gastrointestinal ulcers     1    0.23    1.04
#> 19         19. Pre-natal and childbirth     6    1.38    6.25
#> 20                                 ACSC    96   22.07  100.00
#> 21                             Non ACSC   339   77.93      NA
#> 22               TOTAL hospitalizations   435  100.00      NA
tabCSAP(csapAIH(aih500)$grupo, lang = "es")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                       grupo casos perctot percsap
#> 1        1. Prev. vacunación y otros medios     0    0.00    0.00
#> 2                        2. Gastroenteritis     6    1.38    6.25
#> 3                                 3. Anemia     0    0.00    0.00
#> 4                     4. Def. nutricionales     3    0.69    3.12
#> 5          5. Infec. oído, nariz y garganta     0    0.00    0.00
#> 6                    6. Neumonía bacteriana     7    1.61    7.29
#> 7                                   7. Asma     0    0.00    0.00
#> 8     8. Enf. vías respiratorias inferiores     9    2.07    9.38
#> 9                           9. Hipertensión     2    0.46    2.08
#> 10                      10. Angina de pecho    11    2.53   11.46
#> 11           11. Insuf. cardíaca congestiva    13    2.99   13.54
#> 12               12. Enf. cerebrovasculares    11    2.53   11.46
#> 13                    13. Diabetes mellitus     8    1.84    8.33
#> 14                           14. Epilepsias     5    1.15    5.21
#> 15                   15. Infección urinaria    12    2.76   12.50
#> 16             16. Infec. piel y subcutáneo     1    0.23    1.04
#> 17  17. Enf infl órganos pélvicos femeninos     1    0.23    1.04
#> 18              18. Úlcera gastrointestinal     1    0.23    1.04
#> 19 19. Enf. del embarazo, parto y puerperio     6    1.38    6.25
#> 20                               Total CSAP    96   22.07  100.00
#> 21                                  No-CSAP   339   77.93      NA
#> 22                        Total de ingresos   435  100.00      NA
tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                  grupo casos perctot percsap
#> 1               1. Prev. por vacinação     0    0.00    0.00
#> 2            2. Outras cond. evitáveis     0    0.00    0.00
#> 3                   3. Gastroenterites     6    1.38    6.25
#> 4                            4. Anemia     0    0.00    0.00
#> 5               5. Defic. nutricionais     3    0.69    3.12
#> 6   6. Infec. ouvido, nariz e garganta     0    0.00    0.00
#> 7            7. Pneumonias bacterianas     7    1.61    7.29
#> 8                              8. Asma     0    0.00    0.00
#> 9                        9. Pulmonares     9    2.07    9.38
#> 10                     10. Hipertensão     2    0.46    2.08
#> 11                          11. Angina    11    2.53   11.46
#> 12                 12. Insuf. cardíaca    13    2.99   13.54
#> 13               13. Cerebrovasculares    11    2.53   11.46
#> 14               14. Diabetes mellitus     8    1.84    8.33
#> 15                      15. Epilepsias     5    1.15    5.21
#> 16                 16. Infec. urinária    12    2.76   12.50
#> 17        17. Infec. pele e subcutâneo     1    0.23    1.04
#> 18   18. D. infl. órgãos pélvicos fem.     1    0.23    1.04
#> 19         19. Úlcera gastrointestinal     1    0.23    1.04
#> 20               20. Pré-natal e parto     6    1.38    6.25
#> 21                          Total CSAP    96   22.07  100.00
#> 22                            Não-CSAP   339   77.93      NA
#> 23                Total de internações   435  100.00      NA
tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "pt.sa")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                  grupo casos perctot percsap
#> 1               1. Prev. por vacinacao     0    0.00    0.00
#> 2            2. Outras cond. evitaveis     0    0.00    0.00
#> 3                   3. Gastroenterites     6    1.38    6.25
#> 4                            4. Anemia     0    0.00    0.00
#> 5                   5. Def. nutricion.     3    0.69    3.12
#> 6   6. Infec. ouvido, nariz e garganta     0    0.00    0.00
#> 7            7. Pneumonias bacterianas     7    1.61    7.29
#> 8                              8. Asma     0    0.00    0.00
#> 9                        9. Pulmonares     9    2.07    9.38
#> 10                     10. Hipertensao     2    0.46    2.08
#> 11                          11. Angina    11    2.53   11.46
#> 12                 12. Insuf. cardiaca    13    2.99   13.54
#> 13               13. Cerebrovasculares    11    2.53   11.46
#> 14               14. Diabetes mellitus     8    1.84    8.33
#> 15                      15. Epilepsias     5    1.15    5.21
#> 16                 16. Infec. urinaria    12    2.76   12.50
#> 17        17. Infec. pele e subcutaneo     1    0.23    1.04
#> 18   18. D. infl. Orgaos pelvicos fem.     1    0.23    1.04
#> 19         19. Ulcera gastrointestinal     1    0.23    1.04
#> 20               20. Pre-natal e parto     6    1.38    6.25
#> 21                          Total CSAP    96   22.07  100.00
#> 22                            Nao-CSAP   339   77.93      NA
#> 23                Total de internacoes   435  100.00      NA
tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "en")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                               grupo casos perctot percsap
#> 1            1. Vaccine preventable     0    0.00    0.00
#> 2      2. Other amenable conditions     0    0.00    0.00
#> 3                3. Gastroenteritis     6    1.38    6.25
#> 4                         4. Anemia     0    0.00    0.00
#> 5         5. Nutritional deficiency     3    0.69    3.12
#> 6    6. Ear, nose and throat infec.     0    0.00    0.00
#> 7            7. Bacterial pneumonia     7    1.61    7.29
#> 8                         8. Asthma     0    0.00    0.00
#> 9                      9. Pulmonary     9    2.07    9.38
#> 10                 10. Hypertension     2    0.46    2.08
#> 11                       11. Angina    11    2.53   11.46
#> 12                12. Heart failure    13    2.99   13.54
#> 13              13. Cerebrovascular    11    2.53   11.46
#> 14            14. Diabetes mellitus     8    1.84    8.33
#> 15     15. Convulsions and epilepsy     5    1.15    5.21
#> 16            16. Urinary infection    12    2.76   12.50
#> 17 17. Skin and subcutaneous infec.     1    0.23    1.04
#> 18  18. Pelvic inflammatory disease     1    0.23    1.04
#> 19      19. Gastrointestinal ulcers     1    0.23    1.04
#> 20     20. Pre-natal and childbirth     6    1.38    6.25
#> 21                             ACSC    96   22.07  100.00
#> 22                         Non ACSC   339   77.93      NA
#> 23           TOTAL hospitalizations   435  100.00      NA
tabCSAP(csapAIH(aih500, lista = "Alfradique")$grupo,lang = "es")
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#>                                        grupo casos perctot percsap
#> 1                    1. Prev. por vacunación     0    0.00    0.00
#> 2   2. Afec. prev. incluidas FR, sífilis, TB     0    0.00    0.00
#> 3                         3. Gastroenteritis     6    1.38    6.25
#> 4                                  4. Anemia     0    0.00    0.00
#> 5                      5. Def. nutricionales     3    0.69    3.12
#> 6           6. Infec. oído, nariz y garganta     0    0.00    0.00
#> 7                     7. Neumonía bacteriana     7    1.61    7.29
#> 8                                    8. Asma     0    0.00    0.00
#> 9      9. Enf. vías respiratorias inferiores     9    2.07    9.38
#> 10                          10. Hipertensión     2    0.46    2.08
#> 11                       11. Angina de pecho    11    2.53   11.46
#> 12            12. Insuf. cardíaca congestiva    13    2.99   13.54
#> 13                13. Enf. cerebrovasculares    11    2.53   11.46
#> 14                     14. Diabetes mellitus     8    1.84    8.33
#> 15                            15. Epilepsias     5    1.15    5.21
#> 16                    16. Infección urinaria    12    2.76   12.50
#> 17              17. Infec. piel y subcutáneo     1    0.23    1.04
#> 18   18. Enf infl órganos pélvicos femeninos     1    0.23    1.04
#> 19               19. Úlcera gastrointestinal     1    0.23    1.04
#> 20  20. Enf. del embarazo, parto y puerperio     6    1.38    6.25
#> 21                                Total CSAP    96   22.07  100.00
#> 22                                   No-CSAP   339   77.93      NA
#> 23                         Total de ingresos   435  100.00      NA
```
