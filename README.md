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

O pacote `csapAIH` contém apenas uma função, homônima: `csapAIH`

### Exemplos de uso

  - A partir de um arquivo "RD??????.DBF" salvo no mesmo diretório da sessão de trabalho do **R**:
  
        csap = csapAIH::csapAIH("RD??????.DBF")
  
  - A paritr de um banco de dados com a estrutura da AIH já carregado no ambiente de trabalho:
  
        csap = csapAIH::csapAIH(bancodedados)
  
  - A partir de uma variável com códigos da CID-10:
  
        csap = csapAIH::csapAIH(variavel)
  

***Veja o manual do pacote para mais detalhes:*** https://github.com/fulvionedel/csapAIH/blob/master/csapAIH-manual.pdf
