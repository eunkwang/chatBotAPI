# 테스트 함수를 생성

newGetQuote <- function(thesymbol){
  myresults <- quantmod::getQuote(thesymbol)
  if(is.na(myresults[1,1])){
    mytext <- past0("A price is not available for ", thesymbol)
  } else {
    mytext <- paste0("Price for ", thesymbol, " is $", myresults[1,2], " as of ", myresults[1,1])
  }
  
  return(mytext)
}

# 테스트 함수를 API 서빙이 가능하도록 wrapping
# stockfunction.r 파일로 저장

# API 서빙용 라이브러리 로드

library(plumber)
plumberObject <- plumb("/home/eunkwang/R/chatBotAPI/stockfunction.R")
plumberObject$run(port=12345)

# 런타임으로 실행되면 curl 명령어를 통해 실행
# curl "http://localhost:12345/mean"

# plumber 합수를 랩핑할 때 #* 를 #'로 해야 오류가 나지 않음
