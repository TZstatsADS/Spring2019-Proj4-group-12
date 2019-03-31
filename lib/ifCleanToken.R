##############################
## Garbage detection
## Ref: 'On Retrieving Legal Files: Shortening Documents and Weeding Out Garbage'
## Input: one word -- token
## Output: bool -- if the token is clean or not
##############################
ifCleanToken <- function(cur_token){
  now <- 1
  if_clean <- TRUE
  
  ## in order to accelerate the computation, conduct ealy stopping
  rule_list <- c(
    "nchar(cur_token)>20", #If a string is more than 20 characters in length, it is garbage
    "str_count(cur_token, pattern = '[^A-Za-z0-9]') >= str_count(cur_token, pattern = '[A-Za-z0-9]')", # If the number of punctuation characters in a string is greater than the number of alphanumeric characters, it is garbage
    "length(unique(strsplit(gsub('[A-Za-z0-9]','',substr(cur_token, 2, nchar(cur_token)-1)),'')[[1]]))>1", #Ignoring the first and last characters in a string, if there are two or more different punctuation characters in thestring, it is garbage
    "str_count(cur_token, pattern = '([A-z])\\1{2,}')>=1", #  If there are three or more identical characters in a row in a string, it is garbage           
    "(str_count(cur_token, pattern = '[A-Z]')>str_count(cur_token, pattern = '[a-z]')) & ((str_count(cur_token, pattern = '[A-Z]') <nchar(cur_token)))", #If the number of uppercase characters in a string is greater than the number of lowercase characters, and if the number of uppercase characters is less than the total number of characters in the string, it is garbage
    "(str_count(cur_token, pattern = '[^A-z]')==0) & ((str_count(cur_token, pattern = '[aeiouAEIOU]') > (8*str_count(cur_token, pattern = '[^aeiouAEIOU]')))|(str_count(cur_token, pattern = '[^aeiouAEIOU]') > (8*str_count(cur_token, pattern = '[aeiouAEIOU]'))))", #If all the characters in a string are alphabetic, and if the number of consonants in the string is greater than 8 times the number of vowels in the string, or vice-versa, it is garbage
    "(str_count(cur_token, pattern = '[aeiouAEIOU]{4,}')>=1)|(str_count(cur_token, pattern = '[^aeiouAEIOU]{5,}')>=1)", #If there are four or more consecutive vowels in the string or five or more consecutive consonants in the string, it is garbage
    "(str_count(cur_token, pattern = '^[a-z].*[a-z]$')==1) & (str_count(substr(cur_token, 2, nchar(cur_token)-1), pattern = '[A-Z]')>=1)" #If the first and last characters in a string are both lowercase and any other character is uppercase, it is garbage
    )  
  if_clean <- ifelse((str_count(cur_token, pattern = '([A-z])\\1{2,}')>=1),FALSE,TRUE)
  while((if_clean == TRUE)&now<=length(rule_list)){
    if(eval(parse(text = rule_list[now]))){
      if_clean <- FALSE
    }
    now <- now + 1
  }
  return(if_clean)
}