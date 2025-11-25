# Classifica códigos da CID-10 em Capítulos

Tomando um vetor com códigos da 10ª Revisão da Classificação
Internacional de Doenças (CID-10), acrescenta uma variável com os
capítulos da CID-10 correspondentes.

## Usage

``` r
cid10cap(cid, droplevels = FALSE)
```

## Arguments

- cid:

  Nome do vetor com os códigos da CID-10.

- droplevels:

  Se TRUE, desconsidera os capítulos sem nenhuma ocorrência de casos. O
  padrão é FALSE, o que retorna uma tabela com zeros nos capítulos sem
  ocorrência de casos.

## Value

Um `factor` com o capítulo da CID-10 correspondente a cada código
diagnóstico.

## Examples

``` r
# Arquivos da AIH
cid10cap(aih500$DIAG_PRINC) |> table()
#> 
#>                                               I.     Algumas doenças infecciosas e parasitárias 
#>                                                                                              20 
#>                                                                     II.    Neoplasias (tumores) 
#>                                                                                              50 
#>                                            III.   Doenças sangue órgãos hemat e transt imunitár 
#>                                                                                               4 
#>                                            IV.    Doenças endócrinas nutricionais e metabólicas 
#>                                                                                              13 
#>                                                    V.     Transtornos mentais e comportamentais 
#>                                                                                              30 
#>                                                               VI.    Doenças do sistema nervoso 
#>                                                                                              14 
#>                                                                 VII.   Doenças do olho e anexos 
#>                                                                                               0 
#>                                                  VIII.  Doenças do ouvido e da apófise mastóide 
#>                                                                                               1 
#>                                                         IX.    Doenças do aparelho circulatório 
#>                                                                                              73 
#>                                                         X.     Doenças do aparelho respiratório 
#>                                                                                              40 
#>                                                            XI.    Doenças do aparelho digestivo 
#>                                                                                              46 
#>                                                   XII.   Doenças da pele e do tecido subcutâneo 
#>                                                                                               7 
#>                                              XIII.  Doenças sist osteomuscular e tec conjuntivo 
#>                                                                                               7 
#>                                                        XIV.   Doenças do aparelho geniturinário 
#>                                                                                              43 
#>                                                               XV.    Gravidez parto e puerpério 
#>                                                                                              77 
#>                                             XVI.   Algumas afec originadas no período perinatal 
#>                                                                                              13 
#>                                             XVII.  Malf cong deformid e anomalias cromossômicas 
#>                                                                                               2 
#>                                              XVIII. Sint sinais e achad anorm ex clín e laborat 
#>                                                                                               9 
#>                 XIX.   Lesões, envenenamentos e algumas outras consequências de causas externas 
#>                                                                                              40 
#>                                               XX.    Causas externas de morbidade e mortalidade 
#>                                                                                               0 
#> XXI.   Fatores que exercem influência sobre o estado de saúde e o contato com serviços de saúde 
#>                                                                                              11 
cid10cap(aih500$DIAG_PRINC, droplevels = TRUE) |> table()
#> 
#>                                               I.     Algumas doenças infecciosas e parasitárias 
#>                                                                                              20 
#>                                                                     II.    Neoplasias (tumores) 
#>                                                                                              50 
#>                                            III.   Doenças sangue órgãos hemat e transt imunitár 
#>                                                                                               4 
#>                                            IV.    Doenças endócrinas nutricionais e metabólicas 
#>                                                                                              13 
#>                                                    V.     Transtornos mentais e comportamentais 
#>                                                                                              30 
#>                                                               VI.    Doenças do sistema nervoso 
#>                                                                                              14 
#>                                                  VIII.  Doenças do ouvido e da apófise mastóide 
#>                                                                                               1 
#>                                                         IX.    Doenças do aparelho circulatório 
#>                                                                                              73 
#>                                                         X.     Doenças do aparelho respiratório 
#>                                                                                              40 
#>                                                            XI.    Doenças do aparelho digestivo 
#>                                                                                              46 
#>                                                   XII.   Doenças da pele e do tecido subcutâneo 
#>                                                                                               7 
#>                                              XIII.  Doenças sist osteomuscular e tec conjuntivo 
#>                                                                                               7 
#>                                                        XIV.   Doenças do aparelho geniturinário 
#>                                                                                              43 
#>                                                               XV.    Gravidez parto e puerpério 
#>                                                                                              77 
#>                                             XVI.   Algumas afec originadas no período perinatal 
#>                                                                                              13 
#>                                             XVII.  Malf cong deformid e anomalias cromossômicas 
#>                                                                                               2 
#>                                              XVIII. Sint sinais e achad anorm ex clín e laborat 
#>                                                                                               9 
#>                 XIX.   Lesões, envenenamentos e algumas outras consequências de causas externas 
#>                                                                                              40 
#> XXI.   Fatores que exercem influência sobre o estado de saúde e o contato com serviços de saúde 
#>                                                                                              11 

# Arquivos da DO
if (FALSE) { # \dontrun{
  cid10cap(Rcoisas::obitosRS2019$CAUSABAS) |> table()
} # }
```
