#!/bin/bash

#SBATCH --job-name=lumpy-test
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=output.%j.lumpy-test

#### SLURM 1 processor LUMPY test to run for 1 hours.

source ./config.sh

#work_dir=/home/kmota01/test_align
#sample=SLGFSK-N_231335

a=$(cat $work_dir/sv_call/lumpy/${sample}.histo.log | awk '{print $1}' | awk -F ':' '{print $2}')
mean=$(echo $a | awk '{printf "%d\n",$1}')
b=$(cat $work_dir/sv_call/lumpy/${sample}.histo.log | awk '{print $2}' | awk -F ':' '{print $2}')
stdev=$(echo $b | awk '{printf "%d\n",$1}')

#Start LUMPY
lumpy -mw 4 -tt 0 -pe id:SLGFSK-N_231335,bam_file:$work_dir/ref_map/${sample}.discordants.bam,histo_file:$work_dir/sv_call/lumpy/${sample}.lib1.histo,mean:$mean,stdev:$stdev,read_length:101,min_non_overlap:101,discordant_z:5,back_distance:10,weight:1,min_mapping_threshold:20 -sr id:SLGFSK-N_231335,bam_file:$work_dir/ref_map/${sample}.splitters.bam,back_distance:10,weight:1,min_mapping_threshold:20 > $work_dir/sv_call/lumpy/${sample}.vcf \
	2> $work_dir/sv_call/lumpy/${sample}.sv.log
