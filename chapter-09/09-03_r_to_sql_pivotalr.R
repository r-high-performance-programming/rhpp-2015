# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# PostgreSQL 9.3.5 on CentOS 6.5.

# Connect to DB
library(PivotalR)
db.conn <- db.connect(host = "hostname", port = 5432,
                      dbname = "rdb", user = "ruser",
                      password = "rpassword")
sales.tb <- db.data.frame("sales", db.conn)
trans_items.tb <- db.data.frame("trans_items", db.conn)

# Some simple queries
dim(sales.tb)
names(sales.tb)
lookat(count(sales.tb$cust_id))
lookat(min(trans_items.tb$price))
lookat(max(trans_items.tb$price))
content(max(trans_items.tb$price))

# Deriving new variables on the fly
trans_items.tb$foreign_price <- trans_items.tb$price * 1.25
content(trans_items.tb)

# Spending by customer
trans <- by(trans_items.tb["price"], trans_items.tb$trans_id, sum)
sales.value <- merge(sales.tb[c("trans_id", "cust_id",
                                "store_id")],
                     trans, by = "trans_id")
cust.sales <- by(sales.value, sales.value$cust_id,
                 function(x) {
                     trans_count <- count(x$trans_id)
                     total_spend <- sum(x$price_sum)
                     stores_visited <- count(x$store_id)
                     cbind(trans_count, total_spend,
                           stores_visited)
                 })
names(cust.sales) <- c("cust_id", "trans_count", "total_spend",
                       "stores_visited")
lookat(cust.sales, 5)

# Store results in new table
cust_sales.tb <- as.db.data.frame(cust.sales, "cust_sales")

# Compute more statistics
lookat(min(cust_sales.tb$total_spend))
lookat(max(cust_sales.tb$total_spend))
lookat(mean(cust_sales.tb$total_spend))
lookat(sd(cust_sales.tb$total_spend))

# Delete derived table
delete(cust_sales.tb)
