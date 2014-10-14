library(arules)
# sales.data was generated in a previous example
trans.list <- split(sales.data$item, sales.data$trans)
saveRDS(sales.data, "sales.data.rds")
rm(sales.data)
trans.arules <- as(trans.list, "transactions")
rm(trans.list)
freq.itemsets <- apriori(trans.arules, list(support = 0.3))
sales.data <- readRDS("sales.data.rds")
# Perform further processing with sales.data
