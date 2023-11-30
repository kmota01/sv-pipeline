# sv-pipeline
PIPELINE FOR DNA SEQUENCING ANALYSIS AND PREPARATION OF DATA FOR STRUCTURAL VARIANT DETECTION

script1  ---> Dna sequencing analysis
fastqc software: to produce quality control(qc) reports for each sample
multiqc software: to combine multiple  qc reports of different samples into one for better comparison
trimmomatic: trim special sequences (adapters, low quality reads, etc)

After trimming quality control steps are repeated to compare if the trimming results are of higher quality than the ones of raw reads(before trimming)

script2: --->  Dna sequencing analysis
bwa mem: to map the trimmed reads with reference genome (h38)
picard tools: to exclude duplicate reads arising from PCR amplification
samtools: to sort the the alignment file by coordinate (position and chromosome)
samtools: index the alignment file

script3: ---> Prepare data for SV analysis
samtools: to produce a file of discordant reads (reads that don't align properly to the reference, may have unexpected insert size, or wrong orientation)
samtools: to produce a file of split-reads (reads that present non-continuous alignment to the reference)samtools: sort the above files by coordinate (position and chromosome)

The discordant and split-reads indicate the existance of structural variants and sometimes can even predict the exact breakpoints. They are used as input files in the SV analysis with lumpy software.

script4: ---> Prepare data for SV analysis with lumpy
samtools: prepares a file containing the insert-size distribution of the reads and  is used as an input for lumpy software that performs the SV analysis


#SCRIPT FOR SV ANALYSIS

lumpy_run.sh: ---> SV analysis
lumpy-sv software: performs SV analysis and produces a variant file (.vcf)

manta_run.sh  ---> SV analysis
manta software: performs SV analysis and produces a compressed variant file (.vcf.gz)
