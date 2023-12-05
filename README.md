# SV-PIPELINE

Description:

123456_pipeline is a workflow of short-read sequencing-data preprocessing and analysis for Structural Variant(SV) detection. It executes 5 minor scripts for the steps of: Quality Control, Trimming, Mapping to reference genome, Mark & Remove Duplicates, Sort and Index, Discordant and Split-read identification, and SV detection with Lumpy or Manta.

*To execute the pipeline you simply need to create a working directory including your sequencing data (fastq.gz), and the corresponding library to your sequencing-technology. You can execute the pipeline from any directory as long as you define a working path for the analysis.


Execute:

bash 123456_pipeline.sh -i sample_name -w work_dir -s software

work_dir: working directory for the SV analysis
sample_name: name of the sequencing data, not including the '_1.fastq.gz' or '_2.fastq.gz' suffix. (If the sequencing data are SR2356_1.fastq.gz and SR2356_2.fastq.gz then sample_name=SR2356)
software: SV analysis software of your choice (lumpy or manta)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------


SOFTWARE REQUIREMENTS PER SCRIPT

script1:

fastqc: to produce quality control(qc) reports for each sample
multiqc: to combine multiple qc reports of different samples into one for better comparison
trimmomatic: trim special sequences (adapters, low quality reads, etc)


script2:

bwa mem: to map the trimmed reads with reference genome (h38)
picard: to mark and exclude duplicate reads arising from PCR amplification
samtools: to sort the the alignment file by coordinate (position and chromosome)
samtools: index the alignment file


script3:

samtools: to produce a file of discordant reads
samtools: to produce a file of split-reads 


script4: 

samtools: prepares a file containing the insert-size distribution of the reads and serves as an input for lumpy-sv to perform the SV analysis


5_lumpy_run:

lumpy: performs SV analysis and produces a variant file (.vcf)


manta_run:

manta: performs SV analysis and produces a compressed variant file (.vcf.gz)

