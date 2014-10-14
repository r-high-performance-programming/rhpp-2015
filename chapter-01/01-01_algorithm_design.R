# Number of different sized data sets to generate
dataSets <- 10

# Generate data sets with linearly increasing size
# Each data set has 3 clusters
x <- lapply(1:dataSets, function(i) {
    m <- rbind(matrix(rnorm(i * 1000, sd=0.2, mean=0), ncol = 2),
               matrix(rnorm(i * 1000, sd=0.2, mean=1), ncol = 2),
               matrix(rnorm(i * 1000, sd=0.2, mean=2), ncol = 2))
    colnames(m) <- c("x", "y")
    return(m)
})

# Run a function a given number of times, and return the mean
# running times
timer <- function(.fun, .repeats=20, ...) {
    run.times <- sapply(1:.repeats, function(i, .fun, ...) {
        system.time(.fun(...))
    }, .fun, ...)
    rowMeans(run.times)
}

# Time the k-means algorithm on different sized data sets
kmeans.time <- sapply(x, function(m) {
    timer(kmeans, x=m, centers=3, nstart=5)
})
plot(1:dataSets, kmeans.time["elapsed", ],
     main="kmeans()", xlab="Data Size", ylab="Run Time", pch=4)

# Time the hierarchical clustering algorithm on different sized
# data sets
hclust.time <- sapply(x, function(m) {
    d <- dist(m)
    timer(hclust, d=d)
})

# Plot to compare kmeans vs hclust
plot(1:dataSets, hclust.time["elapsed", ],
     main="kmeans() vs hclust()",
     xlab="Data Size", ylab="Run Time", pch=1)
points(1:dataSets, kmeans.time["elapsed", ], pch=4)
