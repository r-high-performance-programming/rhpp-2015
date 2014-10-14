# Tested only on AWS g2.2xlarge instances with the following AMIs:
# Amazon Linux AMI with NVIDIA GRID GPU Driver (version 2014.03.2)
# (https://aws.amazon.com/marketplace/pp/B00FYCDDTE/)
# Not known to work on Windows

library(gputools)
library(microbenchmark)
A <- lapply(c(1:5), function(x) {
    matrix(rnorm((x*1e2) * 1e2), 1e2, (x*1e2))})
cpu_k_time <- sapply(A, function(x) {
    system.time(cor(x=x, method="kendall"))[[3]]})
gpu_k_time <- sapply(A, function(x) {
    system.time(gpuCor(x=x, method="kendall"))[[3]]})
K <- data.frame(cpu=cpu_k_time, gpu=gpu_k_time)
