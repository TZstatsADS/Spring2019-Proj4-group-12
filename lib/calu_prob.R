source('~/GitHub/Spring2019-Proj4-group-12/lib/context_prob.R')

typos$typo=tolower(typos$typo) %>% gsub("[[:punct:]]","",.)
final_prob = merge(x=cand_prob_wt_context_df,y=typos,by="typo",all.x=TRUE) %>%
  .[which(is.na(.$posx)==FALSE),]

a = t(apply(final_prob[,c(5,6)], 1, get_lr)) 
final_prob[,5]=a[,1];final_prob[,6]=a[,2]
p = t(apply(final_prob[,c(5,2,6)], 1, context_prob))
final_prob = cbind(final_prob,p)
final_prob = final_prob[,c(1,2,5,6,3,4,7,8)]
colnames(final_prob)=c("typo","correction","l","r","pc","ptc","pl|c","pr|c")
save(final_prob,file = './output/final_prob.RData')