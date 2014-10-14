# Run with different versions of BLAS to compare performance
data <- rnorm(1E7)
dim(data) <- c(1E4, 1E3)
system.time(data_mul <- t(data) %*% data)
