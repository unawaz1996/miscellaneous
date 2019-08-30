#!/bin/bash 

#SBATCH -J spliceAI
#SBATCH -o /fast/users/%u/launch/slurm-%j.out
#SBATCH -A robinsion 
#SBATCH -p batch 
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --time=1:00:00
#SBATCH --mem=15GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=urwah.nawaz@adelaide.edu.au


### loading the modules 
module load Python/3.6.1-foss-2016b

source $spliceaiDIR/bin/activate 

INDIR=/fast/users/a1654797/Urwah_SpliceAI
OUTDIR=/fast/users/a1654797/Urwah_SpliceAI/output
REF=
ANNOT=

if [ -d $OUTDIR]; then 
    echo "$OUTDIR exists"
else
    mkdir -p $OUTDIR
fi

QUERIES=($(ls $INDIR/*.vcf | xargs -n 1 basename))

spliceai -I ${INDIR}/${QUERIES[$SLURM_ARRAY_TASK_ID]} -O ${QUERIES[$SLURM_ARRAY_TASK_ID]}.vcf -R ref.fa -A annot_file 

deactivate 


