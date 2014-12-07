# Generate sales data
trans.lengths <- rpois(5e5, 3) + 1L
trans <- rep.int(1:5e5, trans.lengths)
items <- unlist(lapply(trans.lengths, sample.int, n = 1000))
sales.data <- data.frame(trans = trans, item = items)
head(sales.data, 15)

# Find frequent itemsets
library(arules)
trans.list <- split(sales.data$item, sales.data$trans)
trans.arules <- as(trans.list, "transactions")
freq.itemsets <- apriori(trans.arules, list(support = 0.3))
library(pryr)
object_size(sales.data)
object_size(trans.list)
object_size(trans.arules)

# Remove intermediate results along the way
trans.list <- split(sales.data$item, sales.data$trans)
rm(sales.data)
trans.arules <- as(trans.list, "transactions")
rm(trans.list)
freq.itemsets <- apriori(trans.arules, list(support = 0.3))

# Automatically remove temporary variables by encapsulating code
# in a function
prepare_data <- function(sales.data) {
    trans.list <- split(sales.data$item, sales.data$trans)
    trans.arules <- as(trans.list, "transactions")
    return(trans.arules)
}
trans.arules <- prepare_data(sales.data)
# Any temporary variables created in the function are deleted,
# freeing up memory
freq.itemsets <- apriori(trans.arules, list(support = 0.3))

