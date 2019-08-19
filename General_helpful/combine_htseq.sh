#!/bin/bash

FILES=$(ls -t -v *.txt | tr '\n' ' ');

awk 'NF > 1{ a[$1] = a[$1]"\t"$2} END {for( i in a ) print i a[i]}' $FILES > merged.tmp