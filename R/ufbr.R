#' @title Lista as Unidades da Federação por Região do Brasil
#' @aliases ufbr
#' 
#' @description Lista as siglas e nomes das Unidades Federativas (UF) por Região do Brasil segundo seu código no IBGE, permitindo a decodificação do código do IBGE para a sigla ou nome da Unidade da Federação.
#' 
#' @param nomes Se \code{nomes = TRUE}, é incluída uma coluna com os nomes dos Estados. Se \code{nomes = FALSE} (padrão), a UF é identificada apenas pela sigla.
#' 
#' @returns Um objeto da classe \code{data.frame}
#' 
#' @export
#' @examples 
#' ufbr()
#' ufbr(nomes = TRUE)
#' 

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
                        "Para\U00edba", "Pernambuco", "Alagoas", "Sergipe", "Bahia",
                        "Minas Gerais", "Esp\U00edrito Santo", "Rio de Janeiro", "S\U00e3o Paulo",
                        "Paran\U00e1", "Santa Catarina", "Rio Grande do Sul",
                        "Mato Grosso do Sul", "Mato Grosso", "Goi\U00e1s", "Distrito Federal")
    tabela <- tabela[c(1:2, 4, 3)]
  }
  tabela
}
