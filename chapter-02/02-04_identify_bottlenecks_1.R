# Compute sample variance of numeric vector x
sampvar <- function(x) {
    # Compute sum of vector x
    my.sum <- function(x) {
        sum <- 0
        for (i in x) {
            sum <- sum + i
        }
        sum
    }
    
    mu <- my.sum(x) / length(x)
    sq <- my.sum((x - mu) ^ 2)
    sq / (length(x) - 1)
}

# Profile sampvar()
x <- runif(1e7)
Rprof("Rprof-mem.out", memory.profiling=TRUE)
y <- sampvar(x)
Rprof(NULL)
summaryRprof("Rprof-mem.out", memory="both", diff=TRUE)
