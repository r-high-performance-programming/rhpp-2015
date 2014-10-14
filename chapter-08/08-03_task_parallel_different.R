# Serial execution
RNGkind("L'Ecuyer-CMRG")
nsamples <- 5e7
pois.lambda <- 10
system.time(random1 <- list(pois = rpois(nsamples,
                                         pois.lambda),
                            unif = runif(nsamples),
                            norm = rnorm(nsamples),
                            exp = rexp(nsamples)))

# Socket cluster
library(parallel)
cores <- detectCores()
cl <- makeCluster(cores)
calls <- list(pois = list("rpois", list(n = nsamples,
                                        lambda = pois.lambda)),
              unif = list("runif", list(n = nsamples)),
              norm = list("rnorm", list(n = nsamples)),
              exp = list("rexp", list(n = nsamples)))
clusterSetRNGStream(cl)
system.time(
    random2 <- parLapply(cl, calls,
                         function(call) {
                             do.call(call[[1]], call[[2]])
                         })
)
stopCluster(cl)

# Forked cluster (non-Windows only)
mc.reset.stream()
system.time({
    jobs <- list()
    jobs[[1]] <- mcparallel(rpois(nsamples, pois.lambda),
                            "pois", mc.set.seed = TRUE)
    jobs[[2]] <- mcparallel(runif(nsamples),
                            "unif", mc.set.seed = TRUE)
    jobs[[3]] <- mcparallel(rnorm(nsamples),
                            "norm", mc.set.seed = TRUE)
    jobs[[4]] <- mcparallel(rexp(nsamples),
                            "exp", mc.set.seed = TRUE)
    random3 <- mccollect(jobs)
})
