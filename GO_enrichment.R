###GO enrichment
#if (!requireNamespace("BiocManager", quietly = TRUE))
#install.packages("BiocManager")
  
#BiocManager::install("topGO")
  
library(topGO)
library(dplyr)
library(data.table)
getwd()
#setwd("F:/GO/")
d=read.table("GO.txt",header=T)
colnames(d)=c("gene_id","go_id")

d$gene_id=as.character(d$gene_id)
d$go_id=as.character(d$go_id)
all_go <- lapply(split(d, sub("\\.\\d+$", "", d[, 1])), function(x) unique(x[, 2]))

geneNames=names(all_go)

gene=fread("specific_genename.txt",header=T)
colnames(gene)=c("geneid")
outlier_gene = as.vector(gene$geneid)
head(outlier_gene)
geneList=factor(as.integer(geneNames %in% outlier_gene))
names(geneList)=geneNames
head(geneList)
GOdata <- new("topGOdata", ontology = "BP", allGenes = geneList,annot=annFUN.gene2GO, gene2GO = all_go)
restRes=runTest(GOdata,algorithm="classic",statistic="fisher")
restRes
genetable <- GenTable(GOdata, p.value = restRes, orderBy = "p.value")
###choose GO term with pvalue <0.01??????????????????????????15??P<0.01??????restRes??????
gene_table=GenTable(GOdata,Fisher.p=restRes,topNodes=165)
###Nontrivial nodes: 41??????nodes??????????????Q??(FDR)????restRes??????
gene_table_total=GenTable(GOdata,Fisher.p=restRes,topNodes=1992)
allGO = usedGO(GOdata)
pvalues=gene_table_total$Fisher.p
gene_table$adjust.p=round(head(p.adjust(pvalues,method="BH"),165),10)
write.table(gene_table,file="specific.csv",sep=",", quote=F, row.names=F, col.names=T)


