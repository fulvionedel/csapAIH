# Procedimentos obstétricos do Sistema de Informação Hospitalar do SUS (SIH/SUS)

Identifica os registros de hospitalizações por procedimentos obstétricos
para internações por eventos não mórbidos (partos etc.) nas bases de
dados do SIH/SUS (BD-SIH/SUS) e segundo as opções do usuário, (1) cria
uma variável `procobst` com a identificação do procedimento, (2) exclui
esses registros do banco de dados ou (3) cria um novo banco de dados
somente com esses registros.

## Usage

``` r
proc.obst(
  x,
  procobst.action = "exclude",
  proc.rea = "PROC_REA",
  language = "pt"
)
```

## Arguments

- x:

  Um banco de dados com os registros da Autorização de Internação
  Hospitalar (AIH) nos "arquivos reduzidos da AIH" (RD\<UFAAMM\>.DBC),
  disponibilizados pelo Departamento de Informática do SUS, o DATASUS.

- procobst.action:

  Argumento da classe caractere, indicando a ação a ser realizada sobre
  o banco de dados: (1) `"exclude"` (default) devolve um banco de dados
  sem as hospitalizações para procedimentos obstétricos, (2) `"extract"`
  devolve um banco de dados apenas com as internações para procedimentos
  obstétricos, (3) `"identify"` acrescenta ao banco uma variável de
  classe `factor` (`procobst`) indicando se a hospitalização foi para a
  realização de um procedimento obstétrico.

- proc.rea:

  Procedimento realizado, campo (`PROC_REA`) no arquivo da AIH.

- language:

  Idioma de apresentação das mensagens e resumo das ações executadas;
  pode ser "pt" (default) para português ou "en" para inglês.

## References

Brasil. Ministério da Saúde. Secretaria de Atenção à Saúde. Departamento
de Regulação, Avaliação e Controle. Coordenação Geral de Sistemas de
Informação - 2014. SIH – Sistema de Informação Hospitalar do SUS: Manual
Técnico Operacional do Sistema. Ministério da Saúde: Brasília, 2015.
87p.

## See also

[`csapAIH`](https://fulvionedel.github.io/csapAIH/reference/csapAIH.md)
[`partos`](https://fulvionedel.github.io/csapAIH/reference/partos.md)
