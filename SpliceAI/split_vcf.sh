#!/bin/bash

### Setting variables

## Set Variables ##
#while [ "$1" != "" ]; do
 #       case $1 in
  #              -i )                    shift
   #                                     VCF=$1
    #                                    ;;
     #           -o )                    shift
      #                                  OUTDIR=$1
       #                                 ;;
        #        * )                     usage
         #                               exit 1
       # esac
        #shift
#done

#if [ -z "$INDIR" ]; then # If no input directory specified then do not proceed
 #       usage
  #      echo "#ERROR: No VCF file found."
   #     exit 1
#fi

#fi
#if [ -z "$OUTDIR" ]; then 
 #       usage
  #      echo "No output directory specified"
#fi



echo "Splittig files by sample for $VCF"

VCF=$1
OUTDIR=$2

cd $OUTDIR

for sample in `bcftools query -l $VCF`; 
do
  echo "Splitting $sample from $VCF"
  bcftools view -c1 -Oz -s $sample -o ${VCF/.vcf*/.$sample.vcf.gz} $VCF
  mkdir ${sample}_dir 
  mv ${VCF/.vcf*/.$sample.vcf.gz} ${sample}_dir

done 

#echo "Splitting done"
#echo "Moving all output directories to $OUTDIR"

#mv *_dir $OUTDIR
### change this script so that a separate folder is created for each sample 

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
