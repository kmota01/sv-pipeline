#!/bin/bash

source ./config.sh
source ./time.sh

output_dir=$work_dir/ref_map
script_dir='/home/kmota01/apps/lumpy-sv/scripts'

#step 1: find discordant and split-reads (those files are used as input in Lumpy)
file=disc_and_splitters
fx=$"samtools view -b -F 1294 $output_dir/${sample}_sorted.bam > $output_dir/${sample}.discordants_unsorted.bam
samtools view -h $output_dir/${sample}.bam \
    | $script_dir/extractSplitReads_BwaMem -i stdin \
    | samtools view -Sb - \
    > $output_dir/${sample}.splitters_unsorted.bam"
    time_count "$fx" "$output_dir" "$file"

#step 2: coordinate sorting (by chromosome and position)
samtools sort $output_dir/${sample}.discordants_unsorted.bam -o $output_dir/${sample}.discordants.bam
samtools sort $output_dir/${sample}.splitters_unsorted.bam -o $output_dir/${sample}.splitters.bam


