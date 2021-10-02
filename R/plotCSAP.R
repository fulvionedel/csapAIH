#' @title Plot Primary Health Care Sensitive Conditions, Brazilian List
#'
#' @aliases plotCSAP
#' @aliases tableCSAP
#' @aliases csapAIH
#'
#' @description Plot an horizontal bar graphic (using \code{\link[ggplot2]{ggplot2}}) for Primary Health Care Sensitive Conditions (PHCSC, CSAP), according to the Brazilian List of causes.

#' @param x Object containing the information to be plotted. May be a factor, a character vector, a table or a data frame with the 19 groups of cause CSAP from the Brazilian List.
#' @param title Character vector for graphic title. If not NULL, may be "auto", for an automatic title.
#' @param where Character vector indicating the region where people are from, to be passed to automatic title; needed only if title = "auto".
#' @param when Character vector indicating the time period of hospitalizations, to be passed to automatic title; needed only if title = "auto" AND user wants other period than the month of hospitalizations, in monthly "AIH files".
#' @param t.hjust Numeric value for horizontal adjust of the title.
#' @param t.size Numeric value for the title font size.
#' @param x.size Numeric value for the font size of x axis label.
#' @param y.size Numeric value for the font size of y axis label.
#' @param x.cte Numeric value for adjusting the space to the right of bars, and vertical grid spacement, as well to tick marks and labels for x axis; ignored for \code{breaks} and \code{limits} if these arguments are set.
#' @param breaks Numeric vector to set the breaks for the horizontal (actually y) axis; if not NULL (default) cause \code{x.cte} to be ignored for setting the breaks.
#' @param limits Numeric vector of length 2, to set the space to the right of bars; if not NULL (default) cause \code{x.cte} to be ignored for setting this space.
#' @param idioma Mode of CSAP group names; argument to be passed to \code{\link{groupnamesCSAP}}.
#' @param ... Arguments to be passed to other functions.
#'
#' @seealso \code{\link{csapAIH}}, \code{\link[ggplot2]{ggplot2}} \code{\link{groupnamesCSAP}}, \code{\link{legoAIH}} and \code{\link{tableCSAP}}
#'
#' @examples
#' data("aih500")
#' csap <- csapAIH(aih500)
#' plotCSAP(csap)
#' plotCSAP(csap, idioma = "en")
#' plotCSAP(csap$grupo)
#' plotCSAP(csap$grupo, idioma = "pt.sa")
#' plotCSAP(csap$grupo, idioma = "en")
#' plotCSAP(csap$grupo, idioma = "es")
#'
#' @export
#'
plotCSAP <- function(x, title = NULL, where, when = NULL, t.hjust = 1, t.size = 12, x.size = 10, y.size = 12, x.cte = 5, breaks = NULL, limits = NULL, idioma = "pt.ca", ...){

  # Errorum nuntius
  # ----------------
  if ( (is.factor(x) | is.character(x) | is.table(x) | is.data.frame(x)) != TRUE ) {
    stop("x must be a table, a factor, or a character vector")
  }
  if ( is.table(x) & length(x) != 19 ) {
    stop("x must have each one of the 19 groups, even with no observations, but has ", length(x), " groups.\n  Perhaps you wish x[1:19].")
  }
  if ( is.factor(x) & length(levels(x)) < 19 ) {
    stop("x must have each one of the 19 groups, even with no observations, but has ", length(levels(x)), " groups.")
  }
  if ( is.character(x) ) {
    if ( length(levels(as.factor(x))) < 19 ) {
    stop("x must have each one of the 19 groups, even with 0 observations, but has ", length(x), " groups.")
    }
  }


  # Data
  if ( is.character(x) | is.factor(x) ) {
    tabela <- table(x)[1:19]
  } else {
    if ( is.table(x) ) tabela <- x # não deveria ser x[1:19]?
    if ( is.data.frame(x) ) {
      tabela <- table(x$grupo)[1:19]
    }
  }

  # Plot
  Casos <- Grupo <- NULL
  names(tabela) <- groupnamesCSAP(idioma = idioma)
  df <- as.data.frame(sort(tabela))
  names(df) <- c("Group", "Cases")
  if( is.null(breaks) ) {
    breaks = seq(0, max(df$Casos) + max(df$Casos)/x.cte, x.cte)
  }
  if( is.null(limits) ) {
    limits = c(0,max(df$Casos) + max(df$Casos)/x.cte)
  }

  grafico <- ggplot2::ggplot(df,
                             ggplot2::aes(x = Grupo, y = Casos, fill = Grupo)) +
    ggplot2::geom_bar(stat = 'identity') +
    ggplot2::coord_flip() +
    ggplot2::xlab("") +
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position="none") +
    ggplot2::scale_y_continuous(
      breaks = breaks,
      limits = limits) +
    ggplot2::geom_text(
      ggplot2::aes(label=paste0(round(Casos/sum(Casos)*100,1), '%')),
      hjust=0, color="black", size=3.5) +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 60, hjust = 1, size = x.size),
      axis.text.y = ggplot2::element_text(size = y.size))

  # Title:
  if ( is.data.frame(x) ) {
    if(!is.null(title)){
      if(title == "auto"){
        title1 <- "Hospitaliza\U00E7\U00E3o por Condi\U00E7\u00F5es Sens\U00EDveis \u00E0 Aten\U00E7\U00E3o Prim\U00E1ria."
        if(is.null(when)){
          when <- format(sort(x$data.inter, decreasing = TRUE)[1], "%B de %Y")
        }

        title2 <- paste0(where, ", ", when, ".")
        title <- paste(title1, title2)
        grafico <- grafico +
          ggplot2::ggtitle(title) +
          ggplot2::theme(plot.title = ggplot2::element_text(hjust = t.hjust, size = t.size))
      }
    }
  }

grafico
}
