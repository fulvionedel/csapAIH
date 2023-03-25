#' @title Grafico das Condicoes Sensiveis a Atencao Primaria
#' @description Desenha um gráfico de barras das CSAP por grupo de causa segundo a Lista Brasileira de Internações por Condições Sensíveis à Atenção Primária. Permite a lista oficial publicada em Portaria Ministerial, com 19 grupos de causa, ou a lista com 20 grupos, publicada por Alfradique et al.
#' @aliases desenhaCSAP
#'
#' @param dados O objeto com as informações a serem desenhadas. Pode ser: (ver \code{\link{descreveCSAP}}, \code{\link{tabCSAP}})
#' \itemize{
#'   \item Um \code{data.frame} gerado pela função \code{\link{csapAIH}}, ou qualquer \code{data.frame} com uma variável chamada \code{grupo} com os grupos de causa da Lista Brasileira de CSAP, rotulados na mesma forma que os resultantes da função \code{\link{csapAIH}}, isto é, "g01", "g02", ..., "g19".
#'   \item Um objeto da classe \code{factor}) ou \code{character} com os grupos de causa CSAP, em ordem crescente de 1 a 19, conforme os grupos da Portaria do MS.
#'   nomeados de acordo com o resultado da função \code{\link{csapAIH}}. Esse vetor não precisa ser gerado pela função \code{\link{csapAIH}}, mas os grupos também devem ser rotulados da mesma forma que na função, isto é, "g01", "g02", ..., "g19".
#'   }
#' @param lista Lista de causas a ser considerada (v. detalhes); pode ser \code{"MS"} (padrão) para a lista publicada em portaria pelo Ministério da Saúde do Brasil ou "Alfradique" para a lista publicada no artigo de Alfradique et al.
#' @param lang idioma em que se apresentam os nomes dos grupos; pode ser: "pt.ca" (default) para nomes em português com acentos; "pt.sa" para nomes em português sem acentos; "en" para nomes em inglês; ou "es" para nomes em castelhano.
#' @param jaetabela Argumento lógico, cujo padrão é FALSE. TRUE indica que os dados são uma tabela pronta, que deve apenas ser graficada. A tabela pode ser um objeto de qualquer classe representando uma tabela com pelo menos duas colunas, sendo a primeira com uma identificação (não necessariamente o nome) do grupo CSAP conforme a Lista Brasileira e a segunda com o número de casos observado em cada grupo.
#' @param tipo.graf "ggplot" (padrão) cria um gráfico com \code{\link[ggplot2]{ggplot2}}; quando definido como "base", ou quando \code{\link[ggplot2]{ggplot2}} não está instalado, desenha um gráfico com as funções básicas.
#' @param valores Argumento utilizado nos gráficos com \code{\link[ggplot2]{ggplot2}}; "porcento" (padrão) desenha as barras em porcentagem, "contagem" as desenha em frequência absoluta. Veja em 'detalhes'.
#' @param ordenar Argumento lógico. Se \code{TRUE} (padrão), as barras do gráfico serão ordenadas de maior a menor frequência de casos.
#' @param colorir Argumento lógico ou para colorir as barras segundo demanda.
#'  \itemize{
#'   \item \code{TRUE} (padrão), colore as barras com a paleta \code{\link{rainbow}};
#'   \item \code{FALSE}, mantém como \code{NULL} os argumentos para a cor das barras nas funções de origem do gráfico, isto é \code{\link[graphics]{barplot}(..., col = NULL, ...)} e \cr \code{\link[ggplot2]{geom_bar}(fill = NULL)}, colorindo as barras de \code{barplot} em cinza e de \code{ggplot} em preto;
#'   \item \code{"cinza"} colore as barras em quatro tons de cinza de escuro a claro: os cinco grupos mais frequentes, os cinco seguintes, ..., os quatro últimos
#'   \item Aceita um vetor (de comprimento igual ao nº de grupos de causa CSAP (o nº de \code{levels} na variável \code{grupos})) com os nomes ou códigos de cores.
#'   }
#' @param porcentagens Argumento lógico, válido apenas para gráficos com ggplot. Se \code{TRUE} (padrão), as barras terão escritas sobre elas a porcentagem do grupo de causa sobre o total de internações (ou o total de internações no estrato, em gráficos com \code{\link[ggplot2]{facet_grid}} ou \code{\link[ggplot2]{facet_wrap}}).
#' @param val.dig Nº de decimais nos valores das barras; padrão é 0.
#' @param titulo Título do gráfico; se NULL (default), não é gerado um título; se \code{"auto"}, o argumento \code{onde} passa a ser obrigatório e a função gera um título para o gráfico a partir da informação de \code{onde} e do arquivo de dados ou do informado para o argumento \code{quando}. Se o argumento \code{dados} for um \code{factor} ou \code{character}, o argumento \code{quando} é obrigatório.
#' @param onde Local, população de origem dos dados do gráfico; obrigatório se \code{titulo = "auto"}.
#' @param quando Período de referência dos dados; se a fonte de dados for um "arquivo da AIH" (RD??????.dbc), é automaticamente extraído do arquivo.
#' @param t.hjust Valor para definição de ajuste horizontal do título, válido apenas para gráficos com ggplot. Default é 1.
#' @param t.size Valor para definição do tamanho de letra do título, válido apenas para gráficos com ggplot. Default é 12.
#' @param x.size Tamanho da letra do eixo x, válido apenas para gráficos com ggplot. Default é 10.
#' @param val.size Tamanho da letra dos valores das barras. Padrão é 2.5.
#' @param y.size Tamanho da letra do eixo y, válido apenas para gráficos com ggplot. Default é 12.
#' @param limsup Valor para ajuste do espaçamento do eixo de frequências, válido apenas para gráficos com ggplot. Quando o eixo representa porcentagens, deve ser expresso em proporção.
#' @param ... Permite o uso de argumentos de \code{\link{plot}} e \code{\link{barplot}}
#'
#' @return Na opção padrão e com \code{\link[ggplot2]{ggplot2}} instalado, devolve um objeto das classes "gg" e "ggplot", com o gráfico.
#'
#' @details
#' O gráfico é desenhado com \code{\link[ggplot2]{ggplot2}}. Portanto, segue essa filosofia e permite a adição de outros comandos ao objeto devolvido. O vetor \code{grupos} não precisa ser gerado com a função \code{\link{csapAIH}}, mas deve usar os mesmos caracteres de identificação dos grupos CSAP que o resultado da função, v.g. "g01", "g02", ..., "g19".
#'
#' @seealso \code{\link{csapAIH}}, \code{\link{descreveCSAP}}, \code{\link{tabCSAP}}, \code{\link[ggplot2]{ggplot}}, \code{\link{nomesgruposCSAP}}

