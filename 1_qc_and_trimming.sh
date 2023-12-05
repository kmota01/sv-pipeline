#!/bin/bash

source ./config.sh
source ./time.sh

if ! [ -d $work_dir/raw_reads ]; then
	mkdir $work_dir/raw_reads
	mv $work_dir/${sample}* $work_dir/raw_reads
fi
if ! [ -d $work_dir/trimmed_reads ]; then
	mkdir $work_dir/trimmed_reads
else
	rm -r $work_dir/trimmed_reads/*
fi
if ! [ -d $work_dir/quality_control ];then
	mkdir $work_dir/quality_control
	mkdir $work_dir/quality_control/raw_reads_qc
	mkdir $work_dir/quality_control/trimmed_reads_qc
else
	rm -r $work_dir/quality_control/raw_reads_qc/*
	rm -r $work_dir/quality_control/trimmed_reads_qc/*
fi

trimmomatic=$'/home/kmota01/apps/Trimmomatic-0.39/trimmomatic-0.39.jar'
OutputForwardPaired=$work_dir/trimmed_reads/${sample}_forward_paired.fastq.gz
OutputForwardUnpaired=$work_dir/trimmed_reads/${sample}_forward_unpaired.fastq.gz
OutputReversePaired=$work_dir/trimmed_reads/${sample}_reverse_paired.fastq.gz
OutputReverseUnpaired=$work_dir/trimmed_reads/${sample}_reverse_unpaired.fastq.gz

#Quality control is done BEFORE and AFTER trimming to validate the better quality of the data after trimming.

#step 1: quality control of raw reads with FASTQC
output_dir=$work_dir/quality_control/raw_reads_qc
file=qc_raw_reads
fx=$"fastqc $work_dir/raw_reads/*.fastq.gz -o $output_dir"
time_count "$fx" "$output_dir" "$file"

#step 2: combine multiple qc reports into one for better comparison with MULTIQC
multiqc $work_dir/quality_control/raw_reads_qc/*fastqc* -o $output_dir

#step 3: trim special sequences with Trimmomatic
output_dir=$work_dir/trimmed_reads
file=trim_reads
fx=$"java -jar $trimmomatic PE -threads 8 $work_dir/raw_reads/${sample}_1.fastq.gz $work_dir/raw_reads/${sample}_2.fastq.gz \
	$OutputForwardPaired $OutputForwardUnpaired $OutputReversePaired $OutputReverseUnpaired \
	ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"
	time_count "$fx" "$output_dir" "$file"

#step 4: quality control for trimmed reads
output_dir=$work_dir/quality_control/trimmed_reads_qc
file=qc_trim_reads
fx=$"fastqc $work_dir/trimmed_reads/*.fastq.gz -o $output_dir"
time_count "$fx" "$output_dir" "$file"

#step 5: combine multiple qc reports into one for better comparison
multiqc $work_dir/quality_control/trimmed_reads_qc/*fastqc* -o $work_dir/quality_control/trimmed_reads_qc

