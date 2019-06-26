do_sim <- function(numsim,N,delay,late_effect,early_effect,tau){
  pars <- c(trt = 0) # no initial effect of treatment
  pars_tde <- c(trt = log(late_effect))
  p_value <- rep(NA,numsim)
  for(i in 1:numsim){
    covs <- data.frame(id = 1:N,
                       trt = rbinom(N,1,.5))
    times <- simsurv(dist = 'weibull',
                     lambdas = 0.1,
                     gammas = 1,
                     x = covs,
                     betas = pars,
                     tde = pars_tde,
                     tdefunction = function(x){x >= delay},
                     maxt = tau)
    
    data <- merge(times,covs)
    
    p_value[i] <- 1 - pchisq(survdiff(Surv(eventtime, status) ~ trt,data = data)$chisq,
                             df = 1)
  }
  power <- mean(p_value < .05)
  return(power)
}