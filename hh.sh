#!/bin/sh
mv /tmp/tomcat/apache-tomcat-7.0.56 /opt/tomcat
cp -r /tmp/zookeeper/zookeeper-3.4.6/* /opt/zookeeper
mv /tmp/solr/solr-4.10.1 /opt/solr_install
cp -r /opt/solr_install/example/solr/* /opt/solr_home
cp /opt/solr_install/dist/solr-*.war /opt/solr_home/war/solr.war
rm -rf /opt/solr_home/collection1
cp –r /opt/solr_install/example/lib/ext/* /opt/tomcat/lib/
cp /opt/solr_install/example/resources/log4j.properties /opt/tomcat/lib/
/opt/tomcat/bin/startup.sh
sleep 10s
/opt/tomcat/bin/shutdown.sh
mv /tmp/hhconfig/tc_solr.xml /opt/tomcat/conf/Catalina/localhost/solr.xml
mv /tmp/hhconfig/solr.xml /opt/solr_home/solr.xml
mv /tmp/hhconfig/startup.sh /opt/tomcat/bin/startup.sh
chmod 755 /opt/tomcat/bin/startup.sh
mv /tmp/hhconfig/zoo.cfg /opt/zookeeper/conf/zoo.cfg
/opt/tomcat/bin/startup.sh
rm -rf /tmp/zookeeper/zookeeper-3.4.6
/opt/zookeeper/bin/zkServer.sh start

