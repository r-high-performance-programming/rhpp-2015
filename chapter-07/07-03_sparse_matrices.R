# Numeric data
library(Matrix)
n <- rnorm(1e6)
n[sample.int(1e6, 7e5)] <- 0
m.dense <- Matrix(n, 1e3, 1e3, sparse = FALSE)
m.sparse <- Matrix(n, 1e3, 1e3, sparse = TRUE)
object.size(n)
object.size(m.dense)
object.size(m.sparse)

# Logical data
l <- sample(c(FALSE, TRUE), 1e6, TRUE, c(0.7, 0.3))
m2.dense <- Matrix(l, 1e3, 1e3, sparse = FALSE)
m2.sparse <- Matrix(l, 1e3, 1e3, sparse = TRUE)
object.size(l)
object.size(m2.dense)
object.size(m2.sparse)
