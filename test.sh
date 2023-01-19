#!/bin/bash

FIRST="ghcr.io;GHCR_NAME;GITHUB_TOKEN,quay.io;QUAY_NAME;QUAY_PASSWORD"
SEC="linux/amd64,linux/arm64"

JSON="\"registry\":["
IFS=',' read -ra SET <<< "$FIRST"

for i in "${SET[@]}"; do
	IFS=';' read -ra LINE <<< "$i"
	JSON_LINE="\"${LINE[0]}\","
	JSON="$JSON$JSON_LINE"
done

JSON="${JSON%?}],\"include\":["

IFS=',' read -ra SET <<< "$FIRST"

for i in "${SET[@]}"; do
	IFS=';' read -ra LINE <<< "$i"
	JSON_LINE="{\"registry\": \"${LINE[0]}\", \"username\": \"${LINE[1]}\", \"password\": \"${LINE[2]}\"},"	
	JSON="$JSON$JSON_LINE"
done

JSON="${JSON%?}]}"

TWO_JSON="{$JSON"
echo $TWO_JSON

JSON="{\"platform\":$(echo -n "$SEC" | jq -csR '. | split(",")'),$JSON"

echo $JSON
