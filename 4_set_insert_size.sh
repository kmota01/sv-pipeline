#!/bin/bash

source ./config.sh
source ./time.sh

input_dir=$work_dir/ref_map
output_dir=$work_dir/sv_call/lumpy
script_dir='/home/kmota01/apps/lumpy-sv/scripts'

if [[ ! -e $work_dir/sv_call ]];then
        mkdir $work_dir/sv_call
        mkdir $output_dir
else
	rm $output_dir/*
fi

#step 1: Create a read insert-size distribution file (is used as input in LUMPY)
samtools view -r readgroup1 $input_dir/${sample}.bam | tail -n+100000 \
	| $script_dir/pairend_distro.py -r 101 -X 4 -N 10000 -o $output_dir/${sample}.lib1.histo \
	> $output_dir/${sample}.histo.log
mv $output_dir/${sample}.histo.log $output_dir/${sample}.lib1.histo


