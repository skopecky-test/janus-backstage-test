#!/bin/bash

FIRST="ghcr.io;GHCR_NAME;GITHUB_TOKEN"
SEC="linux/amd64,linux/arm64"

JSON="{\"platform\":"

JSON="$JSON"$(echo -n "$SEC" | jq -csR '. | split(",")')","

JSON="$JSON\"include\":["
IFS=',' read -ra SET <<< "$FIRST"

# CSV_SPLIT="$(echo -n "$1" | jq -csR '. | split(",")')"
#
for i in "${SET[@]}"; do
	IFS=';' read -ra LINE <<< "$i"
	JSON_LINE="{\"registry\": \"${LINE[0]}\", \"username\": \"${LINE[1]}\", \"password\": \"${LINE[2]}\"},"	
	JSON="$JSON$JSON_LINE"
done

if [[ $JSON == *, ]]; then
	JSON="${JSON%?}"
fi

JSON="$JSON]}"
echo $JSON
