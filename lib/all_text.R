library(ngram)
library(dplyr)
library(tidyr)
library(stringr)
setwd("C:/Users/86155/Documents/GitHub/Spring2019-Proj4-group-12")

## load("~/GitHub/Spring2019-Proj4-group-12/output/ground_truth_all_lines.RData")

#paste(str_trim(gd_lines), sep = " ", collapse = " ")
## paste all text
file_name_vec <- list.files("./data/ground_truth")
gd_all <- c()
for (i in 1:length(file_name_vec)){
  current_file_name <- sub(".txt","",file_name_vec[i])
  gd_lines <- readLines(paste("./data/ground_truth/",current_file_name,".txt",sep=""), warn=FALSE) %>%
    paste(str_trim(.), sep = " ", collapse = " ")
  gd_all <- paste(gd_all,gd_lines)
}
save(gd_all,file = './output/gd_all.RData')

## deal with punctuation and paste all text
source('~/GitHub/Spring2019-Proj4-group-12/lib/cleantext.R')
all_text = cleantext(gd_all)
all_text = paste("NULL ",all_text)
save(all_text,file = './output/all_text.RData')
## calculate context frequency

ng <- ngram (all_text, n =  2)
bigrams = data.frame(get.phrasetable(ng))

bigram_counts = bigrams %>%
  separate(ngrams, c("l", "r"), sep = " ") %>%
  .[,c("l","r","freq")]

## GT turning
r=table(bigram_counts$freq)
## r_star=c(r["1"]/316887918)
r_star = c()
for (i in 1:(length(r)-1)) {
  r_star = c(r_star,(as.integer(names(r[i]))+1)*r[i+1]/r[i])
}
r_star = c(r_star, as.integer(names(r[length(r)]))+1)
names(r_star) = names(r)
f = c()
for (j in 1:nrow(bigram_counts)) {
  f = c(f,r_star[as.character(bigram_counts[j,]$freq)])
}

bigram_counts = cbind(bigram_counts,f)
save(bigram_counts,file = './output/bigram_counts.RData')