#!/bin/sh
mv /tmp/tomcat/apache-tomcat-7.0.56 /opt/tomcat
cp -r /tmp/zookeeper/zookeeper-3.4.6/* /opt/zookeeper
mv /tmp/solr/solr-4.10.1 /opt/solr_install
cp -r /opt/solr_install/example/solr/* /opt/solr_home
cp /opt/solr_install/dist/solr-*.war /opt/solr_home/war/solr.war
#rm -rf /opt/solr_home/collection1
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

SOLR1=$(head -1 /opt/zookeeper/tmp/myid)
if [ "$SOLR1" == 1 ]; then
#sleep 10s
sed -i s/8983/8080/ /opt/solr_install/example/exampledocs/post.sh
/opt/solr_install/example/scripts/cloud-scripts/zkcli.sh -zkhost 172.31.3.111:2181,172.31.3.112:2181,172.31.3.113:2181 -cmd upconfig -confdir /opt/solr_install/example/solr/collection1/conf -confname myconfig
sleep 20s
curl 'http://localhost:8080/solr/admin/collections?action=CREATE&name=collection1&numShards=3&replicationFactor=3&collection.configName=myconfig&maxShardsPerNode=3'
sleep 20s
/opt/solr_install/example/scripts/cloud-scripts/zkcli.sh -zkhost 172.31.3.111:2181,172.31.3.112:2181,172.31.3.113:2181 -cmd upconfig -confdir /opt/solr_install/example/solr/collection1/conf -confname myconfig
sleep 20s
#chmod 755 /opt/solr_install/example/exampledocs/post.sh
/opt/solr_install/example/exampledocs/post.sh /opt/solr_install/example/exampledocs/*.xml
fi
