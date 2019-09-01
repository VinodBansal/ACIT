#!/bin/bash
# output log of userdata to /var/log/user-data.log
log=/home/boot_log.txt
yum update
echo yum install java-1.8.0-openjdk -y >>$log
var=$(readlink -f $(which java))
export JAVA_HOME=$var
sudo yum install python3 -y >>$log
sudo rpm -ivh https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm >>$log
sudo yum install puppet >>$log
sudo yum install wget >>$log
sudo yum install zip >>$log
sudo yum install git-all >>$log
