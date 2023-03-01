#!/bin/bash



PORT=$1

# PORT Running check
echo "> ${PORT} Running check"

  
RES_CODE=$(curl -o /dev/null -w "%{http_code}" "http://localhost:${PORT}")
echo "> response code is ${RES_CODE}"
  
if [ $RES_CODE -eq 200 ]; then
  echo "ok"
else 
  echo "-_-"
fi


