#!/bin/sh
mv /tmp/tomcat/apache-tomcat-7.0.56 /opt/tomcat
mv /tmp/zookeeper/zookeeper-3.4.6 /opt/zookeepermv /tmp/solr/solr-4.10.1 /opt/solr_install
cp -r /opt/solr_install/example/solr/* /opt/solr_home
cp /opt/solr_install/dist/solr-*.war /opt/solr_home/war/solr.war
rm -rf /opt/solr_home/collection1
cp –r /opt/solr_install/example/lib/ext/* /opt/tomcat/lib/
cp –r /opt/solr_install/example/resources/log4j.properties /opt/tomcat/lib/
/opt/tomcat/bin/startup.sh
sleep 10s
/opt/tomcat/bin/shutdown.sh
mv /tmp/hhconfig/solr.xml /opt/tomcat/conf/Catalina/localhost/solr.xml
/opt/tomcat/bin/startup.sh
