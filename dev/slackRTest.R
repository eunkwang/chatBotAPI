# slackR설치 및 로드

# install.packages("slackr")
library(slackr)





# slackR 환경 셋팅
slackr_setup(
  api_token = 'xoxb-296037351111-cEVrdoDBb7c7G0ZmZSnsWmef',
  username = 'nvrbot'
)


text_slackr('Hello', channel = '#99_결과물_테스트')

slackr(str(iris))

# 이미지 보내기 테스트
library(ggplot2)
qplot(mpg, wt, data=mtcars)
dev.slackr("#99_결과물_테스트")

barplot(VADeaths)
dev.slackr("@jayjacobs")

ggslackr(qplot(mpg, wt, data=mtcars))
