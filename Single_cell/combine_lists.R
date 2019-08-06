
library(readr)
library(tibble)
library(dplyr)

my.file.list <- list.files(pattern="csv$")
column_names <- gsub(".csv", "", my.file.list)


#### creating a pvalue df
my.list.pvalue <- lapply(my.file.list, FUN=function(x) {
    read.table(x, header=TRUE, colClasses=c("NULL", "numeric","numeric"), sep =",")[,1]
})
my.pvalue.df <- do.call("cbind", my.list.pvalue)
colnames(my.pvalue.df) <- column_names

#### creating a logFC df

my.list.FC <- lapply(my.file.list, FUN= function(x){
    read.table(x, header=TRUE, colClasses=c("NULL", "numeric", "numeric", sep = ","), sep = ",")[,2]
})

my.logFC.df <- do.call("cbind", my.list.FC)
colnames(my.pvalue.df) <- column_names

####
arc <- read.csv("ARC.csv", header=TRUE, row.names = 1)
