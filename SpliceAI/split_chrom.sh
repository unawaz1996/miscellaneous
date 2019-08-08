#!/bin/bash 
### split by chromosome 
## Needs to go down to each specific subdirectory 
## Get chromosomes that are present in the VCF:

OUTPUT=$1
cd $OUTPUT

for dir in *_dir; do
    for file in `ls $dir`; do
        echo "Splitting $file by chromosome"
        cd $dir
        zcat $file | mawk '$file ~ /^#/ {next} {print $file | "sort -k1,1 -u"}' > ${file%.vcf}_chrs.txt
        ## Compress & index file with tabix:
        zcat $file | mawk '$file ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' | bgzip -c > ${file%.vcf}_sorted.vcf.gz
        tabix -p vcf ${file%.vcf}_sorted.vcf.gz

        ## Extract files by chr:
        cat ${file%.vcf}_chrs.txt | parallel "tabix -h ${file%.vcf}_sorted.vcf.gz {} > ${file%.vcf}_{}.vcf"
        cd ../
    done    
done 

## Mawk scans patterns

### need to turn this into a slurm script 
