#!/bin/bash

source ./config.sh

if [[ ! -e $output_dir ]];then
        mkdir $output_dir/genotype
        mkdir $output_dir/genotype/svs
else
        rm -r  $output_dir/genotype/svs/*
fi

svtyper -B $work_dir/ref_map/${sample}_sorted.bam -i $work_dir/sv_call/lumpy/${sample}.vcf -l ${sample}.bam.json -o $work_dir/genotype/svs/${sample}_sv_genotypes.vcf
