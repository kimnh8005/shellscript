#!/bin/bash


ADMIN_HOME=/home/ec/domains/admin
SERVER1_HOME=/home/ec/domains/admin
SERVER2_HOME=/home/ec/domains/admin/server2

# Currnet Active Port Check

sh $ADMIN_HOME/deploy/script/idle_port_check.sh

PORT_CHECK_RESULT=$?

if [ $PORT_CHECK_RESULT -ne 0 ]
 then exit 1;
fi
 

SET=$(cat $ADMIN_HOME/deploy/script/idle_port | cut -d':' -f1)
PORT=$(cat $ADMIN_HOME/deploy/script/idle_port | cut -d':' -f2)



# WAR Copy

echo "> WAR Copy"
WAR_DIR_TEMP=/home/ec/domains/admin/deploy/target
WAR_FILE_NAME=EshopAdm.war

if [ $SET = 'set1' ]
  then echo ' > Copy to Server1 Directory'
  cp $WAR_DIR_TEMP/$WAR_FILE_NAME $SERVER1_HOME

  echo '> Server1 Restart'
  $ADMIN_HOME/stop1_gracefully.sh
  $ADMIN_HOME/startup1.sh


else
  echo ' > Copy to Server2 Directory'
  cp $WAR_DIR_TEMP/$WAR_FILE_NAME $SERVER2_HOME

  echo '> Server2 Restart'
  $ADMIN_HOME/stop2.sh
  $ADMIN_HOME/startup2.sh
fi



