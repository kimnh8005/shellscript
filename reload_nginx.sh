#!/bin/bash


ADMIN_HOME=/home/ec/domains/admin

# IDLE_PORT
SET=$(cat $ADMIN_HOME/deploy/script/idle_port | cut -d':' -f1)
PORT=$(cat $ADMIN_HOME/deploy/script/idle_port | cut -d':' -f2)


# IDLE_PORT Running check

echo ">IDLE_PORT:${PORT} Running check"

sleep 30;

while [ true ]; do

  RES_CODE=$(curl -o /dev/null -w "%{http_code}" "http://localhost:${PORT}")
  echo " > RES_CODE: ${RES_CODE}"

  if [ $RES_CODE -eq 200 ]; then
    break;
  else 
    echo " > Waiting..."
    sleep 5
  fi

done


# Nginx Port Switching
echo "> Nginx Port Switching"
echo "> Port: ${PORT}"
echo "set \$service_url http://127.0.0.1:${PORT};" | tee /home/ec/domains/admin/deploy/script/service-url.inc


# Nginx Reload
echo "> Nginx Reload"
sudo service nginx reload

