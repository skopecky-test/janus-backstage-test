#!/bin/bash

csv_to_json () {
	echo $(echo -n "$1" | jq -csR '. | split(",")')
}

FIRST="ghcr.io,quay.io"
SEC="linux/amd64,linux/arm64"
USERNAME="GHCR_NAME,QUAY_NAME"
PASSWORD="GITHUB_TOKEN,QUAY_PASSWORD"

JSON="\"registry\":$(csv_to_json $FIRST),"
JSON="${JSON%?},\"include\":["

IFS=',' read -ra USERNAMES <<< "$USERNAME"
IFS=',' read -ra PASSWORDS <<< "$PASSWORD"
IFS=',' read -ra REGISTRIES <<< "$FIRST"

for i in "${!USERNAMES[@]}"; do 
	JSON_LINE="{\"registry\": \"${REGISTRIES[$i]}\", \"username\": \"${USERNAMES[$i]}\", \"password\": \"${PASSWORDS[$i]}\"},"	
	JSON="$JSON$JSON_LINE"
done

JSON="${JSON%?}]}"

TWO_JSON="{$JSON"
echo $TWO_JSON

JSON="{\"platform\":$(csv_to_json $SEC),$JSON"

echo $JSON
