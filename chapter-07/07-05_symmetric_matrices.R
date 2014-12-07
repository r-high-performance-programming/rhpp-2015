# Symmetric matrix
library(Matrix)
data <- matrix(rnorm(1E5), 1E2, 1E3) 
A <- cor(data)
isSymmetric(A)
B <- as(A, "dspMatrix")
object.size(A)
object.size(B)
