# Set up data and time serial execution
RNGkind("L'Ecuyer-CMRG")
nsamples <- 5e8
lambda <- 10
system.time(random1 <- rpois(nsamples, lambda))

# Split job evenly to workers
library(parallel)
ncores <- detectCores()
cl <- makeCluster(ncores)
samples.per.process <-
    diff(round(seq(0, nsamples, length.out = ncores+1)))

# Socket cluster
clusterSetRNGStream(cl)
system.time(random2 <- unlist(
    parLapply(cl, samples.per.process, rpois,
              lambda = lambda)
))
stopCluster(cl)

# Forked cluster (non-Windows only)
system.time(random3 <- unlist(
    mclapply(samples.per.process, rpois,
             lambda = lambda,
             mc.set.seed = TRUE, mc.cores = ncores)
))
