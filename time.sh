#!/bin/bash

#This module keeps track of execution and completion date, and total runtime of a script.

#set -x   #for debugging

. ./time_converter.sh

time_count() {

fx=$1
output=$2
file=$3


ExecutionDate=$(date)
start=$(date +%s)

eval "$fx" 2>&1 | tee $output/${file}.error.log 

CompletionDate=$(date)
end=$(date +%s)
converted_time=$(convert_seconds $((end-start)))

(echo && echo "Execution Date:" $ExecutionDate) >> $output/${file}.error.log
echo "Completion Date:" $CompletionDate >> $output/${file}.error.log
echo "RealTime:" $converted_time >> $output/${file}.error.log

}
