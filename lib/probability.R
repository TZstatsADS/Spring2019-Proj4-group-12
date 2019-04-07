source("../output/ground_truth_frequency.RData")

probability <- function(i,j,typo,correction,category)
{
  # parameter explaination
  ## index of error word in tesseract_vec: i_th row, j_th column
  ## typo: the wrong word; correction: the potential correction word
  ## category: the category of correction type -- i(nsertion), r(versal), s(ubstitution), d(eletion)
  
  # without context
  N <- sum(ground_truth_freq[,2])
  V <- nrow(ground_truth_freq)
  freq <- ifelse((correction %in% ground_truth_freq$tokens),
                 ground_truth_freq[ground_truth_freq$tokens==correction,2],
                 0)
  Pr_c <- (freq+0.5)/(N+V/2)
  
  Pr_t_c
  # with context
  
  Pr_l_c
  
  Pr_r_c
  
  # Combine probability
  Pr = Pr_c*1*1*1
  
  return(Pr)
}

