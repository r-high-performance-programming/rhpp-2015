# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# PostgreSQL 9.3.5 on CentOS 6.5.

# Connect to DB
library(dplyr)
db.conn <- src_postgres(dbname = "rdb", host = "hostname",
                        port = 5432, user = "ruser",
                        password = "rpassword")
sales.tb <- tbl(db.conn, "sales")
trans_items.tb <- tbl(db.conn, "trans_items")

# Top ten customers
joined.tb <- inner_join(sales.tb, trans_items.tb, by = "trans_id")
cust.items <- group_by(joined.tb, cust_id)
cust.spending <- summarize(cust.items, spending = sum(price))
cust.spending <- arrange(cust.spending, desc(spending))
cust.spending <- select(cust.spending, cust_id, spending)
class(cust.spending)
cust.spending$query
custs.by.spending <- collect(cust.spending)
top.custs <- head(cust.spending, 10L)

# Chain syntax
top.custs <-
    sales.tb %>% inner_join(trans_items.tb, by = "trans_id") %>%
    group_by(cust_id) %>%
    summarize(spending = sum(price)) %>%
    arrange(desc(spending)) %>%
    select(cust_id, spending) %>%
    head(10L)
