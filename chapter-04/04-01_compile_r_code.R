# Compute the n-period moving average of x
mov.avg <- function(x, n=20) {
    total <- numeric(length(x) - n + 1)
    for (i in 1:n) {
        total <- total + x[i:(length(x) - n + i)]
    }
    total / n
}

# Compile function with different levels of optimization
library(compiler)
mov.avg.compiled0 <- cmpfun(mov.avg, options=list(optimize=0))
mov.avg.compiled1 <- cmpfun(mov.avg, options=list(optimize=1))
mov.avg.compiled2 <- cmpfun(mov.avg, options=list(optimize=2))
mov.avg.compiled3 <- cmpfun(mov.avg, options=list(optimize=3))

# Benchmark
library(microbenchmark)
x <- runif(100)
microbenchmark(mov.avg(x),
               mov.avg.compiled0(x),
               mov.avg.compiled1(x),
               mov.avg.compiled2(x),
               mov.avg.compiled3(x))
