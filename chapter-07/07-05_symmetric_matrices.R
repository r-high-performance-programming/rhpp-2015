# Symmetric matrix
library(Matrix)
data <- matrix(rnorm(1E5), 1E2, 1E3) 
A <- cor(data)
isSymmetric(A)
B <- as(A, "dspMatrix")
object.size(A)
object.size(B)

# Distance matrix
C <- as.dist(A)
object.size(C)

# Accessing elements in a symmetric matrix
n <- nrow(A)
i <- 10
j <- 531
A[i,j]
C[n*(i-1) - i*(i-1)/2 + j -i]
