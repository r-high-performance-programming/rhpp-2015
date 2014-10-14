# Compare object size
library(bit)
l <- sample(c(TRUE, FALSE), 1e6, TRUE)
b <- as.bit(l)
object.size(l)
object.size(b)

# Compare logical operations
library(microbenchmark)
l2 <- sample(c(TRUE, FALSE), 1e6, TRUE)
b2 <- as.bit(l2)
microbenchmark(!l, !b)
microbenchmark(l & l2, b & b2)
microbenchmark(l == l2, b == b2)
