## Create a list that contains typo and position in tesseract_vec
source('../output/tesseract_vec.RData')
source('../output/detection_result.RData')
typos <- data.frame(typo=character(),
                    posx=integer(),
                    posy=integer(),
                    stringsAsFactors=FALSE)
for(i in 1:length(tesseract_vec))
{
  for(j in 1:length(tesseract_vec[[i]]))
  {
    if(detection_result[[i]][j]==FALSE)
    {
      typo <- tesseract_vec[[i]][j]
      posx <- i
      posy <- j
      typos[(nrow(typos)+1),] <- list(typo,posx,posy)
    }
  }
}
save(typos, file='../output/typos.RData')