#!/bin/bash


source ./config.sh
. ./time.sh

output_dir=$work_dir/ref_map

if [[ ! -e $output_dir ]];then
        mkdir $output_dir
else
        rm -r $output_dir/*
fi

picard=$'/home/kmota01/apps/picard/picard.jar'
ref=/home/kmota01/h38/hg38.fa
forward_reads=$work_dir/trimmed_reads/*forward*_paired.fastq.gz
reverse_reads=$work_dir/trimmed_reads/*reverse*_paired.fastq.gz

#step 1: Mapping pair-end reads to reference genome
file=map_to_ref
fx="$(bwa mem -t 10 $ref $forward_reads $reverse_reads | samtools view -Shb -o $output_dir/${sample}_withDups.bam -)"
$(time_count "$fx" "$output_dir" "$file")

#step 2: Sorting alignment file by queryname
file=sort_queryname
fx=$"java -jar $picard SortSam -I $output_dir/${sample}_withDups.bam -O $output_dir/${sample}_withDups_sorted.bam -SO queryname"
$(time_count "$fx" "$output_dir" "$file")

#step 3: Mark duplicates arising from PCR-amplification or library artifacts
file=mark_dup
fx=$"java -jar $picard MarkDuplicates -INPUT $output_dir/${sample}_withDups_sorted.bam -OUTPUT $output_dir/${sample}_sorted.bam -METRICS_FILE $output_dir/deduplicated_metrics.txt"
$(time_count "$fx" "$output_dir" "$file")

#step 4: Sorting alignment file by coordinateis necessary for performing SV analysis with LUMPY
file=sort_coord
fx=$"samtools sort $output_dir/${sample}_sorted.bam -o $output_dir/${sample}.bam"
$(time_count "$fx" "$output_dir" "$file")

#step 5: Indexing alignment file
file=index
fx=$"samtools index $output_dir/${sample}.bam" 
$(time_count "$fx" "$output_dir" "$file")

#step 6: Create a file with statistics about the alignment flags
echo "sample:" ${sample} > $output_dir/stats.txt | samtools flagstats $output_dir/${sample}.bam >> $output_dir/stats.txt

