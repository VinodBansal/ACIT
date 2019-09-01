#!/bin/bash
# output log of userdata to /var/log/user-data.log
log=/home/boot_log.txt
sudo yum install java-1.8.0-openjdk -y >>$log
var=$(readlink -f $(which java) | sed "s:/bin/java::")
export JAVA_HOME=$var
sudo yum install python3 -y >>$log
sudo rpm -ivh https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm >>$log
sudo yum install puppet -y >>$log
sudo yum install wget -y >>$log
sudo yum install zip -y >>$log
sudo yum install git-all -y >>$log
