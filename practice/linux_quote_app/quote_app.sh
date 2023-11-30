#!/bin/bash

api_key=$1
psql_host=$2
psql_port=$3
db_name=$4
psql_user=$5
psql_password=$6
sym=$7

if [ "$#" -lt 6 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

quotes=$(curl --request GET \
         	--url "https://alpha-vantage.p.rapidapi.com/query?function=${api_key}&symbol=${sym}&datatype=json" \
         	--header 'X-RapidAPI-Host: alpha-vantage.p.rapidapi.com' \
         	--header 'X-RapidAPI-Key: ab7a150ce3msh40cfd162992b838p18d17cjsne209e96b9b18' | jq '."Global Quote"' )

symbol=$(echo "$quotes" | jq '."01. symbol"' | xargs)
open=$(echo "$quotes" | jq '."02. open"' | xargs)
high=$(echo "$quotes" | jq '."03. high"' | xargs)
low=$(echo "$quotes" | jq '."04. low"' | xargs)
price=$(echo "$quotes" | jq '."05. price"' | xargs)
volume=$(echo "$quotes" | jq '."06. volume"' | xargs)

insert_stmt="INSERT INTO quotes(symbol, open, high, low, price, volume)
VALUES('$symbol', '$open', '$high', '$low', '$price', '$volume');"

export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?