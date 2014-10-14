# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# MonetDB Jan 2014-SP3 on CentOS 6.5.

# Connect to database and load data
library(MonetDB.R)
db.drv <- MonetDB.R()
db.conn <- dbConnect(db.drv, host = "hostname",
                     port = 50000, dbname = "rdb",
                     user = "ruser",
                     password = "rpassword")
dbWriteTable(db.conn, "sales", sales)
dbWriteTable(db.conn, "trans_items", trans.items)

# Benchmark performance
library(microbenchmark)
microbenchmark({
    res <- dbGetQuery(
        db.conn,
        'SELECT store_id, SUM(price) as total_sales
         FROM sales INNER JOIN trans_items USING (trans_id)
         GROUP BY store_id;')
}, times = 10)
microbenchmark({
    res <- dbGetQuery(
        db.conn,
        'SELECT cust_id, SUM(price) as spending
         FROM sales INNER JOIN trans_items USING (trans_id)
         GROUP BY cust_id
         ORDER BY spending DESC
         LIMIT 10;')
}, times = 10)
