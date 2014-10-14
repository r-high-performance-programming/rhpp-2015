# Install libpq (for RPostgreSQL)
# On Mac OS X (using Homebrew)
# $ brew install postgresql
# On Debian / Ubuntu
# $ sudo apt-get install libpq-dev
# On Redhat / CentOS
# $ sudo yum install postgresql-devel
# On Windows: This step is not needed

# RPostgreSQL
# On platforms other than Windows
install.packages("RPostgreSQL", type="source")
# On Windows
install.packages("RPostgreSQL")

install.packages(c("dplyr", "PivotalR", "MonetDB.R", "scidb"))