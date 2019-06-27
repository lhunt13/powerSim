library(simsurv)
library(survival)
library(getopt)
source('sim.R')

args <- commandArgs(trailingOnly = TRUE)
boot.index <- as.numeric(args[1])

# pass parameter values
N = as.numeric(args[2])
delay = as.numeric(args[3])
late_effect = as.numeric(args[4])
early_effect = as.numeric(args[5])
tau = as.numeric(args[6])

set.seed(123)
boot.seed <- sample(1e6, size = tval, replace = F)[boot.index]
set.seed(boot.seed)

result = sim(N=N, 
             delay=delay, 
             late_effect=late_effect, 
             early_effect=early_effect,
             tau=tau)


# store results
# save file in "truth" directory with file name "run-<boot.index>.rds"
results.file <- file.path("results", paste0("run-", boot.index, ".rds"))
saveRDS(result, results.file)
# quit R and don't save workspace
quit('no')
