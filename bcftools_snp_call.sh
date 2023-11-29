#!/bin/bash


source ./config.sh

#work_dir=/home/kmota01/test_align

if [[ ! -e $work_dir/var_call ]];then
        mkdir $work_dir/snp_call
else
	rm -r $work_dir/snp_call/*
fi

ref=/home/kmota01/h38
input_dir=$work_dir/ref_map
output_dir=$work_dir/snp_call
input_bam=$input_dir/*.bam
sample=$(echo $input_bam | awk -F '_sorted' '{print $1}' | awk -F '/' '{print $NF}')

bcftools mpileup -O b -o $output_dir/raw.bcf -f $ref/*.fa --threads 8 -q 20 -Q 30 ${sample}_withDups.bam | bcftools call --ploidy GRCh38 -m -v -o $output_dir/variants.raw.vcf -
grep -v -c '^#' > $output_dir/info_variants.txt
bcftools view -v snps $output_dir/variants.raw.vcf | grep -v -c '^#' >> $output_dir/info_variants.txt
bcftools view -v indels $output_dir/variants.raw.vcf | grep -v -c '^#' >> $output_dir/info_variants.txt
bcftools query -f '%POS\n' $output_dir/variants.raw.vcf >> $output_dir/no_variants.txt

