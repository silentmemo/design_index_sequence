library(vwr)
library(reshape2)
library(ggplot2)       
library(viridis)
lenght_index <- 8
possible_choice <- c("A","T","C","G")

### for lack of a package to generate kmer, use recursive function
printAllKLength <- function(set, k){
  n = length(set)
  printAllKLengthRec(set,"",n,k)
}
printAllKLengthRec <- function(set,prefix,n,k){
  if (k == 0){
    cat(paste0(prefix,"\n"))
    return()
  }
  for (i in seq(1,n)){
    newPrefix = paste0(prefix,set[i])
    printAllKLengthRec(set,newPrefix,n,k-1)
  }
}

capture.output(printAllKLength(possible_choice,lenght_index), file = "eight_mer.txt", append = TRUE)
eight_mer <- read.table("eight_mer.txt", quote="\"", comment.char="")
eight_mer.vector <- eight_mer$V1
ld_mtx <- sapply(eight_mer.vector,levenshtein.distance,targets = eight_mer.vector)
saveRDS(ld_mtx,file = "eight_mer_ld_mtx.rds")
ld.df <- melt(ld_mtx)
saveRDS(ld.df,file = "eight_mer_ld_df.rds")