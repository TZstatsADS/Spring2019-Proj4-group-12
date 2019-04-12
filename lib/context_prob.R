library(dplyr)
library(tidyr)
library(stringr)

context_prob = function(text){
  l = text[1]; c = text[2]; r = text[3]
  l = cleantext(l) %>% 
      strsplit(., split = " ") %>%
      .[[1]] %>%
      .[length(.)]
  r = cleantext(r) %>% 
      strsplit(., split = " ") %>%
      .[[1]] %>%
      .[1]
  
  pc_l = sum(bigram_counts[which(bigram_counts$r==c),]$f)
  pc_r = sum(bigram_counts[which(bigram_counts$l==c),]$f)
  pl = bigram_counts[which((bigram_counts$l==l) & (bigram_counts$r==c)),]$f
  pl = ifelse(length(pl)>0, pl/pc_l, 31504/316887918)
  pr = bigram_counts[which((bigram_counts$l==c) & (bigram_counts$r==r)),]$f
  pr = ifelse(length(pr)>0, pr/pc_r, 31504/316887918)
  
  return(c(pl,pr))
}

## find the left and right word of typo
get_lr = function(pos){
  x=pos[1];y=pos[2]
  l = ifelse(y!=1, tesseract_vec[[x]][y-1], ".")
  r = ifelse(y!=length(tesseract_vec[[x]]), tesseract_vec[[x]][y+1], ".")
  return(c(l,r))
}


