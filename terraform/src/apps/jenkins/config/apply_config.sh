mkdir -p /usr/share/jenkins/ref/secrets/;
echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch;
yes n | cp -i /var/jenkins_config/config.xml /var/jenkins_home;
yes n | cp -i /var/jenkins_config/jenkins.CLI.xml /var/jenkins_home;
yes n | cp -i /var/jenkins_config/jenkins.model.JenkinsLocationConfiguration.xml /var/jenkins_home;
# Install missing plugins
cp /var/jenkins_config/plugins.txt /var/jenkins_home;
rm -rf /usr/share/jenkins/ref/plugins/*.lock
/usr/local/bin/install-plugins.sh `echo $(cat /var/jenkins_home/plugins.txt)`;
# Copy plugins to shared volume
yes n | cp -i /usr/share/jenkins/ref/plugins/* /var/jenkins_plugins/;