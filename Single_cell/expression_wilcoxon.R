library(ggplot2)
library(pheatmap)
library(tibble)
library(magrittr)

###### loading the file 
#### can still supply a list of genes 

### loading the expression analysis 
Cluster<-read.table("../WGCNA_clusteridentities.txt",sep="\t",row.names=1,header=T) ### reading the clusters
Data<-read.table("../celldiversity_matrix_011316.txt",sep="\t",row.names=1,header=T) ### cell diversity data
Tsne<-read.table("../celldiversity_tsnecoordinates_011316.txt", sep="\t",row.names=1,header=T) ###cell diversity tsne coordinate
data<-log10(t(Data[,row.names(Tsne)])+1)
cluster<-Cluster[row.names(Tsne),1]


types<-unique(cluster)
keys<-cluster

analyse <- function(gene){
  id<-0;
  id2<-0;
  for(i in 1: length(types)){
    a<-data[which(keys==types[i]),gene]
    b<-data[-which(keys==types[i]),gene]
    id[i]<-wilcox.test(a,b)[3]
    id2[i]<-log((length(which(a>0))/length(a))/(length(which(b>0))/length(b)))}
  G<-data.frame(cbind(types,unlist(id), id2))
  G[,1]<-types
  colnames(G) <- c("Types", "pvalue", "foldChange")
  G[,2]<-p.adjust(G[,2], method = "bonferroni", n = length(types))
  head(G)
  write.csv(G, paste0(gene, ".csv"), row.names = FALSE)
  D <-data.frame(cbind(keys,data[,gene]));D[,1]<-keys
  write.csv(D, paste0(gene, "_log_cpm.csv"))
  ggplot(D,aes(factor(D[,1]),D[,2]))+ geom_violin() +geom_jitter() + theme(axis.text.x = element_text(angle = 90, hjust = 1))+ labs(x= "",y=gene) +
    coord_flip() + scale_x_discrete(limits = rev(levels(D[,1])))
  ggsave(paste0(gene, "_violin.pdf"), 
         plot=last_plot())
}

lapply(list_of_genes, analyse)
