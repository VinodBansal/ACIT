#!/bin/bash
# output log of userdata to /var/log/user-data.log
cd /home/
log=/home/boot_log.txt
echo "Install Java /n"
sudo yum install java-1.8.0-openjdk -y >>$log
echo "Set Java env variables /n"
var=$(readlink -f $(which java) | sed "s:/bin/java::")
cat >>/etc/environment <<EOL
export JAVA_HOME=$var
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/opt/puppetlabs/puppet/bin:$PATH
EOL
source /etc/environment
echo "install Python3"
sudo yum install python3 -y >>$log
echo "install puppet"
sudo rpm -ivh https://yum.puppetlabs.com/puppet-release-el-8.noarch.rpm >>$log
sudo yum install puppet -y >>$log
echo "install wget, zip and git"
sudo yum install wget -y >>$log
sudo yum install zip -y >>$log
sudo yum install git-all -y >>$log
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" >>$log
unzip awscli-bundle.zip >>$log
sudo ./awscli-bundle/install -i /usr/bin/aws -b /usr/bin/aws >>$log
echo "**************************************************************"
echo "Deploy tomcat and Application"
/usr/local/bin/aws s3 cp s3://acit-team1/Artifactory/webapp-runner.jar /home/app/
/usr/local/bin/aws s3 cp s3://acit-team1/Artifactory/java-tomcat-maven-example.war /home/app/
java -jar /opt/app/webapp-runner.jar /opt/app/*.war >>$log

