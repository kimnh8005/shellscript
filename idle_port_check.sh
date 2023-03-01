#!/bin/bash


ADMIN_HOME=/home/ec/domains/admin
MAX_INSTANCE_CNT=2

# Currnet Active Port Check
echo "> Idle Port Check" 
INSTANCE_CNT=$(ps -ef | grep java | grep -i admin/server | grep Dserver.set=set |  wc -l)
SERVER1_CNT=$(ps -ef  | grep java | grep -i admin/server1 | wc -l)

if [ $INSTANCE_CNT == 0 ] 
  then echo " > BOS Instance is nothing.."
  echo "IDEL_SET: set1"
  echo "IDLE_PORT: 16081"
  IDLE_SET=set1
  IDLE_PORT=16081
elif [ $INSTANCE_CNT -gt $MAX_INSTANCE_CNT ]
  then echo " > Too Many BOS Instances.."
  echo " > Instance Cnt: $INSTANCE_CNT"
  
  exit 1;
else
 SERVER1_PORT_CNT=$(cat /home/ec/domains/admin/deploy/script/service-url.inc | grep 16081 | wc -l)
 if [ $SERVER1_PORT_CNT == 1 ]
   then echo " > BOS Server1 is running.."
   echo " > IDEL_SET: set2"
   echo " > IDLE_PORT: 16082"
   IDLE_SET=set2
   IDLE_PORT=16082
 else
   echo " > BOS Server2 is running.."
   echo " > IDEL_SET: set1"
   echo " > IDLE_PORT: 16081"
   IDLE_SET=set1
   IDLE_PORT=16081
 fi
fi

echo "$IDLE_SET:$IDLE_PORT" > $ADMIN_HOME/deploy/script/idle_port
