# Hierarchichal clustering using default hclust()
data <- rnorm(1E4*100)
dim(data) <- c(1E4,100)
dist_data <- dist(data)
system.time(hc_data <- hclust(dist_data))

# Hierarchical clustering using hclust() from fastcluster package
library(fastcluster)
system.time(hc_data <- hclust(dist_data))

# PCA using prcomp()
data <- rnorm(1E5*100)
dim(data) <- c(1E5,100)
system.time(prcomp_data <- prcomp(data))

# PCA using princomp()
system.time(princomp_data <- princomp(data))
