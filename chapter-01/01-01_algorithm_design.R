# Compute nth Fibonacci number (recursive)
fibonacci_rec <- function(n) {
    if (n <= 1) {
        return(n)
    }
    return(fibonacci_rec(n - 1) + fibonacci_rec(n - 2))
}

# Benchmark recursive version
library(microbenchmark)
microbenchmark(fibonacci_rec(25), unit = "ms")

# Compute nth Fibonacci number (sequential)
fibonacci_seq <- function(n) {
    if (n <= 1) {
        return(n)
    }
    # (n+1)th element of this vector is the nth Fibonacci number
    fib <- rep.int(NA_real_, n + 1)
    fib[1] <- 0
    fib[2] <- 1
    for (i in 2:n) {
        fib[i + 1] <- fib[i] + fib[i - 1]
    }
    return(fib[n + 1])
}

# Benchmark sequential version
microbenchmark(fibonacci_seq(25), unit = "ms")

# Benchmark using different values of n
ns <- round(seq(0L, 50L, 2L))
timings <-
    matrix(nrow = length(ns), ncol = 2L,
           dimnames = list(ns, c("Recursive", "Sequential")))
# Sequential
# Take median of 20 runs
for (n in ns) {
    print(n)
    res <- print(microbenchmark(fibonacci_seq(n),
                                unit = "s", times = 20L))
    timings[as.character(n), "Sequential"] <- res$median
}
# Recursive
for (n in ns) {
    print(n)
    # Run only once for n > 30, since it will take a long time
    times <- if (n > 30L) 1L else 10L
    res <- print(microbenchmark(fibonacci_rec(n),
                                unit = "s", times = times))
    timings[as.character(n), "Recursive"] <- res$median
}

# Plot results
plot(ns, timings[, "Recursive"], pch = 1,
     main = "Computational Complexity for Computing Fibonacci Numbers",
     xlab = "n", ylab = "Execution Time (seconds)")
points(ns, timings[, "Sequential"], pch = 4)
legend("top", legend = c("Recursive", "Sequential"),
       pch = c(1, 4), bty = "o", cex = 0.75, horiz = TRUE)