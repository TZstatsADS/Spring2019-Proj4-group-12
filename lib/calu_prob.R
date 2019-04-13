source('~/GitHub/Spring2019-Proj4-group-12/lib/context_prob.R')
source('~/GitHub/Spring2019-Proj4-group-12/lib/cleantext.R')

typos$typo=tolower(typos$typo) %>% gsub("[[:punct:]]","",.)
final_prob = merge(x=cand_prob_wt_context_df,y=typos,by="typo",all.x=TRUE) %>%
  .[which(is.na(.$posx)==FALSE),]

a = t(apply(final_prob[,c(5,6)], 1, get_lr))
p = t(apply(final_prob[,c(5,2,6)], 1, context_prob))
final_prob = cbind(final_prob,p)
final_prob = final_prob[,c(1,2,5,6,3,4,7,8)]
colnames(final_prob)=c("typo","correction","posx","posy","pc","ptc","pl|c","pr|c")
save(final_prob,file = '~/GitHub/Spring2019-Proj4-group-12/output/final_prob.RData')