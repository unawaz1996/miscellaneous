#!/bin/bash

#### Splits VCF by samples 

VCF=$1
OUTDIR=$2

echo "Splittig files by sample for $VCF"

for file in $VCF; do
  for sample in `bcftools query -l $file`; do
    echo "Splitting $sample from $file"
    bcftools view -c1 -Oz -s $sample -o ${file/.vcf*/.$sample.vcf.gz} $file
    mkdir ${sample}_dir 
    mv ${file/.vcf*/.$sample.vcf.gz} ${sample}_dir
  done
done 

echo "Splitting done"
echo "Moving all output directories to $OUTDIR"

mv *_dir $OUTDIR
### change this script so that a separate folder is created for each sample 


#(Another slurm job?)
### split by chromosome 
## Get chromosomes that are present in the VCF:
#cat $1 | mawk '$1 ~ /^#/ {next} {print $1 | "sort -k1,1 -u"}' > ${1%.vcf}_chrs.txt

## Compress & index file with tabix:
#cat $1 | mawk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' | bgzip -c > ${1%.vcf}_sorted.vcf.gz
#tabix -p vcf ${1%.vcf}_sorted.vcf.gz

## Extract files by chr:
#cat ${1%.vcf}_chrs.txt | parallel "tabix -h ${1%.vcf}_sorted.vcf.gz {} > ${1%.vcf}_{}.vcf"





### attempting to split a VCF
# maybe by samples instead of chromosomes 
### command that Mark has provided me 
# MARK's COMMAND 
#bcftools view -O z -o 28782.hg19.vcf.gz -s 28782 -f "PASS" WGS-Feb2017.vcf.gz && tabix 28782.hg19.vcf.gz 




## command meaning for bcftools query 
# -l print list of samples 
## command meaning for bcftools view


# -o output file name 
# -O Output file type: b: compressed BCF, u: uncompressed BCF, z: compressed VCF, v: uncompressed VCF [v]
# -s comma separated list of samples to include 
# -f apply filters 
