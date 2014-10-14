# Looking up a list
data <- rnorm(1E6)
data_ls <- as.list(data)
names(data_ls) <- paste("V", c(1:1E6), sep="")
index_rand <- sample(1:1E6, size=1000, replace=T)
index <- paste("V", index_rand, sep="")
list_comptime <- sapply(index, FUN=function(x){
    system.time(data_ls[[x]])[3]})
sum(list_comptime)

# Looking up a hash table
library(hash)
data_h <- hash(names(data_ls), data)
hash_comptime <- sapply(index, FUN=function(x){
    system.time(data_h[[x]])[3]})
sum(hash_comptime)
