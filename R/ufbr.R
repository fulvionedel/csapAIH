#' @title Lista as Unidades da Federação por Região do Brasil
#' @aliases ufbr
#'
#' @description Lista as siglas e nomes das Unidades Federativas (UF) por Região do Brasil segundo seu código no IBGE, permitindo a decodificação do código do IBGE para a sigla ou nome da Unidade da Federação.
#'
#' @param nomes Se \code{nomes = TRUE}, é incluída uma coluna com os nomes dos Estados. Se \code{nomes = FALSE} (padrão), a UF é identificada apenas pela sigla.
#'
#' @returns Um objeto da classe \code{data.frame}, com a sigla da Região e o código, a sigla e, se \code{nomes = TRUE}, o nome da UF.
#'
#' @export
#' @examples
#' ufbr()
#' ufbr(nomes = TRUE)
#' # Para acrescentar as informações a um banco de dados existente, junte os
#' # bancos, como no exemplo abaixo.
#' # O banco "POPBR10" tem a população dos municípios brasileiros em 2010.
#' # O município é informado pelo código do IBGE e não há informação sobre a UF:
#' data("POPBR10")
#' str(POPBR10)
#' # O código abaixo
#' # - acrescenta a 'POPBR10' uma variável chamada "CO_UF" com o código da UF,
#' # tomado dos dois primeiros dígitos de 'MUNIC_RES';
#' # - une os bancos, com a função \code{\link{merge}}; e
#' # - seleciona os registros da Região Norte ("N")
#'
#' POPBR10$CO_UF <- substr(POPBR10$MUNIC_RES, 1, 2)
#' POPBR10  <- merge(POPBR10, ufbr())
#' POPBR10[POPBR10$REGIAO == "N", ]

ufbr <- function(nomes = FALSE){
  CO_UF <- as.character(c(11:17,     # N
                          21:29,     # NE
                          31:33, 35, # SE
                          41:43,     # S
                          50:53))    # CO
  tabela <- data.frame(
    CO_UF,
    "UF_SIGLA" = factor(c("RO", "AC", "AM", "RR", "PA", "AP", "TO",
                          "MA", "PI", "CE", "RN", "PB", "PE", "AL", "SE", "BA",
                          "MG", "ES", "RJ", "SP",
                          "PR", "SC", "RS", "MS",
                          "MT", "GO", "DF")),
    "REGIAO"   = factor(substr(CO_UF, 1, 1), labels = c("N", "NE", "SE", "S", "CO"))
  )
  if(nomes == TRUE) {
    tabela$UF_NOME <- c("Rond\U00f4nia", "Acre", "Amazonas", "Roraima", "Par\U00e1",
                        "Amap\U00e1", "Tocantins",
                        "Maranh\U00e3o", "Piau\U00ed", "Cear\U00e1", "Rio Grande do Norte",
                        "Para\u00edba", "Pernambuco", "Alagoas", "Sergipe", "Bahia",
                        "Minas Gerais", "Esp\U00edrito Santo", "Rio de Janeiro", "S\U00e3o Paulo",
                        "Paran\U00e1", "Santa Catarina", "Rio Grande do Sul",
                        "Mato Grosso do Sul", "Mato Grosso", "Goi\U00e1s", "Distrito Federal")
    tabela <- tabela[c(1:2, 4, 3)]
    levels(tabela$REGIAO) <- c("Norte", "Nordeste", "Sudeste", "Sul", "Centro-Oeste")
  }
  tabela
}
