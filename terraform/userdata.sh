#!/bin/bash
# output log of userdata to /var/log/user-data.log
cd /home/
log=/home/boot_log.txt
echo "Install Java " >>$log
sudo yum install java-1.8.0-openjdk -y 
echo "java is installed" >>$log
echo "Set Java env variables" >>$log
var=$(readlink -f $(which java) | sed "s:/bin/java::")
cat >>/etc/environment <<EOL
export JAVA_HOME=$var
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/opt/puppetlabs/puppet/bin:$PATH
export PATH=/usr/bin/aws/bin:$PATH
EOL
source /etc/environment
echo "install Python3" >>$log
sudo yum install python3 -y
sudo alternatives --set python /usr/bin/python3
echo "Python is installed" >>$log
echo "install puppet" >>$log
sudo rpm -ivh https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm 
sudo yum install puppet -y
source /etc/environment
echo "Puppet is installed" >>$log
echo "install wget, zip and git" >>$log
sudo yum install wget -y
sudo yum install zip -y
sudo yum install git-all -y
echo "wget,zip and git are installed" >>$log
echo "install awscli tool" >>$log
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/bin/aws -b /usr/bin/aws
source /etc/environment
echo "awscli is installed" >>$log
