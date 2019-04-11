library(dplyr)
library(tidyr)
library(stringr)

cleantext = function(text){
  text = text %>%
    gsub("\\(","",.) %>%
    gsub("\\)","",.) %>%
    gsub("\\\"","",.) %>%
    gsub("\\'","",.) %>%
    gsub("\\$","",.) %>%
    gsub("\\... ..."," ",.) %>%
    tolower(.) %>%
    gsub("[[:punct:]]"," NULL ",.)
  
  return(text)
}