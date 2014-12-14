library(shiny)
library(tm)
library('stringr')

library(shiny)
shinyServer(
  function(input, output){
    output <- renderText({  functionnlp(input) })
  }
)



output <- functionnlp(input){
  crps <-  tm_map(input, tolower)
  crps <- tm_map(input, removeNumbers)
  crps <- tm_map(input, removeWords, stopwords("english"))
  crps <- tm_map(input, removePunctuation)
  crps <- tm_map(input, stripWhitespace) # remove double whitespaces
  crps <- tm_map(input, PlainTextDocument)
  
  solved=F
  df.tg   <- read.delim("dftg.txt", header = T, sep="\t")
  df.tt   <- read.delim("dftt.txt", header = T, sep="\t")
  
  input="let us"
  
  length = length(unlist(strsplit(input," ")))
  
  if length >= 2 {
    sentence = paste(tail(strsplit(input,split=" ")[[1]],2), collapse = ' ')
    sentence = paste(sentence, "")
    allines = subset(df.tt, grepl(sentence,df.tt$trigram) == 'TRUE')
    if (nrow(allines)>0) {
      output = head(allines[order(allines$freq, decreasing=TRUE),], 1)$trigram
      cat("Three grams match found")
      solved=T }
  }
  
  if (length < 2 && solved=F) {
    sentence = paste(tail(strsplit(input,split=" ")[[1]],1), collapse = ' ')
    sentence = paste(sentence, "")
    allines = subset(df.tg, grepl(sentence,df.tg$bigram) == 'TRUE')
    if (nrow(allines)>0) {
      output = head(allines[order(allines$freq, decreasing=TRUE),], 1)$bigram
      cat("Two grams match found")
      solved=T }   
  }
  
  if solved=F {cat("No match found")}
  return(output)
  
}