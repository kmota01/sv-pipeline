#!/bin/bash

source ./config.sh

software=${software,,}

script1=./1_qc_and_trimming.sh
script2=./2_align_and_sort.sh
script3=./3_discordant_and_splitters.sh
script4=./4_set_insert_size.sh
script5=./5_lumpy_run.sh
script6=./6_manta_run.sh

if [[ ! -e $work_dir/ref_map/${sample}.bam ]]; then
	for proc in $script1 $script2;do
        	bash $proc -i $sample -w $work_dir
        done
else
        if [ $software == 'lumpy' ]; then
            for proc in $script3 $script4 $script5; do
        	bash $proc -i $sample -w $work_dir
            done
        elif [ $software == 'manta' ]; then
            for proc in $script6; do
        	bash $proc -i $sample -w $work_dir
            done
        fi
fi
