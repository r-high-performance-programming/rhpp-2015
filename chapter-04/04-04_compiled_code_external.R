library(Rcpp)
library(microbenchmark)
sourceCpp("mov_avg_Rcpp.cpp")
x <- runif(100)
microbenchmark(mov.avg(x, 20),
               mov.avg.inline(x, 20),
               mov_avg_Rcpp(x, 20))
