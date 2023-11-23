#!/bin/bash

source ./config.sh

#work_dir=/home/kmota01/test_align
#sample=SRR23693880

#if [[ ! -e $work_dir/ref_map ]];then
#	mkdir $work_dir/ref_map
#else
#	rm -r $work_dir/ref_map/*
#fi

picard=$'/home/kmota01/apps/picard/picard.jar'
ref=/home/kmota01/h38/hg38.fa
forward_reads=$work_dir/trimmed_reads/*forward*_paired.fastq.gz
reverse_reads=$work_dir/trimmed_reads/*reverse*_paired.fastq.gz


##step 1: Mapping pair-end reads to reference genome 
#bwa mem -t 10 $ref $forward_reads $reverse_reads | samtools view -Shb -o $work_dir/ref_map/${sample}_withDups.bam -
##step 2: Sorting alignment file by coordinate(is necessary for performing SV analysis with LUMPY)
#samtools sort $work_dir/ref_map/${sample}_withDups.bam -o $work_dir/ref_map/${sample}.bam
##step 3: Exclude duplicates arising from PCR-amplification or library artifacts
#java -jar $picard MarkDuplicates -INPUT $work_dir/ref_map/${sample}.bam -OUTPUT $work_dir/ref_map/${sample}_sorted.bam -METRICS_FILE $work_dir/ref_map/deduplicated_metrics.txt
##step 4: Create a metrics file 
#java -jar $picard CollectDuplicateMetrics -INPUT $work_dir/ref_map/${sample}_sorted.bam -METRICS_FILE $work_dir/ref_map/${sample}_deduplicated_metrics.txt
##step 5: Create an file providing statistics about the alignment flags
#echo "sample:" ${sample} > $work_dir/ref_map/stats.txt | samtools flagstats $work_dir/ref_map/${sample}_sorted.bam >> $work_dir/ref_map/stats.txt
#step 6: Indexing alignment file
samtools index $work_dir/ref_map/${sample}_sorted.bam

