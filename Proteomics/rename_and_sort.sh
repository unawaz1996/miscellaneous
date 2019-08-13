#!/bin/bash


## Date: 03/08/18


#replace space with underscore on all files
find . -type f -name "* *.csv" -exec rename "s/\s/_/g" {} \; 

### removing the first lines from file before proteomic analysis

sed -i '1,62d' *.csv

mkdir Preprocessed_data && mv *.csv Preprocessed_data

cd Preprocessed_data

files=$(ls *.csv)

for f in ${files} ;
do
  filename=${f%.csv}
  awk '!x[$2]++' ${filename}.csv > ${filename}_uniq.csv

done

echo $(date +"[%b %d %H:%M:%S] preprossing complete :-)")
