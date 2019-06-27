
# rscript to merge all .rds files to a chosen output 
# in a given folder with a given pattern
main <- function(){
  args <- commandArgs(trailingOnly = TRUE)
  folder <- args[1]
  pattern <- args[2]
  output <- args[3]
  ncol <- args[4]
  
  files <- list.files(path = folder,
                      pattern = pattern, 
                      full.names = TRUE)
  
  numfiles <- length(files)
  
  merged <- matrix(NA,nrow=numfiles, ncol = ncol)
  for(i in 1:numfiles){
    merged[,i] <- readRDS(files[i])
  }
  
  saveRDS(merged,paste0(folder,output))
  
}

main()