library(stringr)
check_gc <- function(inputString){
  full.length = str_length(inputString)  
  G.count <-  str_count(inputString, "G")
  C.count <-  str_count(inputString,"C")
  return((G.count+C.count)/full.length)
}
check_repeat <- function(inputString) {
  
  possible_choice <- c("A", "T", "C", "G")
  full.length = str_length(inputString)
  chr.list = str_split(inputString, pattern = "", simplify = TRUE)
  max.counter =1
  for (base in possible_choice) {
    counter = 1
    for (i in seq(length(chr.list) - 1)) {
      if (chr.list[i] != chr.list[i + 1]) {
        next
      } else if(base == chr.list[i]){
        counter = counter + 1
        
      }
      if(counter >= max.counter){
        max.counter = counter
      }
    }
    
  }
  return(max.counter)
}
lenght_index <- 8
possible_choice <- c("A","T","C","G")
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
eight_mer.gc <- sapply(eight_mer.vector, check_gc)
eight_mer.repeat <- sapply(eight_mer.vector, check_repeat)
eight_mer.df <-data.frame(eight_mer.gc,eight_mer.repeat)
library(dplyr)
eight_mer.df %>%  filter(eight_mer.gc >0.33) %>% filter(eight_mer.gc <0.66) %>% filter(eight_mer.repeat <=2) -> eight_mer.pass.filter.df
eight_mer.pass.filter.vector <- rownames(eight_mer.pass.filter.df)

library(vwr)
library(reshape2)
library(ggplot2)       
library(viridis)

success_flag <- FALSE
target.index.number <- 24
### other than itself, it should not have ld < threshold
validate_pair <- function (inputList) {
  firstString = inputList[1]
  secondString = inputList[2]
  value = inputList[3]
  threshold = 2
  if (firstString != secondString) {
    if (value <= threshold) {
      return(FALSE)
    } else{
      return(TRUE)
    }
  } else{
    return(TRUE)
  }
}

trial.counter =1

while (success_flag != TRUE) {
  ## keep trying!
  sample.indexes <-
    sample(eight_mer.pass.filter.vector, size = target.index.number)
  sample_mtx <-
    sapply(sample.indexes, levenshtein.distance, targets = sample.indexes)
  sample.df <- melt(sample_mtx)
  for_flag = TRUE
  for(row in 1:nrow(sample.df)){
    if(!validate_pair(sample.df[row,])){
      for_flag=FALSE
      break
    }
  }
  for_flag
  if(for_flag){
    break
  }
  success_flag <- all(apply(sample.df, 1, validate_pair)) ### DONE: use a for loop to break if any false , more efficient
  trial.counter = trial.counter+1
}
# sample.indexes
print(trial.counter)
plot.heatmap <- ggplot(sample.df,aes(Var1,Var2))
plot.heatmap + geom_tile(aes(fill=value)) +
  theme(axis.text.x = element_blank(),axis.text.y = element_blank(),axis.title.x = element_blank(),axis.title.y = element_blank())+
  scale_fill_viridis()

saveRDS(sample.df,file="sample_df.rds")
