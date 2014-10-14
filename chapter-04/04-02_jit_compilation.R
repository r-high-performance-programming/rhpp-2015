# Enable JIT compilation
library(compiler)
enableJIT(level=3)

# mov.avg() defined in previous example
library(microbenchmark)
microbenchmark(mov.avg(x))
