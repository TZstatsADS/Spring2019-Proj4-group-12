context_prob = function(l, r, correct){
  if(correct == "l")
    return(bigram_counts[which((bigram_counts$l==l) & (bigram_counts$r==r)),]$freq / sum(bigram_counts[which(bigram_counts$l==l),]$freq))
  else
    return(bigram_counts[which((bigram_counts$l==l) & (bigram_counts$r==r)),]$freq / sum(bigram_counts[which(bigram_counts$r==r),]$freq))
}