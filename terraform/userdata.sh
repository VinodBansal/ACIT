#!/bin/sh
set -x
# output log of userdata to /var/log/user-data.log
yum update
yum install java-1.8.0-openjdk -y
var=$(readlink -f $(which java))
export JAVA_HOME=$var

sudo yum install python3 -y
sudo yum upgrade python3
sudo yum install git-all
sudo yum intstall wget zip unzip
