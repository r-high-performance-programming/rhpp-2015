x <- runif(1e6)
print(object.size(x), units = "auto")
y <- list(x, x)
print(object.size(y), units = "auto")

library(pryr)
object_size(x)
object_size(y)

address(x)
address(y)
address(y[[1]])
address(y[[2]])

object_size(x, y)

y[[1]][1] <- 0
address(x)
address(y[[1]])
address(y[[2]])
object_size(y)
object_size(x, y)

tracemem(y[[2]])
y[[2]][1] <- 0
untracemem(y[[2]])
address(x)
address(y[[1]])
address(y[[2]])
object_size(y)
object_size(x, y)

tracemem(x)
x[1]<- 1
x[1]<- 1
x[1]<- 0.5
x[2] <- 0.3
untracemem(x)

customer.age <- sample(18:100, 1e6, replace=TRUE)
customer.gender <- sample(c("Male", "Female"), 1e6, TRUE)

names(customer.age) <- paste("cust", 1:1e6)
names(customer.gender) <- paste("cust", 1:1e6)
object_size(customer.age, customer.gender)

customer.names <- paste("cust", 1:1e6)
names(customer.age) <- customer.names
names(customer.gender) <- customer.names
object_size(customer.age, customer.gender, customer.names)
