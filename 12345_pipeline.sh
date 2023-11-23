#!/bin/bash

source ./config.sh

script1=./1_qc_and_trimming.sh
script2=./2_align_and_sort.sh
script3=./3_discordant_and_splitters.sh
script4=./4_set_insert_size.sh
script5=./5_lumpy_run.sh

for proc in $script1 $script2 $script3 $script4 $script5;do
	bash $proc -i $sample -w $work_dir
done

