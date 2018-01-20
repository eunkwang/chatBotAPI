source("/home/eunkwang/R/chatBotAPI/naverRelation.R")
source("/home/eunkwang/R/chatBotAPI/saveResult.R")

pacman::p_load('reshape2', 'igraph', 'rdevteam', 'ggraph',
               'tidytext', 'tidyr', 'dplyr', 'data.table',
               'rdevteam', 'slackr')

nvrGraph <- function(input = '사과'){
  if(is.character(input) == TRUE){
    ## loading data
    d1 <- naverRelation1(input)
    df <- naverRelation2(input)
    
    ## preprocessed data
    d2 <- data.frame(R1 = input, R2 = d1)
    df_union <- rbind(d2, df)
    
    ## save Data to DB
    saveHistory(df_union)
    
    ## network object
    
    df_g <- graph.data.frame(df_union)
    
    V(df_g)$label.cex <- ifelse(V(df_g)$name == input, 2,
                                ifelse(V(df_g)$name %in% d1, 1, 0.7))
    
    colbar <- rainbow(length(d1)+1)
    V(df_g)$label.color <- ifelse(input == V(df_g)$name, "red",
                                  ifelse(V(df_g)$name %in% d1, colbar, "gray50"))
    
    V(df_g)$label.font <- ifelse(input == V(df_g)$name, 2,
                                 ifelse(V(df_g)$name %in% d1, 2, 1))
    
    ## Source: http://stackoverflow.com/a/28722680/496488
    layout.by.attr <- function(graph, wc, cluster.strength=1,layout=layout.auto) {
      g <- graph.edgelist(get.edgelist(graph)) # create a lightweight copy of graph w/o the attributes.
      E(g)$weight <- 1
      
      attr <- cbind(id=1:vcount(g), val=wc)
      g <- g +  igraph::edges(unlist(t(attr)), weight=cluster.strength)
      
      l <- layout(g, weights=E(g)$weight)[1:vcount(graph),]
      return(l)
    }
    
    ## network plotting
    
    text_slackr(paste0(input,'에 대한 연관검색결과입니다.'), channel = '#99_결과물_테스트')
    
    plot(df_g,
         layout = layout.by.attr(df_g, wc = 1, cluster.strength = 1),
         vertex.shape = "none",
         edge.arrow.size=0.3,
         edge.width=1.5,
         edge.color="gray80",
         main = paste0(input, "의 연관검색네트워크")
    )
    dev.slackr("#99_결과물_테스트")
    dev.off()
    
    ## save png file
    filename = paste0("image/", format(Sys.Date(), "%Y%m%d"), "_", input,".png")
    png(filename)
    plot(df_g,
         layout = layout.by.attr(df_g, wc = 1, cluster.strength = 1),
         vertex.shape = "none",
         edge.arrow.size=0.3,
         edge.width=1.5,
         edge.color="gray80",
         main = paste0(input, "의 연관검색네트워크")
    )
    dev.off()
    
  } else {
    print("input is not character type")
  }
  
}

nvrGraph("원피스")
