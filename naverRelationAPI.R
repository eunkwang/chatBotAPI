library(rvest)
library(stringr)
library(lava)
library(slackr)


#' @get /naverRelation1
naverRelation1 <- function(text, token){
  x <- trimws(text)
  if(token == "4ucDgi06CsNKPHa48inqMeiU"){
    # Pre
    stopifnot(is.character(x))
    stopifnot(require(rvest)); stopifnot(require(stringr)); stopifnot(require(lava))
    
    # Content
    x <- gsub(" ","+",x)
    html <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=', x) %>%
      read_html %>%
      html_nodes(css='.lst_relate') 
    
    splitf <- function(y){
      return(str_split(trim(y %>% html_text()),'   '))
    }
    
    # Return
    result <- splitf(html)
  } else {
    result <- "Service not available"
  } 
  # shell(cmd = 'Rscript.exe .R', wait=FALSE)
  return(result)
}

#' @get /naverRelation2
naverRelation2 <- function(text, token){
  token1 <- "4ucDgi06CsNKPHa48inqMeiU"
  x <- trimws(text)
  if(token == "QLbjM3KQmP8k2kNhMeDbKmhh"){
    # Pre
    stopifnot(is.character(x))
    stopifnot(require(rvest)); stopifnot(require(stringr)); stopifnot(require(lava))
    
    # Content
    x <- gsub(" ","+",x)
    html <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=', x) %>%
      read_html %>%
      html_nodes(css='.lst_relate') 
    
    splitf <- function(y){
      return(str_split(trim(y %>% html_text()),'   '))
    }
    
    # Return
    t <- c(splitf(html))[[1]]
    html2 <- data.frame(1)
    for(i in 1:length(t)){ ifelse(length(naverRelation1(t[i], token1))==0,html2[[i]] <- '2차연관검색어없음',html2[[i]] <- naverRelation1(t[i], token1)) }
    names(html2)<-t
    print(html2)
    result <- html2
  } else {
    result <- "Service not available"
  }
  return(result)
}
