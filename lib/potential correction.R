data(grady_augmented) # an english dictionary

potential_correction <- function(typo)
{
  # Input typo, output a list of potential correction
  # Note that the typo will be lowercased and removed punctuations
  
  candidates <- data.frame(typo=character(),
                           correction=character(),
                           pos=integer(),
                           change=character(),
                           type=character(),
                           stringsAsFactors=FALSE)
  typo <- tolower(typo)
  typo <- gsub('[[:punct:] ]+','',typo)
  typo_characters <- strsplit(typo, "")[[1]]
  if(length(typo_characters) == 0)
  {
    return()
  }
  
  # insertion
  for(i in 1:length(typo_characters))
  {
    correction <- paste(typo_characters[-i],collapse = "")
    pos <- i-1
    change <- typo_characters[i]
    type <- "i"
    candidates[nrow(candidates)+1,] <- list(typo,correction,pos,change,type)
  }
  
  
  # deletion
  letters <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
  for(i in 1:(length(typo_characters)+1))
  {
    for(j in 1:26)
    {
      correction <- append(typo_characters,letters[j],after=i-1)
      correction <- paste(correction,collapse = "")
      pos <- i-1
      change <- letters[j]
      type <- "d"
      candidates[nrow(candidates)+1,] <- list(typo,correction,pos,change,type)
    }
  }
  
  # reversal
  if(length(typo_characters)>1)
  {for(i in 1:(length(typo_characters)-1))
  {
    correction <- typo_characters
    correction[i] <- typo_characters[i+1]
    correction[i+1] <- typo_characters[i]
    correction <- paste(correction,collapse = "")
    pos <- i-1
    change <- paste(typo_characters[i:(i+1)],collapse = "")
    type <- "r"
    candidates[nrow(candidates)+1,] <- list(typo,correction,pos,change,type)
  }}
  
  
  
  # substitution
  for(i in 1:length(typo_characters))
  {
    for(j in 1:26)
    {
      correction <- typo_characters
      correction[i] <- letters[j]
      correction <- paste(correction,collapse = "")
      pos <- i-1
      change <- letters[j]
      type <- "s"
      candidates[nrow(candidates)+1,] <- list(typo,correction,pos,change,type)
    }
  }
  
  # remove unmeaningful words
  remove <- function(df)
  {
    return((df[2] %in% grady_augmented))
  }
  index <- apply(candidates,1,remove)
  candidates <- candidates[index,]
  
  return(candidates)
}


