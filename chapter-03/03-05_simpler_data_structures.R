# Matrix
data <- rnorm(1E4*1000)
dim(data) <- c(1E4,1000)
system.time(data_rs1 <- rowSums(data))

# Data frame
data_df <- data.frame(data)
system.time(data_rs2 <- rowSums(data_df))

# Subsetting data frame with logical vector
data <- rnorm(1E5*1000)
dim(data) <- c(1E5,1000)
data_df <- data.frame(data)
system.time(data_df[data_df$X100>0 & data_df$X200<0,])

# Subsetting data frame with which()
system.time(data_df[which(data_df$X100>0 & data_df$X200<0),])