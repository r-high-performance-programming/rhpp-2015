library(pryr)
A <- matrix(rnorm(1E5), 1E4, 10)
dist_mat <- as.matrix(dist(A))
diag(dist_mat) <- NA
res1 <- which(dist_mat == min(dist_mat, na.rm=T), arr.ind = T)[1,]
res1
object_size(A)
object_size(dist_mat)

library(pdist)
temp_res <- lapply(1:nrow(A), function(x) {
    temp <- as.matrix(pdist(X = A, Y = A[x,]));
    temp[x] <- NA;
    output_val <- min(temp, na.rm=T);
    output_ind <- c(x, which(temp == output_val))
    output <- list(val = output_val, ind = output_ind);
})
val_vec <- sapply(temp_res, FUN=function(x) x$val)
ind_vec <- sapply(temp_res, FUN=function(x) x$ind)
res2 <- ind_vec[, which.min(val_vec)]
res2
object_size(temp_res)
object_size(val_vec)
object_size(ind_vec)
