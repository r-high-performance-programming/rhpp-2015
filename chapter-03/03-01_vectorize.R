# Calculate squares using a for loop
N <- 1E5
data <- sample(1:30, size=N, replace=T)
system.time({ 
    data_sq1 <- numeric(N)
    for(j in 1:N) {
        data_sq1[j] <- data[j]^2
    } 
})

# Calculate squares using vectorization
system.time(data_sq2 <- data^2)
