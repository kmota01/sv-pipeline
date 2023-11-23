#!/bash/bin

source ./config.sh

#step 1: Define your variables(work_dir & sample) and create your workflow
python ./configManta.py --normalBam=/home/kmota01/test_align/ref_map/${sample}_sorted.bam --referenceFasta=/home/kmota01/h38/hg38.fa --runDir=$work_dir/sv_call/manta

#step 2: Run manta workflow
python $work_dir/sv_call/manta/runWorkflow.py
