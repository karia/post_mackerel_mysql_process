#/bin/bash

while true
  do
  COUNT_USER=`mysql -u root -pHOGE -e "show processlist" | grep "USERNAME" | wc -l`
  COUNT_LOCKED=`mysql -u root -pHOGE -e "show processlist" | grep "USERNAME" | grep "Waiting for table level lock" | wc -l`

  # echo $COUNT_USER
  # echo $COUNT_LOCKED

  curl https://mackerel.io/api/v0/services/SERVICENAME/tsdb -H 'X-Api-Key: APIKEY' -H 'Content-Type: application/json' -X POST -d '[{"name": "MySQL.USERNAME.all", "time": '$(date +%s)', "value": '${COUNT_USER}'}, {"name": "MySQL.USERNAME.locked", "time": '$(date +%s)', "value": '${COUNT_LOCKED}'}]'
  sleep 5
done

