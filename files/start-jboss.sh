IP=`hostname -i`
echo $IP
export JAVA_OPTS="-Xms100m -Xmx1303m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true"
nohup /home/ec2-user/jboss-eap-7.4/bin/standalone.sh -c standalone-full-ha.xml -Djboss.bind.address=$IP -Djboss.bind.address.private=$IP -Djboss.bind.address.management=$IP &
