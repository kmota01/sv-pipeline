#!/bin/bash

source ./config.sh

#work_dir=/home/kmota01/test_align
#sample=SRR23693880

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
	rm -r $work_dir/quality_control/*
	mkdir $work_dir/quality_control
	mkdir $work_dir/quality_control/raw_reads_qc
	mkdir $work_dir/quality_control/trimmed_reads_qc
fi

trimmomatic=$'/home/kmota01/apps/Trimmomatic-0.39/trimmomatic-0.39.jar'
OutputForwardPaired=$work_dir/trimmed_reads/${sample}_forward_paired.fastq.gz
OutputForwardUnpaired=$work_dir/trimmed_reads/${sample}_forward_unpaired.fastq.gz
OutputReversePaired=$work_dir/trimmed_reads/${sample}_reverse_paired.fastq.gz
OutputReverseUnpaired=$work_dir/trimmed_reads/${sample}_reverse_unpaired.fastq.gz


#Quality control is done BEFORE and AFTER trimming to validate the better quality of the data after trimming.

#step 1: quality control of raw reads
fastqc $work_dir/raw_reads/*.fastq.gz -o $work_dir/quality_control/raw_reads_qc

#step 2: combine multiple qc reports into one for better comparison
multiqc $work_dir/quality_control/raw_reads_qc/*fastqc* -o $work_dir/quality_control/raw_reads_qc

#step 3: trim special sequences (low sensitivity) 
java -jar $trimmomatic PE -threads 8 $work_dir/raw_reads/${sample}_1.fastq.gz $work_dir/raw_reads/${sample}_2.fastq.gz \
	$OutputForwardPaired $OutputForwardUnpaired $OutputReversePaired $OutputReverseUnpaired \
	ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#step 4: quality control for trimmed reads
fastqc $work_dir/trimmed_reads/*.fastq.gz -o $work_dir/quality_control/trimmed_reads_qc

#step 5: combine multiple qc reports into one for better comparison
multiqc $work_dir/quality_control/trimmed_reads_qc/*fastqc* -o $work_dir/quality_control/trimmed_reads_qc

