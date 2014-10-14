# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# PostgreSQL 9.3.5 on CentOS 6.5.

# Test connection to PostgreSQL
library(RPostgreSQL)
db.drv <- PostgreSQL()
db.conn <- dbConnect(db.drv, host = "hostname",
                     port = 5432, dbname = "rdb",
                     user = "ruser",
                     password = "rpassword")
dbListTables(db.conn)

# Generate data
ntrans <- 1e5
ncust <- 1e4
nstore <- 100
sales <- data.frame(
    trans_id = seq_len(ntrans),
    cust_id = sample.int(ncust, ntrans, TRUE),
    store_id = sample.int(nstore, ntrans, TRUE))
dbWriteTable(db.conn, "sales", sales)
trans.lengths <- rpois(ntrans, 3) + 1L
trans.items <- data.frame(
    trans_id = rep.int(seq_len(ntrans), trans.lengths),
    item_id = unlist(lapply(trans.lengths, sample.int, n = 1000)),
    price = exp(rnorm(sum(trans.lengths))))
dbWriteTable(db.conn, "trans_items", trans.items)

# Total sales per store
library(microbenchmark)
microbenchmark({
    res <- dbGetQuery(
        db.conn,
        'SELECT store_id, price
         FROM sales INNER JOIN trans_items USING (trans_id);')
    res <- tapply(res$price, res$store_id, sum)
}, times = 10)
microbenchmark({
    res <- dbGetQuery(
        db.conn,
        'SELECT store_id, SUM(price) as total_sales
         FROM sales INNER JOIN trans_items USING (trans_id)
         GROUP BY store_id;')
}, times = 10)

# Top ten customers
microbenchmark({
    res <- dbGetQuery(
        db.conn,
        'SELECT cust_id, price
         FROM sales INNER JOIN trans_items USING (trans_id);')
    res <- tapply(res$price, res$cust_id, sum)
    res <- sort(res, decreasing = TRUE)
    res <- head(res, 10L)
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

# Disconnect
dbDisconnect(db.conn)