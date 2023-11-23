#!/bin/bash

source ./config.sh

start_time=$(date +%s)

#work__dir=/home/kmota01/test_align
#sample=SRR23693880

script_dir='/home/kmota01/apps/lumpy-sv/scripts'

if [[ ! -e $work_dir/sv_call ]];then
        mkdir $work_dir/sv_call
        mkdir $work_dir/sv_call/lumpy
else
        rm -r  $work_dir/sv_call/lumpy/*
fi

#step 1: Create a read insert-size distribution file (is used as input in LUMPY)
samtools view -r readgroup1 $work_dir/ref_map/${sample}_sorted.bam \
	| tail -n+100000 \
	| $script_dir/pairend_distro.py \
	-r 101 \
	-X 4 \
	-N 10000 \
	-o $work_dir/sv_call/lumpy/${sample}.lib1.histo \
	> $work_dir/sv_call/lumpy/${sample}.histo.log

end_time=$(date +%s)

runtime=$((end_time-start_time))
echo $runtime