#' @examples
#' library(csapAIH)
#' # Usa o banco de dados de exemplo no pacote: 'aih100'
#' df   <- csapAIH(aih100) # Computar as CSAP, lista MS
#'
#' #  Graficos com ggplot
#' # =====================
#'
#' # Cria o grafico a partir do banco,
#' # uma vez que a variavel com os grupos se chama "grupo":
#' # ----------------------------------------------------------
#' # Com titulo "automatico":
#' desenhaCSAP(df, titulo = "auto", onde = "Rio Grande do Sul")
#'
#' # Sem titulo e sem ordenacacao por frequencia:
#' desenhaCSAP(df, ordenar = FALSE)
#' #
#' # Com a lista de Alfradique et al.:
#' desenhaCSAP(csapAIH(aih100, "Alfradique"),
#'             lista = "Alfradique",
#'             titulo = "auto",
#'             onde = "Rio Grande do Sul")
#' desenhaCSAP(csapAIH(aih100, "Alfradique"), lista = "Alfradique", lang = "es")
#'
#' # Cores
#' #-------
#' # Sem cores nas barras
#' desenhaCSAP(df, colorir = FALSE)
#'
#' # Com as barras em tons de cinza
#' desenhaCSAP(df, colorir = "cinza")
#'
#' # Com as barras em outra cor
#' desenhaCSAP(df, colorir = "yellow")
#' #
#' # Usando o banco todo pode-se tirar proveito de facilidades do ggplot2,
#' # como a reproducao do grafico por estratos de outras variaveis, como no
#' # exemplo abaixo com o sexo. Para isso temos de descolorir o grafico, que
#' # pode ser novamente colorido mais tarde. Como a ordenacao dos grupos de
#' # causa continua sendo feita pela frequencia da distribuicao global, aqui
#' # ela faz menos sentido.
#'   desenhaCSAP(df, ordenar = FALSE) +
#'     ggplot2::facet_wrap(~sexo)
#'
#' # Cria o grafico a partir de uma variavel:
#' # ---------------------------------------
#' fator <- df$grupo
#' desenhaCSAP(fator)
#' carater <- as.character(fator)
#' desenhaCSAP(carater, limsup = 4.4)
#'
#' # Se \code{titulo = "auto"}, o argumento \code{quando} eh obrigatorio:
#' \dontrun{
#'  desenhaCSAP(carater, titulo = "auto", onde = 'RS') # resulta em erro
#'  }
#'  desenhaCSAP(carater, titulo = "auto", onde = "RS", quando = "jan/2012")
#'  desenhaCSAP(carater, titulo = "Título manual")
#'
#' # Cria o grafico a partir de uma tabela com a primeira coluna contendo
#' # os 19 grupos de causa e a segunda coluna contendo o numero de casos:
#' # --------------------------------------------------------------------
#' tabela <- descreveCSAP(df)
#' desenhaCSAP(tabela, jaetabela = TRUE)
#' \dontrun{
#' # Resulta em erro, faltou o argumento 'quando'
#' desenhaCSAP(tabela, jaetabela = TRUE, titulo = "auto", onde = 'RS')
#' }
#' desenhaCSAP(tabela, jaetabela = TRUE,
#'             titulo = "auto", onde = "RS", quando = "jan/2012")
#' desenhaCSAP(tabela, jaetabela = TRUE, titulo = "Título manual")
#'
#' #  Graficos com as funcoes basicas
#' # =================================
#' desenhaCSAP(df, tipo.graf = "base")
#' desenhaCSAP(df$grupo, tipo.graf = "base")
#' desenhaCSAP(tabela, jaetabela = TRUE, tipo.graf = "base")
#'
#' @importFrom grDevices rainbow
#' @importFrom graphics barplot par
#' @importFrom stats reorder
#' @importFrom utils installed.packages
#' @export
#'
desenhaCSAP <- function(dados, lista = "MS", lang = "pt.ca", jaetabela = FALSE, tipo.graf = "ggplot", valores = "porcento", ordenar = TRUE, colorir = TRUE, porcentagens = TRUE, val.dig = 0, titulo = NULL, onde, quando = NULL, t.hjust = 1, t.size = 12, x.size = 10, y.size = 11, val.size = 2.5, limsup = NULL, ...){

  if(lista == "MS") ngrupos = 19 else
    if(lista == "Alfradique") ngrupos = 20
  # Uma função -------------------
  #
  # Criar uma função pra arrumar os grupos de causa se
  # a variável não tiver todos os grupos da lista.
  #
    arrumaniveis <- function(x) {
      if (length(levels(x)) < 19) {
        niveis <- c(paste0("g0", 1:9), paste0("g", 10:ngrupos))
        x <- factor(x, levels = niveis)
        x
      } else
        x
    }
  # --------------- termina função

  # Arrumar esses casos
  if (is.character(dados)) {
    dados <- arrumaniveis(dados)
    } else if (is.data.frame(dados)) {
      if (is.character(dados$grupo)) {
        dados$grupo <- arrumaniveis(dados$grupo)
      }
    }
  #
  # A tabela
  # (cada vez mais acho que tenho de voltar ao table/tabulate,
  #  em vez de invocar a descreveCSAP -- ou tabCSAP, agora :D:D:D)!
  #
  if(jaetabela == TRUE) {
    tabela <- dados[1:ngrupos, 1:2]
  } else {
      tabela <- tabCSAP(dados$grupo)[1:ngrupos, 1:2]
  }
    tabela[,2] <- as.numeric(gsub("\\.", "", tabela[,2]))
    tabela <- droplevels(tabela[tabela$Casos > 0, ]) # para excluir grupos com frequência zero

  # - Título do gráfico ---------------------
  #
  if(!is.null(titulo)){
    if(titulo == "auto"){
      titulo1 <- "Hospitaliza\U00E7\U00E3o por Condi\U00E7\u00F5es Sens\U00EDveis \U00E0 Aten\U00E7\U00E3o Prim\U00E1ria."
      if(is.null(quando)){
        if("data.inter" %in% names(dados) == FALSE) {
          stop("O argumento 'quando' \U00E9 obrigat\U00F3rio quando 'titulo' = 'auto' e o banco de dados n\U00E3o \U00E9 resultado da aplica\U00E7\U00E3o da fun\U00E7\U00E3o csapAIH sobre um arquivo da AIH. ")
        }
        quando <- format(sort(dados$data.inter, decreasing = TRUE)[1], "%B de %Y")
      }
      if(is.null(onde)) {
        stop("O argumento 'onde' \U00E9 obrigat\U00F3rio quando 'titulo' = 'auto'. ")
      }
      titulo2 <- paste0(onde, ", ", quando, ".")
      titulo <- paste(titulo1, "\n", titulo2)
    }
  }

  # Cores das barras --------------------------
  #
  if (colorir == TRUE) {
    cores = 1:ngrupos
  } else if (colorir == FALSE) {
    cores <- NULL
  } else if (colorir == "cinza") { # criar uma paleta de cores para impressão em tons de cinza:
    cores <- paste0("gray", c(rep(80, 4), rep(65, 5), rep(50, 5), rep(25, 5)))
    cores <- cores[1:ngrupos]
  } else {
    cores <- colorir
  }

  # Gráfico com funções básicas ------------------------------
  #
  if(tipo.graf == 'base' | "ggplot2" %in% rownames(installed.packages()) == FALSE) {
    # --- modo anterior ---
    # x = tabulate(dados$grupo)[1:ngrupos]
    # names(x) = csapAIH::groupnamesCSAP()
    # names(x) <- Grupo
    #
    if(ordenar == TRUE) {
      tabela <- tabela[order(tabela$Casos),]
    }
    if (colorir == TRUE) { # As cores das barras
      cores = 1:ngrupos
    } else if (colorir == FALSE) {
      cores <- NULL
    } else if (colorir == "cinza") {
      # criar uma paleta de cores para impressão em tons de cinza:
      cores <- paste0("gray", c(rep(80, 4), rep(65, 5), rep(50, 5), rep(25, 5)))
    } else {
      cores <- colorir
    }

    par(mar = c(5,15,4,2)) # As margens do gráfico
    barplot(tabela$Casos, horiz = T, las = 1, col = cores, main = titulo, names.arg = tabela$Grupo, ...)
  } #else {

  if(tipo.graf == "ggplot") {
    #
    # - Gráfico com ggplot -----------
    #
    Grupo <- Casos <- grupo <- yrotulo <- prop <- x <- NULL

    #
    # ----- Com uma tabela ------------------------------------------------
    # Comandos exclusivos para desenhar a partir de variáveis isoladas
    # ou tabelas prontas.
    #
    if (jaetabela == TRUE | !is.data.frame(dados)) {
      # --- modo anterior ---
      # df <- data.frame( "Grupo" = csapAIH::nomesgruposCSAP(),
      #                   "Casos" = tabulate(dados$grupo)[1:ngrupos] )
      # df <- data.frame(Grupo, Casos)
      #
     if(ordenar == TRUE) {
        grafico <- ggplot2::ggplot(tabela,
                                   ggplot2::aes(x = stats::reorder(Grupo, Casos),
                                                y = Casos,
                                                fill = rainbow(ngrupos) ))
        } else {
          grafico <- ggplot2::ggplot(tabela,
                                     ggplot2::aes(x = Grupo,
                                                  y = Casos,
                                                  fill = rainbow(ngrupos) ))
          }
      grafico <- grafico +
        ggplot2::geom_bar(stat = 'identity') +
        ggplot2::geom_text(ggplot2::aes(label=paste0(round(Casos/sum(Casos)*100,1), '%')),
                           hjust=-.12, color="black", size=2.5)
      } else {
    # ----- Com o banco --------------------------------------------
    # Comandos exclusivos para o gráfico usando todo o banco de dados
        # O banco de dados
        df <- droplevels(dados[dados$grupo != 'n\U00E3o-CSAP',])
        # df$grupo <- arrumaniveis(df$grupo) # tem de aplicar novamente, pelo droplevels acima
        levels(df$grupo) <- nomesgruposCSAP(lista = lista, lang = lang)[as.numeric(substr(levels(df$grupo), 2,3))] # Passa os nomes dos grupos
        # df$grupo <- droplevels(df$grupo) # exclui grupos com frequência zero
        ngrupos <- nlevels(df$grupo)
        #
        #
        # Desenhar o gráfico
        # -----------------------------------------------{kj}
        # if(ordenar == TRUE) { # Ordem decrescente de frequência
          protografico <-
            ggplot2::ggplot(df,
                            ggplot2::aes(x = reorder(grupo, grupo, function(x) length(x)), group=1))
        # } else
        if (ordenar == FALSE) {
          protografico <-
            ggplot2::ggplot(df, ggplot2::aes(x = grupo, group = 1))
        }
        #
        if(valores == "porcento") {
          yrotulo <- "% entre as CSAP"
          protografico <- protografico +
            ggplot2::stat_count(ggplot2::aes(y = ggplot2::after_stat(prop))) +
            # ggplot2::stat_count(ggplot2::aes(y = ggplot2::after_stat(prop), fill = factor(ggplot2::after_stat(x)))) +
            ggplot2::scale_y_continuous(labels = function (x) paste(floor(x*100),"%"))
            # ggplot2::scale_y_continuous(labels = scales::percent)
        } else if (valores == "contagem") {
          yrotulo <- "n\u00BA de casos"
          protografico <- protografico +
            ggplot2::stat_count(ggplot2::aes(y = ggplot2::after_stat(count)))
          # ggplot2::stat_count(ggplot2::aes(y = ggplot2::after_stat(count), fill = factor(ggplot2::after_stat(x))))
        }
        #
        # protografico <- protografico +
          # ggplot2::theme(legend.position="none")
 #
 # Colorir as barras
        # if (colorir == TRUE) { # As cores das barras
          grafico <- protografico + ggplot2::aes(fill = factor(ggplot2::after_stat(x)))
        # } #else
        if (colorir == FALSE) {
          grafico <- protografico +
            ggplot2::aes(fill = "white", col = "black") +
            ggplot2::scale_fill_identity(aesthetics = c("fill", "colour"))
        } else if (colorir == "cinza") {
          grafico <- grafico +
            ggplot2::scale_fill_manual(values = cores, aesthetics = "fill")
        } else if (colorir != "cinza" & colorir != TRUE &  colorir != FALSE) {
            grafico <- protografico +
              ggplot2::aes(fill = cores, col = "black") +
              ggplot2::scale_fill_identity(aesthetics = c("fill", "colour"))
            #     ggplot2::geom_bar(fill = colorir)
        }
        grafico <- grafico +
          ggplot2::theme(legend.position="none")
        #
        # Colocar os valores
        if (porcentagens == TRUE) { # As porcentagens
          if (valores == "contagem"){
            grafico <- grafico +
              ggplot2::geom_text(ggplot2::aes(
                label = scales::label_percent(ggplot2::after_stat(prop)), y = ggplot2::after_stat(count)), stat= "count",
                hjust=-.12, color="black", size = val.size)
          } else if (valores == "porcento") {
            a <- c(1, .1, .01)     # Define os decimais dos valores
            val.dig <- 1 + val.dig # no gráfico
            grafico <- grafico +
              ggplot2::geom_text(ggplot2::aes(
                label = scales::percent(ggplot2::after_stat(prop), accuracy = a[[val.dig]], decimal.mark = ","), y = ggplot2::after_stat(prop)), stat= "count",
                hjust=-.12, color="black", size =  val.size)
          }
        }
      }
    #
    # Acabamentos -----------------------------------------------
    #
    grafico <- grafico +
      ggplot2::coord_flip() +
      ggplot2::xlab("Grupo de causas") +
      ggplot2::ylab(yrotulo) +
      ggplot2::ggtitle(titulo) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position="none") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = t.hjust, size = t.size)) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 60, hjust = 1, size = x.size),
                     axis.text.y = ggplot2::element_text(size = y.size))

    if( !is.null(limsup) ) {
      if(valores == "porcento") {
        grafico <-
          # suppressMessages(print(
            grafico +
              ggplot2::scale_y_continuous(labels = function (x) paste(floor(x*100),"%"),
                                          limits = c(0, limsup))
            # ))
      } else
        grafico <-
          # suppressMessages(print(
            grafico +
              ggplot2::ylim(0, limsup)
            # ) )
    }

    aih100 <- NULL # pra evitar a nota "no visible binding" ao rodar o exemplo
    # return(grafico)

    # if (colorir == "cinza") {
      # grafico <- suppressMessages(grafico + ggplot2::scale_fill_manual(values = cores))
    # }

    grafico
  }
}
