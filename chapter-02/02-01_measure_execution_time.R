# Measure one execution
system.time(runif(1e8))

# Measure multiple executions
library(rbenchmark)
bench1 <- benchmark(runif(1e8), replications=10)
bench1

# Mean execution time per replication
within(bench1, {
    elapsed.mean <- elapsed/replications
    user.self.mean <- user.self/replications
    sys.self.mean <- sys.self/replications
})

# Multiple samples of one execution
benchmark(runif(1e8), replications=rep.int(1, 10))

# Alternative, maybe more accurate, method
library(microbenchmark)
microbenchmark(runif(1e8), times=10)