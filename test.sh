#!/bin/bash

TEST=$(echo linux/amd64,linux/arm64 | sed  -e 's/,/ /g' -e 's/\//-/g')
echo $TEST
