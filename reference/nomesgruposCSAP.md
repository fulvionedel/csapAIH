# Nomes dos grupos de causa da Lista Brasileira de Condições Sensíveis à Atenção Primária

Lista os grupos de causa da Lista Brasileira de Condições Sensíveis à
Atenção Primária, segundo a Portaria do Ministério da Saúde do Brasil,
com 19 grupos, ou segundo a publicação em Alfradique et al. (2009), com
20 grupos. Facilita a inclusão ddo grupo de causa como uma variável de
um banco de dados. O texto pode ser apresentado em português, espanhol
ou inglês.

## Usage

``` r
nomesgruposCSAP(
  lista = "MS",
  lang = "pt.ca",
  classe = "vetor",
  numgrupo = FALSE
)
```

## Arguments

- lista:

  Lista de causas a ser considerada; pode ser `"MS"` (default) para a
  lista publicada em portaria pelo Ministério da Saúde do Brasil ou
  "Alfradique" para a lista publicada no artigo de Alfradique et al.

- lang:

  idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca"
  (default) para nomes em português com acentos; "pt.sa" para nomes em
  português sem acentos; "en" para nomes em inglês; ou "es" para nomes
  em castelhano.

- classe:

  O output da função deve ser (1) um vetor com a lista dos nomes
  (padrão, definido por `"vetor"`, `"v"` ou `1`) ou (2) um "data frame"
  com uma variável com o código do grupo ("g01", etc.) e outra com o
  nome (definido por `"data.frame"`, `"df"` ou `2`)?

- numgrupo:

  No caso de se definir um "data frame" no parâmetro `classe`, a
  variável com o nome do grupo deve iniciar com o número do grupo? (v.
  exemplos).

## Value

Um vetor da classe `character` ou uma tabela na classe `data frame` com
os nomes (abreviados) dos grupos de causa segundo a lista definida pelo
usuário.

## References

