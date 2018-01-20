saveHistory <- function(df){
  library(RSQLite)

  # DB 접속
  con <- dbConnect(SQLite(), "nvrHistory.sqlite")

  now <- Sys.time()
  time <- as.character(format(now, format = "%Y%m%d%H%M%S"))
  result <- data.frame(regDate = time, df)

  # DB에 데이터 프레임 기록하기
  # DB에 저장되는 형태는 데이터 프레임과 유사
  dbWriteTable(con, "nvrHistory", result, append = TRUE)

  # DB연결 종료
  dbDisconnect(con)
  print("저장하였습니다.")

}

loadHistory <- function(){
  library(RSQLite)
  # DB 연결
  con <- dbConnect(SQLite(), "nvrHistory.sqlite")

  # DB에서 결과 가져 오기
  result <- dbGetQuery(con, "select * from nvrHistory")

  # DB 연결 종료
  dbDisconnect(con)
  return(result)
  print("로드하였습니다.")
}
