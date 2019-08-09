# SpliceAI

## What's left to be done:

- [x]  Split a VCF file by samples and put into different directories

- [x]  Go into these subdirectories and further split by chromosome (an array on Phoenix or an array using WDL??)

- [ ] Run spliceAI only only files with chr extension (chr means they are split)

- [ ]  Merge all chromosomes together

- [ ]  Merge all samples together 

- [ ] Delete all files created in this pipeline other than the final ones

- [ ]  Compile this into a pipeline (WDL or Snakemake)


## Writing a sequential slurm script or writing a wdl

Sequential slurm script can be written as 

`srun -N 1 bash split_vcf.sh 0`
`srun -N 1 bash split_chrom.sh 1`