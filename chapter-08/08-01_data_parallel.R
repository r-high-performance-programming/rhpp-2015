# Set up data for the following examples
library(tm)
data("acq")
textdata <- rep(sapply(content(acq), content), 1e5)

# Serial execution
pattern <- "\\d+(,\\d+)? mln dlrs"
system.time(res1 <- grepl(pattern, textdata))

# Socket cluster
library(parallel)
detectCores()
cl <- makeCluster(detectCores())
part <- clusterSplit(cl, seq_along(textdata))
text.partitioned <- lapply(part, function(p) textdata[p])
system.time(res2 <- unlist(
    parSapply(cl, text.partitioned, grepl, pattern = pattern)
)) 
stopCluster(cl)

# Forked cluster (non-Windows only)
system.time(res3 <- unlist(
    mclapply(text.partitioned, grepl, pattern = pattern,
             mc.cores = detectCores())
))
