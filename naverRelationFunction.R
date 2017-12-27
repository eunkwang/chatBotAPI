# install.packages('rvest')
# install.packages('stringr')
# install.packages('lava')

library(rvest)
library(stringr)
library(lava)

url <- "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=사과"
html.naver <- read_html(url)

# html.naver 에서 css가 'lst_relate'(연관검색어)를 찾기. 
apple_1 <- html_nodes(html.naver, css='.lst_relate') 

# 가장 첫번째 apple_1로부터 연관검색어 글자를 추출,
apple_1 %>% html_text()

# lava 패키지의 trim 사용해서 앞뒤 공백 제거
trim(apple_1 %>% html_text())

# 글자를 분리
str_split(trim(apple_1 %>% html_text()),'   ')

# 글자 분리 함수 생성
splitf <- function(x){
  return(str_split(trim(x %>% html_text()),'   '))
}

# 함수 작동 확인
apple <- c(splitf(apple_1))[[1]]

dsa <- c(apple)[[1]]



naverRelation1 <- function(x){
  
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
  splitf(html)
  
}

naverRelation1('사과')


### 2차 연관 검색어까지 추적 & 저장하는 함수 

naverRelation2 <- function(x){
  
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
  for(i in 1:length(t)){ ifelse(length(naverRelation1(t[i]))==0,html2[[i]] <- '2차연관검색어없음',html2[[i]] <- naverRelation1(t[i])) }
  names(html2)<-t
  print(html2)
}


# 다른건 잘 되는데, 2차 연관검색어가 0개이면 에러가 난다. 해결요망 -> 해결

soogun <- naverRelation2('수건')

# 검색 단어에 띄어쓰기가 인식이 안되는 문제 해결

naverRelation2('오리')
naverRelation2('오리 고기')