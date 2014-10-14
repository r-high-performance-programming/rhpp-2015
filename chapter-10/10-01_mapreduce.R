# Tested on Amazon Hadoop AMI version 3.2.1, which contains:
# - Amazon Linux 2014.03
# - Hadoop 2.4.0
# - Oracle Java jdk-7u65
# - R 3.0.2

library(rhdfs)
library(R.utils)

# Download Google Books Ngrams data and upload it to HDFS
hdfs.init()
hdfs.mkdir("/ngrams/data")
files <- paste0("googlebooks-eng-all-1gram-20120701-", letters)
for (f in files) {
    gzfile <- paste0(f, ".gz")
    url <- paste0("http://storage.googleapis.com/",
                  "books/ngrams/books/",
                  gzfile)
    download.file(url, destfile = gzfile)
    gunzip(gzfile)
    hdfs.put(f, paste0("/ngrams/data/", f))
    file.remove(f)
}

# Check that files have been uploaded
hdfs.ls(“/ngrams/data”)

# Batman vs Superman
input.format <- make.input.format(
    format = "csv", sep = "\t",
    col.names = c("ngram", "year", "occurrences", "books"),
    colClasses = c("character", "integer", "integer", "integer"))
# Define mapper and reducer
mapper <- function(keys, values) {
    values$ngram <- tolower(values$ngram)
    superheroes <- values$ngram %in% c("batman", "superman") &
        values$year >= 1950L
    if (any(superheroes)) {
        keyval(values$ngram[superheroes],
               values[superheroes, c("year", "occurrences")])
    }
}
reducer <- function(key, values) {
    val <- tapply(values$occurrences, values$year, sum)
    val <- data.frame(year = as.integer(names(val)),
                      occurrences = val)
    keyval(key, val)
}
# Run job
job <- mapreduce(input = "/ngrams/data",
                 input.format = input.format,
                 output = "/ngrams/batmanVsuperman",
                 map = mapper, reduce = reducer)
# Get results
results <- from.dfs(job)
batman <- results$val[results$key == "batman", ]
head(batman)
superman <- results$val[results$key == "superman", ]
head(superman)
