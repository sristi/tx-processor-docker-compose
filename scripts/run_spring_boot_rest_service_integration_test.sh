#!/bin/bash
SERVER_URL="http://springbootrestcontainer:8080"
# Following block is for health-check of target server; because we do not have healthcheck facility in our docker version
while ! curl $SERVER_URL
do
  echo "$(date) - Trying to reconnect to REST server "$SERVER_URL'/'
  sleep 1
done
printf "$(date) - Connected successfully to "${SERVER_URL}"\n";
echo $PWD is current folder
for i in  ../test_data/*;do
if [ -f $i ] && [ ${i: -4} == ".csv" ]; then
    echo  "Processing CSV Transaction input file is :"$i &&  printf '\n Output from SPRING-BOOT transaction-processor REST server --->' &&
    curl -X POST $SERVER_URL'/'transaction-processor/process_csv_data/ -F "file=@"$i && printf " <--- was received for CSV input: ${i} \n";
elif [ -f $i ] && [ ${i: -4} == ".xml" ]; then
    echo "Processing XML Transaction input file is :"$i && printf '\n Output from SPRING-BOOT transaction-processor REST server --->'
    curl -X POST $SERVER_URL'/'transaction-processor/process_xml_data/ -F "file=@"$i && printf " <--- was received for XML input: ${i} \n";
fi
done
