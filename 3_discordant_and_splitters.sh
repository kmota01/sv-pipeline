#!/bin/bash

source ./config.sh

#work_dir=/home/kmota01/test_align
#sample=SRR23693880

script_dir='/home/kmota01/apps/lumpy-sv/scripts'

#step 1: find discordant and split-reads
samtools view -b -F 1294 $work_dir/ref_map/${sample}_sorted.bam > $work_dir/ref_map/${sample}.discordants_unsorted.bam
samtools view -h $work_dir/ref_map/${sample}.bam \
    | $script_dir/extractSplitReads_BwaMem -i stdin \
    | samtools view -Sb - \
    > $work_dir/ref_map/${sample}.splitters_unsorted.bam

#step 2: coordinate sorting (by chromosome and position)
samtools sort $work_dir/ref_map/${sample}.discordants_unsorted.bam -o $work_dir/ref_map/${sample}.discordants.bam
samtools sort $work_dir/ref_map/${sample}.splitters_unsorted.bam -o $work_dir/ref_map/${sample}.splitters.bam
