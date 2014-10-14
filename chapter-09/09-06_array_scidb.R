# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# SciDB 14.8 on CentOS 6.5.

# Connect to DB and load data
library(scidb)
scidbconnect(host = "hostname", port = 8080)
A <- as.scidb(matrix(rnorm(1200), 40, 30), name = "A")
B <- as.scidb(matrix(rnorm(1200), 30, 40), name = "B")

# Matrix multiplication
A %*% B
# Transpose and addition / subtraction
A + t(B)
# Scalar operations
A * 1.5

# Mix DB data and R data
C <- matrix(rnorm(1200), 30, 40)
D <- A %*% C

# Filter only the positive elements of A, and materialize the
# results into R
(A > 0)[]
