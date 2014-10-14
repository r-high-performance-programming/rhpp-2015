# Compute sample variance of numeric vector x
sampvar <- function(x) {
    mu <- sum(x) / length(x)
    sq <- sum((x - mu) ^ 2)
    sq / (length(x) - 1)
}

# Profile sampvar()
x <- runif(1e7)
Rprof("Rprof-mem.out", memory.profiling=TRUE)
y <- sampvar(x)
Rprof(NULL)
summaryRprof("Rprof-mem.out", memory="both", diff=TRUE)

# Benchmark against var() using 100 repetitions
library(microbenchmark)
microbenchmark(sampvar(x), var(x))
