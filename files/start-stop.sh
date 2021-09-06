IP=`hostname -i`
export JAVA_OPTS="-Xms100m -Xmx1303m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true"
PID=`ps -ef| grep "/home/ec2-user/jboss-eap-7.4/standalone/"  | grep -v grep | awk '{print $2}'`
status(){
    if [ -z $PID ];
    then

                echo "No Pid file"
    else
        echo "Pid file: [$PID]"
    fi
}
start(){
    if [ -z $PID ];
    then
        nohup /home/ec2-user/jboss-eap-7.4/bin/standalone.sh -c standalone-full-ha.xml -Djboss.bind.address=$IP -Djboss.bind.address.private=$IP -Djboss.bind.address.management=$IP &
        echo "Started"
    else
        echo "Already running: [$PID]"
    fi
}
stop(){
    if [ -z $PID ];
    then
        echo " Already stopped "

    else
        echo " Stopping "
        /home/ec2-user/jboss-eap-7.4/bin/jboss-cli.sh --connect --controller=$IP:9990 --command=shutdown
        kill -9 $PID
    fi
}


case "$1" in
    'start')
            start
            ;;
    'stop')
            stop
            ;;
    'restart')
            stop ; echo "Sleeping..."; sleep 1 ;
            start
            ;;
    'status')
            status
            ;;
    *)
            echo
            echo "Usage: $0 { start | stop | restart | status }"
            echo
            exit 1
            ;;
esac

exit 0
