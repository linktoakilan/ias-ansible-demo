IP=`hostname -i`
export JAVA_OPTS="-Xms100m -Xmx1303m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true"
/home/ec2-user/jboss-eap-7.4/bin/jboss-cli.sh --connect --controller=$IP:9990 --command=shutdown
