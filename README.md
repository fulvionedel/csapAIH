# csapAIH
Classificar Condições Sensíveis à Atenção Primária

### Apresentação

Pacote em **R** para a classificação de códigos da CID-10 (Classificação Internacional de Doenças, 10ª Revisão) segundo a Lista Brasileira de Condições Sensíveis à Atenção Primária (CSAP). É particularmente voltado ao trabalho com as bases de dados do Sistema de Informações Hospitalares do SUS, o Sistema Único de Saúde brasileiro. Tais bases contêm os "arquivos da AIH" (`RD??????.DBC`), que podem ser expandidos para o formato DBF (`RD??????.DBF`), com as informações de cada hospitalização ocorrida pelo SUS num período determinado. Assim, embora o pacote permita a classificação de qualquer listagem de códigos da CID-10, tem também algumas funcionalidades para facilitar o trabalho com os "arquivos da AIH".

### Justificativa

A hospitalização por CSAP é um indicador da qualidade do sistema de saúde em sua primeira instância de atenção, uma vez que a internação por tais condições ---pneumonia, infecção urinária, sarampo, diabetes etc.---  só acontecerá se houver uma falha do sistema nesse âmbito de atenção, seja por não prevenir a ocorrência da doença (caso das doenças preveníveis por vacinação, como o sarampo), não diagnosticá-la ou tratá-la a tempo (como na pneumonia ou infeccão urinária) ou por falhar no seu controle clínico (como é o caso da diabete).

O Ministério da Saúde brasileiro estabeleceu em 2008, após amplo processo de validação, uma lista com várias causas de internação hospitalar consideradas CSAP, definindo em portaria a Lista Brasileira. A Lista envolve vários códigos da CID-10 e classifica as CSAP em 19 subgrupos de causa, o que torna complexa e trabalhosa a sua decodificação. Há alguns anos o Departamento de Informática do SUS (DATASUS) incluiu em seu excelente programa de tabulação de dados TabWin a opção de tabulação por essas causas, apresentando sua frequência segundo a tabela definida pelo usuário.

Entretanto, muitas vezes a pesquisa exige a classificação de cada internação individual como uma variável na base de dados. E não conheço outro programa ou *script* (além do que tive de escrever em minha tese) que automatize esse trabalho.

### Instalação

O pacote `csapAIH` pode ser instalado no **R** através do pacote `devtools`, com os seguintes comandos:
      
    install.packages("devtools") # desnecessário se o pacote devtools já estiver instalado
    devtools::install_github("fulvionedel/csapAIH")

### Conteúdo

Na sua primeira versão, o pacote `csapAIH` contém apenas uma função, homônima: `csapAIH`. Na versão 0.0.2, foram acrescentadas as funções `descreveCSAP`, `desenhaCSAP` e `nomesgruposCSAP`, para a representação gráfica e tabular das CSAP pela lista brasileira.

### Exemplos de uso
#### Leitura dos arquivos

  - A partir de um arquivo "RD??????.DBF" salvo no mesmo diretório da sessão de trabalho do **R**:
  
        csap = csapAIH::csapAIH("RD??????.DBF")

- A partir de um arquivo "RD??????.DBC" salvo no mesmo diretório da sessão de trabalho do **R**:
  
        csap = csapAIH::csapAIH("RD??????.DBC")
  
  - A paritr de um banco de dados com a estrutura da AIH já carregado no ambiente de trabalho:
  
        csap = csapAIH::csapAIH(bancodedados)
  
  - A partir de uma variável com códigos da CID-10:
  
        csap = csapAIH::csapAIH(variavel)
 
 #### Apresentação de resultados 
       csap = csapAIH("RDSC1201.dbc")
         Importados 32.159 registros.
         Excluídos 5.123 (15,9%) registros de procedimentos obstétricos.
         Excluídos 575 (2,1%) registros de AIH de longa permanência.
         Exportados 26.461 (82.3%) registros.
       
       descreveCSAP(csap$grupo)
                                          Grupo Casos %Total %CSAP
       1                      1.Prev. vacinação    65   0,25  1,05
       2                       2.Gastroenterite   861   3,25 13,95
       3                               3.Anemia    30   0,11  0,49
       4                      4.Def. nutricion.   118   0,45  1,91
       5      5.Infec. ouvido, nariz e garganta    67   0,25  1,09
       6               6.Pneumonias bacterianas   360   1,36  5,83
       7                                 7.Asma   167   0,63  2,71
       8                    8.Pulmonares (DPOC)   699   2,64 11,33
       9                          9.Hipertensão   105   0,40  1,70
       10                             10.Angina   462   1,75  7,49
       11                    11.Insuf. cardíaca   877   3,31 14,21
       12                  12.Cerebrovasculares   671   2,54 10,88
       13                  13.Diabetes mellitus   358   1,35  5,80
       14                         14.Epilepsias   137   0,52  2,22
       15                    15.Infec. urinária   701   2,65 11,36
       16           16.Infec. pele e subcutâneo   239   0,90  3,87
       17 17.D. infl. órgãos pélvicos femininos    49   0,19  0,79
       18            18.Úlcera gastrointestinal    92   0,35  1,49
       19                  19.Pré-natal e parto   112   0,42  1,82
       20                            Total CSAP  6170  23,32   100
       21                              não-CSAP 20291  76,68    --
       22                  Total de internações 26461    100    --
 
      desenhaCSAP(csap)
      
      desenhaCSAP(csap, titulo = "auto", onde = "SC", cte.x = 1, y.size = 10)

 
***Veja o manual do pacote para mais detalhes:*** https://github.com/fulvionedel/csapAIH/blob/master/csapAIH-manual.pdf
