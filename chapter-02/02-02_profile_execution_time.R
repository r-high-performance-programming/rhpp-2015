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
    
    # Compute sum of squared variances of the elements of x from
    # the mean mu
    sq.var <- function(x, mu) {
        sum <- 0
        for (i in x) {
            sum <- sum + (i - mu) ^ 2
        }
        sum
    }
    
    mu <- my.sum(x) / length(x)
    sq <- sq.var(x, mu)
    sq / (length(x) - 1)
}

# Profile sampvar()
x <- runif(1e7)
Rprof("Rprof.out")
y <- sampvar(x)
Rprof(NULL)
summaryRprof("Rprof.out")

# Display profiling results graphically
library(proftools)
p <- readProfileData(filename="Rprof.out")
plotProfileCallGraph(p, style=google.style, score="total")
