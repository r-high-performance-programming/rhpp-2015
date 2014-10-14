library(ff)

# Create ff vector
i <- ff(1:1e6)
i
filename(i)

# Create ff matrix, initializing with a scalar
j <- ff(FALSE, dim = c(50, 100),
        filename = file.path(tempdir(), "j.ff"))
j

# Create ff vector with specified vmode
q <- ff(sample(0:3, 1e6, TRUE), vmode = "quad")
q

# Create ff data frame (ffdf)
d <- ffdf(i, q)
d[1:5, ]
vmode(d)

# Split data into chunks
chunk(d)
c <- chunk(d, BATCHBYTES = 2e6)
c

# Chunked computation
total <- numeric(2)
quad.table <- integer(4)
names(quad.table) <- 0:3
for (idx in c) {
    total <- total + colSums(d[idx, ])
    quad.table <- quad.table + table(q[idx])
}
total
quad.table

# Delete disk file when done
delete(d)
delete(lm)
delete(i)
rm(i)
rm(q)