# Set up data and time serial execution
RNGkind("L'Ecuyer-CMRG")
nsamples <- 5e8
lambda <- 10
system.time(random1 <- rpois(nsamples, lambda))

# Split job evenly to workers
library(parallel)
cores <- detectCores()
cl <- makeCluster(cores)
samples.per.process <- rep.int(nsamples %/% cores, cores)
for (i in seq_len(nsamples %% cores)) {
    samples.per.process[i] <- samples.per.process[i] + 1L
}

# Socket cluster
clusterSetRNGStream(cl)
system.time(random2 <- unlist(
    parLapply(cl, samples.per.process,
              function(n, lambda) rpois(n, lambda),
              lambda)
))
stopCluster(cl)

# Forked cluster (non-Windows only)
system.time(random3 <- unlist(
    mclapply(samples.per.process,
             function(n, lambda) rpois(n, lambda),
             lambda,
             mc.set.seed = TRUE, mc.cores = cores)
))
