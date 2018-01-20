# 본 코드는 Incoming WebHooks 기능에 대한 테스트 코드 입니다.
# nvrgraph

# curl -X POST -H 'Content-type: application/json'
#     --data '{
#               "text":"Hello, World!"
#             }
# ' https://hooks.slack.com/services/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


# 데이터 구조는 메시지를 Json 객체에 담아서 POST 로 서빙하는 것임
# 필요한 라이브러리
# 참고자료
## https://cran.r-project.org/web/packages/curl/vignettes/intro.html


library(httr)
library(jsonlite)
library(curl)

# data.frame 을 Json으로 변환하기
irisJson <- toJSON(iris[1:10,])

# curl 로 JSON 서빙하기
system(
  'curl -X POST -H "Content-type: application/json" --data "{"text":"Hello, World!"}" https://hooks.slack.com/services/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'
)
