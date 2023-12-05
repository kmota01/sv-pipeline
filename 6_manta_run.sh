#!/bash/bin

source ./config.sh
manta_dir='/home/kmota01/apps/manta-1.6.0.centos6_x86_64/bin'

if ! [ -d $work_dir/sv_call/manta ]; then
        mkdir $work_dir/sv_call/manta
else
	rm $work_dir/sv_call/manta/*
fi

#step 1: Define your variables(work_dir & sample) and create your workflow
python $manta_dir/configManta.py --normalBam=$work_dir/ref_map/${sample}.bam --referenceFasta=/home/kmota01/h38/hg38.fa --runDir=$work_dir/sv_call/manta

#step 2: Run manta workflow
python $work_dir/sv_call/manta/runWorkflow.py


