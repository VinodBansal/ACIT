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
echo "**************************************************************" >>$log
echo "Deploy tomcat and Application" >>$log
echo "**************************************************************" >>$log
echo "Pull build artefact from S3 bucket (Artefactory) to Remote server >>$log
#aws s3 cp s3://acit-team1/Artifactory/webapp-runner.jar /home/app/
aws s3 cp s3://acit-team1/Artifactory/acit-web.war /home/
#java -jar /home/webapp-runner.jar /home/acit-web-app.war

echo "Deploy tomcat and application" >>$log

groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /opt/
wget http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.45/bin/apache-tomcat-8.5.45.tar.gz
tar -xzvf apache-tomcat-8.5.45.tar.gz
mv apache-tomcat-8.5.45/* tomcat/
chown -hR tomcat:tomcat tomcat

cat >/etc/systemd/system/tomcat.service <<EOL
[Unit]
Description=Apache Tomcat 8 Servlet Container
After=syslog.target network.target
[Service]
User=tomcat
Group=tomcat
Type=forking
Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOL

cp /home/acit-web.war /opt/tomcat/webapps/
chown -hR tomcat:tomcat tomcat
chown -hR tomcat:tomcat /opt/tomcat/webapps/acit-web.war
echo "start service"
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
systemctl status tomcat >>$log

