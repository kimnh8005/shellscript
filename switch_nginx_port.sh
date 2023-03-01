#!/bin/bash



if [ $# -eq 0 ] ; then
 echo 'Warning: no arguments'
 echo 'Usage: switch_nginx_port.sh 12345'
 exit 0
fi

if [ $# -ne 1 ] ; then
 echo 'Usage: switch_nginx_port.sh 12345'
 exit 0
fi


PORT=$1

# PORT Running check
RES_CODE=$(curl -o /dev/null -w "%{http_code}" "http://localhost:${PORT}")
echo "> response code is ${RES_CODE}"

# Nginx Port Switching
if [ $RES_CODE -eq 200 ]; then
  echo "Switch Nginx Port: ${PORT}"
  echo "set \$service_url http://127.0.0.1:${PORT};" | sudo tee /etc/nginx/conf.d/service-url.inc
  echo "Reload Nginx"
  sudo service nginx reload
else
  echo "Warning: response code is ${RES_CODE}"
  exit 0
fi