Alfradique ME et al. Internações por condições sensíveis à atenção
primária: a construção da lista brasileira como ferramenta para medir o
desempenho do sistema de saúde (Projeto ICSAP - Brasil). Cadernos de
Saúde Pública. 2009; 25(6):1337-1349.
https://doi.org/10.1590/S0102-311X2009000600016.

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Portaria No
221, de 17 de abril de 2008.
[http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.html](http://bvsms.saude.gov.br/bvs/saudelegis/sas/2008/prt0221_17_04_2008.md)

## See also

[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md),
[`descreveCSAP`](https://fulvionedel.github.io/csapAIH/reference/descreveCSAP.md),
[`desenhaCSAP`](https://fulvionedel.github.io/csapAIH/reference/desenhaCSAP.md)

## Examples

``` r
nomesgruposCSAP()
#>  [1] " 1. Prev. vacinação e cond. evitáveis"
#>  [2] " 2. Gastroenterites"                  
#>  [3] " 3. Anemia"                           
#>  [4] " 4. Defic. nutricionais"              
#>  [5] " 5. Infec. ouvido, nariz e garganta"  
#>  [6] " 6. Pneumonias bacterianas"           
#>  [7] " 7. Asma"                             
#>  [8] " 8. Pulmonares"                       
#>  [9] " 9. Hipertensão"                      
#> [10] "10. Angina"                           
#> [11] "11. Insuf. cardíaca"                  
#> [12] "12. Cerebrovasculares"                
#> [13] "13. Diabetes mellitus"                
#> [14] "14. Epilepsias"                       
#> [15] "15. Infec. urinária"                  
#> [16] "16. Infec. pele e subcutâneo"         
#> [17] "17. D. infl. órgãos pélvicos fem."    
#> [18] "18. Úlcera gastrointestinal"          
#> [19] "19. Pré-natal e parto"                
nomesgruposCSAP(classe = "df")
#>    grupo                         nomegrupo
#> 1    g01 Prev. vacinação e cond. evitáveis
#> 2    g02                   Gastroenterites
#> 3    g03                            Anemia
#> 4    g04               Defic. nutricionais
#> 5    g05   Infec. ouvido, nariz e garganta
#> 6    g06            Pneumonias bacterianas
#> 7    g07                              Asma
#> 8    g08                        Pulmonares
#> 9    g09                       Hipertensão
#> 10   g10                            Angina
#> 11   g11                   Insuf. cardíaca
#> 12   g12                 Cerebrovasculares
#> 13   g13                 Diabetes mellitus
#> 14   g14                        Epilepsias
#> 15   g15                   Infec. urinária
#> 16   g16          Infec. pele e subcutâneo
#> 17   g17     D. infl. órgãos pélvicos fem.
#> 18   g18           Úlcera gastrointestinal
#> 19   g19                 Pré-natal e parto
nomesgruposCSAP(classe = "df", numgrupo = TRUE)
#>    grupo                             nomegrupo
#> 1    g01  1. Prev. vacinação e cond. evitáveis
#> 2    g02                    2. Gastroenterites
#> 3    g03                             3. Anemia
#> 4    g04                4. Defic. nutricionais
#> 5    g05    5. Infec. ouvido, nariz e garganta
#> 6    g06             6. Pneumonias bacterianas
#> 7    g07                               7. Asma
#> 8    g08                         8. Pulmonares
#> 9    g09                        9. Hipertensão
#> 10   g10                            10. Angina
#> 11   g11                   11. Insuf. cardíaca
#> 12   g12                 12. Cerebrovasculares
#> 13   g13                 13. Diabetes mellitus
#> 14   g14                        14. Epilepsias
#> 15   g15                   15. Infec. urinária
#> 16   g16          16. Infec. pele e subcutâneo
#> 17   g17     17. D. infl. órgãos pélvicos fem.
#> 18   g18           18. Úlcera gastrointestinal
#> 19   g19                 19. Pré-natal e parto
nomesgruposCSAP(lang = "pt.sa")
#>  [1] " 1. Prev. vacinacao e cond. evitaveis"
#>  [2] " 2. Gastroenterites"                  
#>  [3] " 3. Anemia"                           
#>  [4] " 4. Def. nutricion."                  
#>  [5] " 5. Infec. ouvido, nariz e garganta"  
#>  [6] " 6. Pneumonias bacterianas"           
#>  [7] " 7. Asma"                             
#>  [8] " 8. Pulmonares"                       
#>  [9] " 9. Hipertensao"                      
#> [10] "10. Angina"                           
#> [11] "11. Insuf. cardiaca"                  
#> [12] "12. Cerebrovasculares"                
#> [13] "13. Diabetes mellitus"                
#> [14] "14. Epilepsias"                       
#> [15] "15. Infec. urinaria"                  
#> [16] "16. Infec. pele e subcutaneo"         
#> [17] "17. D. infl. Orgaos pelvicos fem."    
#> [18] "18. Ulcera gastrointestinal"          
#> [19] "19. Pre-natal e parto"                
nomesgruposCSAP(lang = "en")
#>  [1] " 1. Vaccine prev. and amenable cond."
#>  [2] " 2. Gastroenteritis"                 
#>  [3] " 3. Anemia"                          
#>  [4] " 4. Nutritional deficiency"          
#>  [5] " 5. Ear, nose and throat infec."     
#>  [6] " 6. Bacterial pneumonia"             
#>  [7] " 7. Asthma"                          
#>  [8] " 8. Pulmonary"                       
#>  [9] " 9. Hypertension"                    
#> [10] "10. Angina"                          
#> [11] "11. Heart failure"                   
#> [12] "12. Cerebrovascular"                 
#> [13] "13. Diabetes mellitus"               
#> [14] "14. Convulsions and epilepsy"        
#> [15] "15. Urinary infection"               
#> [16] "16. Skin and subcutaneous infec."    
#> [17] "17. Pelvic inflammatory disease"     
#> [18] "18. Gastrointestinal ulcers"         
#> [19] "19. Pre-natal and childbirth"        
nomesgruposCSAP(lang = "es")
#>  [1] " 1. Prev. vacunación y otros medios"     
#>  [2] " 2. Gastroenteritis"                     
#>  [3] " 3. Anemia"                              
#>  [4] " 4. Def. nutricionales"                  
#>  [5] " 5. Infec. oído, nariz y garganta"       
#>  [6] " 6. Neumonía bacteriana"                 
#>  [7] " 7. Asma"                                
#>  [8] " 8. Enf. vías respiratorias inferiores"  
#>  [9] " 9. Hipertensión"                        
#> [10] "10. Angina de pecho"                     
#> [11] "11. Insuf. cardíaca congestiva"          
#> [12] "12. Enf. cerebrovasculares"              
#> [13] "13. Diabetes mellitus"                   
#> [14] "14. Epilepsias"                          
#> [15] "15. Infección urinaria"                  
#> [16] "16. Infec. piel y subcutáneo"            
#> [17] "17. Enf infl órganos pélvicos femeninos" 
#> [18] "18. Úlcera gastrointestinal"             
#> [19] "19. Enf. del embarazo, parto y puerperio"
nomesgruposCSAP(lista = 'Alfradique')
#>  [1] " 1. Prev. por vacinação"             " 2. Outras cond. evitáveis"         
#>  [3] " 3. Gastroenterites"                 " 4. Anemia"                         
#>  [5] " 5. Defic. nutricionais"             " 6. Infec. ouvido, nariz e garganta"
#>  [7] " 7. Pneumonias bacterianas"          " 8. Asma"                           
#>  [9] " 9. Pulmonares"                      "10. Hipertensão"                    
#> [11] "11. Angina"                          "12. Insuf. cardíaca"                
#> [13] "13. Cerebrovasculares"               "14. Diabetes mellitus"              
#> [15] "15. Epilepsias"                      "16. Infec. urinária"                
#> [17] "17. Infec. pele e subcutâneo"        "18. D. infl. órgãos pélvicos fem."  
#> [19] "19. Úlcera gastrointestinal"         "20. Pré-natal e parto"              
nomesgruposCSAP(lista = 'Alfradique', classe = "df")
#>    grupo                       nomegrupo
#> 1    g01             Prev. por vacinação
#> 2    g02          Outras cond. evitáveis
#> 3    g03                 Gastroenterites
#> 4    g04                          Anemia
#> 5    g05             Defic. nutricionais
#> 6    g06 Infec. ouvido, nariz e garganta
#> 7    g07          Pneumonias bacterianas
#> 8    g08                            Asma
#> 9    g09                      Pulmonares
#> 10   g10                     Hipertensão
#> 11   g11                          Angina
#> 12   g12                 Insuf. cardíaca
#> 13   g13               Cerebrovasculares
#> 14   g14               Diabetes mellitus
#> 15   g15                      Epilepsias
#> 16   g16                 Infec. urinária
#> 17   g17        Infec. pele e subcutâneo
#> 18   g18   D. infl. órgãos pélvicos fem.
#> 19   g19         Úlcera gastrointestinal
#> 20   g20               Pré-natal e parto
nomesgruposCSAP(lista = 'Alfradique', lang = 'es',
                classe = 'df', numgrupo = TRUE)
#>    grupo                                 nomegrupo
#> 1    g01                   1. Prev. por vacunación
#> 2    g02  2. Afec. prev. incluidas FR, sífilis, TB
#> 3    g03                        3. Gastroenteritis
#> 4    g04                                 4. Anemia
#> 5    g05                     5. Def. nutricionales
#> 6    g06          6. Infec. oído, nariz y garganta
#> 7    g07                    7. Neumonía bacteriana
#> 8    g08                                   8. Asma
#> 9    g09     9. Enf. vías respiratorias inferiores
#> 10   g10                          10. Hipertensión
#> 11   g11                       11. Angina de pecho
#> 12   g12            12. Insuf. cardíaca congestiva
#> 13   g13                13. Enf. cerebrovasculares
#> 14   g14                     14. Diabetes mellitus
#> 15   g15                            15. Epilepsias
#> 16   g16                    16. Infección urinaria
#> 17   g17              17. Infec. piel y subcutáneo
#> 18   g18   18. Enf infl órganos pélvicos femeninos
#> 19   g19               19. Úlcera gastrointestinal
#> 20   g20  20. Enf. del embarazo, parto y puerperio

# Uso de `classe = 'df'`
require(dplyr)
#> Loading required package: dplyr
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union
## Inclui o nome do grupo como uma variável no banco de dados:
aih100 %>%
  csapAIH() %>%
  filter(csap == "sim") %>%
  select(c(4, 6, 9:11)) %>%
  left_join(nomesgruposCSAP(classe = 'df'))
#> Importados 100 registros.
#> Excluídos 15 (15%) registros de procedimentos obstétricos.
#> Excluídos 1 (1%) registros de AIH de longa permanência.
#> Exportados 84 (84%) registros.
#> Joining with `by = join_by(grupo)`
#>    sexo idade csap grupo  cid                nomegrupo
#> 1   fem    39  sim   g10 I200                   Angina
#> 2   fem    31  sim   g13 E118        Diabetes mellitus
#> 3  masc    59  sim   g08 J449               Pulmonares
#> 4  masc    59  sim   g06 J159   Pneumonias bacterianas
#> 5  masc    57  sim   g11 I509          Insuf. cardíaca
#> 6  masc    67  sim   g10 I200                   Angina
#> 7  masc    71  sim   g06 J158   Pneumonias bacterianas
#> 8   fem    76  sim   g08 J449               Pulmonares
#> 9  masc     3  sim   g16 L031 Infec. pele e subcutâneo
#> 10 masc    43  sim   g13 E109        Diabetes mellitus
#> 11 masc    74  sim   g12 I638        Cerebrovasculares
#> 12  fem    46  sim   g13 E101        Diabetes mellitus
#> 13  fem    27  sim   g19 O230        Pré-natal e parto
#> 14 masc    53  sim   g12 I674        Cerebrovasculares
#> 15  fem    19  sim   g19 O233        Pré-natal e parto
#> 16 masc    28  sim   g06 J159   Pneumonias bacterianas
#> 17 masc    60  sim   g08 J449               Pulmonares
#> 18  fem     1  sim   g02  A09          Gastroenterites
#> 19 masc    65  sim   g13 E148        Diabetes mellitus
#> 20  fem    42  sim   g15 N390          Infec. urinária

left_join(
  csapAIH(aih500, lista = "Alfradique"),
  nomesgruposCSAP(classe = 2, lista = "Alfradique", lang = "en", numgrupo = TRUE)) %>%
  group_by(csap, grupo, nomegrupo) %>%
  reframe(n()) %>%
  print(n = 21)
#> Importados 500 registros.
#> Excluídos 62 (12,4%) registros de procedimentos obstétricos.
#> Excluídos 3 (0,6%) registros de AIH de longa permanência.
#> Exportados 435 (87%) registros.
#> Joining with `by = join_by(grupo)`
#> # A tibble: 16 × 4
#>    csap  grupo    nomegrupo                          `n()`
#>    <chr> <chr>    <chr>                              <int>
#>  1 não   nao-CSAP  NA                                  339
#>  2 sim   g03      " 3. Gastroenteritis"                  6
#>  3 sim   g05      " 5. Nutritional deficiency"           3
#>  4 sim   g07      " 7. Bacterial pneumonia"              7
#>  5 sim   g09      " 9. Pulmonary"                        9
#>  6 sim   g10      "10. Hypertension"                     2
#>  7 sim   g11      "11. Angina"                          11
#>  8 sim   g12      "12. Heart failure"                   13
#>  9 sim   g13      "13. Cerebrovascular"                 11
#> 10 sim   g14      "14. Diabetes mellitus"                8
#> 11 sim   g15      "15. Convulsions and epilepsy"         5
#> 12 sim   g16      "16. Urinary infection"               12
#> 13 sim   g17      "17. Skin and subcutaneous infec."     1
#> 14 sim   g18      "18. Pelvic inflammatory disease"      1
#> 15 sim   g19      "19. Gastrointestinal ulcers"          1
#> 16 sim   g20      "20. Pre-natal and childbirth"         6
```
