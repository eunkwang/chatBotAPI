library(plumber)
plumberObject <- plumb("/home/eunkwang/R/chatBotAPI/stockfunction.R")
plumberObject$run(port=8000)
