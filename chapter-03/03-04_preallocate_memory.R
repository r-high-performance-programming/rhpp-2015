# Without preallocating memory
N <- 1E4
data_series1 <- 1
system.time({
    for (j in 2:N) {
        data_series1 <-
            c(data_series1,
              data_series1[j - 1] + sample(-5:5, size=1))
    }
})

# With preallocating memory
data_series2 <- numeric(N)
data_series2[1] <- 1
system.time({
    for (j in 2:N) {
        data_series2[j] <-
            data_series2[j - 1] + sample(-5:5, size=1)
    }
})

# Comparing with lapply()
N <- 1E5
data <- sample(1:30, size=N, replace=T)

# For loop without preallocating memory
data_rand1 <- list()
system.time({
    for(i in 1:N) {
        data_rand1[[i]] <- rnorm(data[i])
    }
})

# lapply
system.time(data_rand2 <- lapply(data, FUN=function(x){
    rnorm(x)
}))

# For loop with preallocating memory
data_rand3 <- vector("list", N)
system.time({
    for(i in 1:N) {
        data_rand3[[i]] <- rnorm(data[i])
    }
})
