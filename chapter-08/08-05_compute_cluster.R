# Register workers and master of the cluster
library(parallel)
workers <- c("ip.address", "ip.address", "ip.address")
nworkers <- length(workers)
cl <- makeCluster(workers, master = "ip.address")

# Execute job
clusterSetRNGStream(cl)
samples.per.process <- c(2.5e8, 2.5e8)
lambda <- 10
random <- unlist(
    parLapply(cl, samples.per.process,
              function(n, lambda) rpois(n, lambda),
              lambda)
)
stopCluster(cl)
