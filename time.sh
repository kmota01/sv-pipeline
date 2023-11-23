#!/bin/bash

#set -x
. ./time_converter.sh

time_count() {

output=$2
fx=$1

start=$(date +%s)
eval "$fx"
end=$(date +%s)
converted_time=$(convert_seconds $((end-start)))
echo "RealTime:" $converted_time >> $output/runtime.error.log 2>&1
#> $output/runtime | chmod +x $output/runtime
}
