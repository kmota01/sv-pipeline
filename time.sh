#!/bin/bash

#set -x

. ./time_converter.sh

time_count() {

fx=$1
output=$2
file=$3

echo "Execution Date:" $(date) && echo >> $output/${file}.error.log 
start=$(date +%s)
eval "$fx" >> $output/${file}.error.log 2>&1
echo "Completion Date:" $(date) && echo >> $output/${file}.error.log
end=$(date +%s)
converted_time=$(convert_seconds $((end-start)))
echo "RealTime:" $converted_time >> $output/${file}.error.log 2>&1

}
