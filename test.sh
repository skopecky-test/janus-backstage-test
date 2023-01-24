#!/bin/bash

TEST=$(echo linux/amd64,linux/arm64 | sed  -e 's/\//-/g')
TEST2=$(echo -n linux/amd64,linux/arm64 | jq -csR '. | split(",")')
TEST3=$(echo linux/amd64 | sed  -e 's/\//-/g')
echo $TEST
echo $TEST2
echo $TEST3
