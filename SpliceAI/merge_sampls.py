import os 
import fnmatch 
from bioinfokit import analys 


for path, dirs, files in os.walk('.')  # change this to the name of the outdir
    for files in files: 
        if fnmatch.fnmatch(file, '_chrom_merged.vcf')
        analys.mergevcf("namesofsameples")