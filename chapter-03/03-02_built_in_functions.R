# Calculate row sums using apply()
data <- rnorm(1E4*1000)
dim(data) <- c(1E4,1000)
system.time(data_sum1 <- apply(data, 1, sum)) 

# Calculate row sums using optimized built-in function
system.time(data_sum2 <- rowSums(data))
