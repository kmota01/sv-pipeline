# SV-PIPELINE

Description:

123456_pipeline is a workflow of short-read sequencing-data preprocessing and analysis for Structural Variant(SV) detection. It executes 6 minor scripts for the steps of: Quality Control, Trimming, Mapping to reference genome, Mark & Remove Duplicates, Sort and Index, Discordant and Split-read identification, and SV detection with Lumpy or Manta.

*To execute the pipeline you simply need to create a working directory including your sequencing data (fastq.gz), and the corresponding library to your sequencing-technology. You can execute the pipeline from any directory as long as you define a working path for the analysis.

Execute:
$ bash 123456_pipeline.sh -i sample_name -w work_dir -s software


work_dir: working directory for the SV analysis

sample_name: name of the sequencing data, not including the '_1.fastq.gz' or '_2.fastq.gz' suffix. (If the sequencing data are SR2356_1.fastq.gz and SR2356_2.fastq.gz then sample_name=SR2356)

software: SV analysis software of your choice (lumpy or manta)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SOFTWARE REQUIREMENTS PER SCRIPT

script1:

fastqc: FastQC v0.11.9
multiqc: multiqc, version 1.18
trimmomatic: Trimmomatic-0.39


script2:

bwa: bwa-0.7.17-r1188
picard: picard-3.1.0
samtools: samtools 1.10


script5:

lumpy: lumpy-sv (https://github.com/arq5x/lumpy-sv)


script6:

manta: manta-1.6.0 (https://github.com/Illumina/manta/releases)


