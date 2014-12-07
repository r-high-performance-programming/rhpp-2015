# Tested only on AWS g2.2xlarge instances with the following AMIs:
# Amazon Linux AMI with NVIDIA GRID GPU Driver (version 2014.03.2)
# (https://aws.amazon.com/marketplace/pp/B00FYCDDTE/)
# Not known to work on Windows

library(gputools)
library(microbenchmark)

# Linear models
A <- matrix(rnorm(1e7), 1e4, 1e3)
A_df <- data.frame(A)
A_df$label <- rnorm(1e4)
microbenchmark(lm(label~., data=A_df),
               gpuLm(label~., data=A_df), 
               times=30L)

# Generalized linear models (GLMs)
A <- matrix(rnorm(1e6), 1e3, 1e3)
A_df <- data.frame(A)
A_df$label <- rbinom(1e3, size=1, prob=0.5)
microbenchmark(glm(label~., data=A_df, family=binomial), 
               gpuGlm(label~., data=A_df, family=binomial),
               times=30L)

# Euclidean distance
microbenchmark(dist(A), gpuDist(A), times=30L)

# Matrix multiplication
B <- matrix(rnorm(1E6), 1E3, 1E3)
microbenchmark(A%*%B, gpuMatMult(A, B), times=30L)
