A <- matrix(rnorm(1E5), 1E4, 10)
dist_mat <- as.matrix(dist(A))
diag(dist_mat) <- NA
min_elem <- min(dist_mat, na.rm=T)
res1 <- which(dist_mat == min_elem, arr.ind = T)[1,]
res1
print(object.size(A), units="MB")
print(object.size(dist_mat), units="MB")

library(pdist)
temp_res <- lapply(c(1:nrow(A)), function(x) {
    temp <- as.matrix(pdist(X = A, Y = A[x,]));
    temp[which(temp == 0)] <- NA;
    output_val <- min(temp, na.rm=T);
    output_ind <- c(which(temp == output_val), x)
    output <- list(val = output_val, ind = output_ind);
})
val_vec <- sapply(temp_res, FUN=function(x) x$val)
ind_vec <- sapply(temp_res, FUN=function(x) x$ind)
res2 <- ind_vec[, which.min(val_vec)]
res2
print(object.size(temp_res), units="MB")
print(object.size(val_vec), units="MB")
print(object.size(ind_vec), units="MB")
