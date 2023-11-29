#!/bin/bash

source ./config.sh
. ./time.sh

input_dir=$work_dir/ref_map
output_dir=$work_dir/sv_call/lumpy

a=$(cat $output_dir/${sample}.histo.log | awk '{print $1}' | awk -F ':' '{print $2}')
mean=$(echo $a | awk '{printf "%d\n",$1}')
b=$(cat $output_dir/${sample}.histo.log | awk '{print $2}' | awk -F ':' '{print $2}')
stdev=$(echo $b | awk '{printf "%d\n",$1}')

#Start LUMPY
file=lumpy
fx=$"lumpy -mw 4 -tt 0 -pe id:$sample,bam_file:$input_dir/${sample}.discordants.bam,histo_file:$output_dir/${sample}.lib1.histo,mean:$mean,stdev:$stdev,read_length:101,min_non_overlap:101,discordant_z:5,back_distance:10,weight:1,min_mapping_threshold:20 -sr id:SLGFSK-N_231335,bam_file:$input_dir/${sample}.splitters.bam,back_distance:10,weight:1,min_mapping_threshold:20 > $output_dir/${sample}.vcf"
$(time_count "$fx" "$output_dir" "$file")
