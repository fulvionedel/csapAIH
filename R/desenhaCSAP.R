#' @title Gráfico das Condições Sensíveis à Atenção Primária
#' @author Fúlvio B. Nedel
#' @description Desenha um gráfico de barras das CSAP por grupo de causa
#' @aliases desenhaCSAP
#' @aliases descreveCSAP
#' @aliases csapAIH
#' 
#' @param banco Banco de dados com as informações. Objeto da classe \code{data.frame} gerado pela função \code{\link{csapAIH}}.
#' @param titulo Título do gráfico; se NULL (default), não é gerado um título; se \code{"auto"}, o argumento \code{onde} passa a ser obrigatório e a função gera um título para o gráfico a partir da informação de \code{onde} e do arquivo de dados ou do informado para o argumento \code{quando}.
#' @param onde Local, população de origem dos dados do gráfico; obrigatório se \code{titulo = "auto"}.
#' @param quando Período de referência dos dados; se a fonte de dados for um "arquivo da AIH" (RD????.dbc), pode ser extraído do arquivo.
#' @param t.hjust Valor para definição de ajuste horizontal do título. Default é 1.
#' @param t.size Valor para definição do tamanho de letra do título. Default é 12.
#' @param cte.x Valor para ajuste do espaçamento da grade do gráfico.
#' @param x.size Tamanho da letra do eixo x. Default é 10. 
#' @param y.size Tamanho da letra do eixo y. Default é 12.
#' 
#' @return Devolve um objeto das classes "gg", "ggplot", com o gráfico.
#' @details O gráfico é desenhado com \code{\link[ggplot2]{ggplot2}}. Portanto, segue essa filosofia e permite adição de outros comandos ao objeto devolvido. \code{grupos} não precisa ser gerado com a função \code{\link{csapAIH}}, mas deve usar os mesmos caracteres de identificação dos grupos CSAP que o resultado da função, v.g. "g01", "g02", ..., "g19".
#' 
#' @seealso \code{\link{csapAIH}}, \code{\link{desenhaCSAP}}, \code{\link[ggplot2]{ggplot2}}

#' @examples 
#' data(aih100)
#' df = csapAIH(aih100)
#' desenhaCSAP(df)
#' 
#' @export
#' 
desenhaCSAP <- function(banco, titulo = NULL, onde, quando = NULL, t.hjust = 1, t.size = 12, cte.x = 10, x.size = 10, y.size = 12){
  # Título:
  if(!is.null(titulo)){
    if(titulo == "auto"){
      titulo1 = "Hospitaliza\U00E7\U00E3o por Condi\U00E7\U00E7es Sens\U00EDveis \U00E0 Aten\U00E7\U00E3o Prim\U00E1ria."
      if(is.null(quando)){
        quando = format(sort(banco$data.inter, decreasing = TRUE)[1], "%B de %Y")
      }
      if(is.null(onde)) {
        stop("O argumento 'onde' \U00E9 obrigat\U00F3rio quando 'titulo' = 'auto', mas est\U00E1 ausente. ")
      }
      titulo2 = paste0(onde, ", ", quando, ".")
      titulo = paste(titulo1, titulo2)
    }
  }
  
  Grupo <- Casos <- NULL

  # O banco de dados para o gráfico
  x = data.frame(table(banco$grupo)[1:19])
  x$Grupo = nomesgruposCSAP()
  # x$Grupo = factor(nomesgruposCSAP(), levels = nomesgrupos)
  x = x[3:2]
  names(x)[2] = "Casos"

requireNamespace("ggplot2")
requireNamespace("ggthemes")
grafico = ggplot2::ggplot(x, ggplot2::aes(x=stats::reorder(Grupo, Casos), 
                        y = Casos, 
                        fill = heat.colors(19) )) + 
  ggplot2::geom_bar(stat = 'identity') +
  ggplot2::coord_flip() +
  ggplot2::xlab("Grupo de causas") +
  ggplot2::ggtitle(titulo) +
  ggplot2::theme_bw() +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = t.hjust, size = t.size)) +
  ggplot2::theme(legend.position="none") +
  ggplot2::scale_y_continuous(breaks = seq(0, max(x$Casos) + max(x$Casos)/(10*cte.x), 200*cte.x), 
                     limits = c(0,max(x$Casos) + max(x$Casos)/(10*cte.x))) +
  ggplot2::geom_text(ggplot2::aes(label=paste0(round(Casos/sum(Casos)*100,1), '%')), 
            hjust=0, color="black", size=2.5) +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 60, hjust = 1, size = x.size),
        axis.text.y = ggplot2::element_text(size = y.size))

return(grafico)
}