# At the time of writing, bigmemory does not support Windows.
# Tested on Mac OS X and Linux only.

# Create big.matrix
library(bigmemory)
bm <- big.matrix(1e9, 3, backingfile = "bm",
                 backingpath = tempdir())
bm

# Basic operations
typeof(bm)
dim(bm)
nrow(bm)
ncol(bm)
length(bm)
bm[1:5, ]
bm[1:3, ] <- diag(3)
bm[1:5, ]

# Chunked operation to generate data
chunksize <- 1e7
start <- 1
while (start <= nrow(bm)) {
    end <- start + chunksize - 1
    if (end > nrow(bm)) {
        end <- nrow(bm)
        chunksize <- nrow(bm) - start + 1
    }
    bm[start:end, 1] <- rpois(chunksize, 1e3)
    bm[start:end, 2] <- sample(0:1, chunksize, TRUE,
                               c(0.7, 0.3))
    bm[start:end, 3] <- runif(chunksize, 0, 1e5)    
    start <- start + chunksize
}

# Chunked operation to compute standard deviation
# First pass
col.sums <- numeric(3)
chunksize <- 1e7
start <- 1
while (start <= nrow(bm)) {
    end <- start + chunksize - 1
    if (end > nrow(bm)) {
        end <- nrow(bm)
    }
    col.sums <- col.sums + colSums(bm[start:end, ])
    start <- start + chunksize
}
col.means <- col.sums / nrow(bm)

# Second pass
col.sq.dev <- numeric(3)
start <- 1
while (start <= nrow(bm)) {
    end <- start + chunksize - 1
    if (end > nrow(bm)) {
        end <- nrow(bm)
    }
    col.sq.dev <- col.sq.dev +
        rowSums((t(bm[start:end, ]) - col.means) ^ 2)
    start <- start + chunksize
}
col.var <- col.sq.dev / (nrow(bm) - 1)
col.sd <- sqrt(col.var)
col.sd

# Compare with biganalytics
library(biganalytics)
big.col.sd <- colsd(bm)
all.equal(col.sd, big.col.sd)

