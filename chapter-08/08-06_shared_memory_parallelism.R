# At the time of writing, bigmemory does not support Windows.
# Tested on Mac OS X and Linux only.

# Demonstrating shared-memory object
library(bigmemory)
a <- big.matrix(3, 3)
a[, ]
b <- a
b[, ]
b[, ] <- diag(3)
b[, ]
a[, ]
a
b

# Generate random data
r <- 5e7
m <- matrix(rnorm(r * 2), r, 2)
bm <- as.big.matrix(m)

# Distributed memory parallelism
library(parallel)
cl <- makeCluster(detectCores())
part <- clusterSplit(cl, seq_len(r))
system.time(res <- unlist(
    parLapply(cl, part,
              function(part, data) {
                  abs(data[part, 1] - data[part, 2])
              },
              m)
))
stopCluster(cl)

# Shared memory parallelism
cl <- makeCluster(detectCores())
system.time(res2 <- unlist(
    parLapply(cl, part,
              function(part, data.desc) {
                  library(bigmemory)
                  data <- attach.big.matrix(data.desc)
                  abs(data[part, 1] - data[part, 2])
              },
              describe(bm))
))
stopCluster(cl)
