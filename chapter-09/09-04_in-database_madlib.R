# Tested on R 3.1.1 clients on Ubuntu 14.04 Trusty Tahr,
# Mac OS X 10.9 Mavericks, and Windows 8.1 connecting to
# MADlib 1.6 running in PostgreSQL 9.3.5 on CentOS 6.5.

library(RPostgreSQL)
db.drv <- PostgreSQL()
db.conn <- dbConnect(db.drv, host = "hostname",
                     port = 5432, dbname = "rdb",
                     user = "ruser",
                     password = "rpassword")

# Run association rules in MADlib
dbGetQuery(
    db.conn,
    "SELECT *
     FROM madlib.assoc_rules(
         0.001,         -- support
         0.01,          -- confidence
         'trans_id',    -- tid_col
         'item_id',     -- item_col
         'trans_items', -- input_table
         'public',      -- output_schema
         TRUE           -- verbose
     );")

# Retrieve results
dbGetQuery(db.conn, 'SELECT * FROM assoc_rules;')
