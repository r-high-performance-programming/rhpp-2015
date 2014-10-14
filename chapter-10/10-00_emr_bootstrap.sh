#!/bin/bash

# This script sets up required packages on all nodes of a Hadoop
# cluster. It was written to work on Amazon Web Services (AWS)
# Elastic MapReduce (EMR). If you are using another Hadoop
# environment, you may need to modify the script.
# Tested on Amazon Hadoop AMI version 3.2.1, which contains:
# - Amazon Linux 2014.03
# - Hadoop 2.4.0
# - Oracle Java jdk-7u65
# - R 3.0.2

# Set unix environment variables
cat << EOF >> $HADOOP_HOME/.bashrc
export HADOOP_CMD=$HADOOP_HOME/bin/hadoop
export HADOOP_STREAMING=$HADOOP_HOME/contrib/streaming/hadoop-streaming.jar
EOF
. $HADOOP_HOME/.bashrc

# Fix hadoop tmp permission
sudo chmod 777 -R /mnt/var/lib/hadoop/tmp

# Install dependencies
sudo yum install -y libcurl-devel

# Install R packages
sudo -E R CMD javareconf
sudo -E R --no-save << EOF
install.packages("R.utils", repos="http://cran.rstudio.com")
EOF

# Install HadoopR dependencies
sudo -E R --no-save << EOF
install.packages(
    c("bitops", "caTools", "digest", "functional", "plyr", "Rcpp",
      "reshape2", "rJava", "RJSONIO", "stringr"),
    repos="http://cran.rstudio.com")
EOF

# Install rhdfs package
wget https://raw.githubusercontent.com/RevolutionAnalytics/rhdfs/master/build/rhdfs_1.0.8.tar.gz
sudo -E R CMD INSTALL rhdfs_1.0.8.tar.gz

# Install rmr2 package
wget https://raw.githubusercontent.com/RevolutionAnalytics/rmr2/master/build/rmr2_3.2.0.tar.gz
sudo -E R CMD INSTALL rmr2_3.2.0.tar.gz
